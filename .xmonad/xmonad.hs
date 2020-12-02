--imports

import XMonad
import Data.Monoid
import System.Exit
import XMonad.Hooks.ManageDocks
import XMonad.Util.SpawnOnce
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Util.Run
import XMonad.Hooks.EwmhDesktops
import XMonad.Actions.WindowMenu
import XMonad.Hooks.DynamicLog
import XMonad.Actions.Submap
import Graphics.X11.ExtraTypes.XF86
import XMonad.Actions.Volume
import XMonad.Prompt
import XMonad.Actions.GridSelect
import XMonad.Prompt.Shell
import XMonad.Prompt.Man
import XMonad.Actions.WindowBringer
import XMonad.Prompt.Shell
import XMonad.Prompt.FuzzyMatch
import XMonad.Prompt.Theme
import XMonad.ManageHook
import XMonad.Layout.NoBorders
import XMonad.Util.NamedScratchpad
import XMonad.Hooks.InsertPosition
import XMonad.Layout.Fullscreen
import XMonad.Layout.Grid
import Graphics.X11.Xlib
import Graphics.X11.Xlib.Extras
import XMonad.Layout.Accordion
import XMonad.Layout.Spiral
import Data.Tree
import XMonad.Layout.TwoPane
import XMonad.Layout.DwmStyle
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import qualified XMonad.Prompt         as P
import qualified XMonad.Actions.Submap as SM
import qualified XMonad.Actions.Search as S

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

myTerminal :: String
myTerminal = "st"

myBrowser :: String
myBrowser = "firefox"

myModMask :: KeyMask
myModMask = mod4Mask

myFocusFollowsMouse :: Bool

myFocusFollowsMouse = True

myClickJustFocuses :: Bool

myClickJustFocuses = False

myBorderWidth   = 2

myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

--myNormalBorderColor  = "dddddd"

myFocusedBorderColor = "#bd93f9"

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm                  ,  xK_t                    ), spawn $ XMonad.terminal conf)
    , ((modm                  ,  xK_space                ), shellPrompt promptconfig)
    , ((modm                  ,  xK_q                    ), kill)
    , ((modm                  ,  xK_n                    ), sendMessage NextLayout)
    , ((modm .|. shiftMask    ,  xK_n                    ), setLayout $ XMonad.layoutHook conf)
    , ((modm                  ,  xK_a                    ), gotoMenu)
    , ((modm .|. shiftMask    ,  xK_a                    ), bringMenu)
    , ((modm                  ,  xK_Tab                  ), windows W.focusDown)
    , ((modm                  ,  xK_j                    ), windows W.focusDown)
    , ((modm                  ,  xK_k                    ), windows W.focusUp)
    , ((modm                  ,  xK_m                    ), windows W.focusMaster)
    , ((modm                  ,  xK_Return               ), windows W.swapMaster)
    , ((modm .|. shiftMask    ,  xK_j                    ), windows W.swapDown)
    , ((modm .|. shiftMask    ,  xK_k                    ), windows W.swapUp)
    , ((modm                  ,  xK_h                    ), sendMessage Shrink)  
    , ((modm                  ,  xK_p                    ), sendMessage NextLayout)
    , ((modm                  ,  xK_l                    ), sendMessage Expand)
    , ((modm .|. shiftMask    ,  xK_t                    ), withFocused $ windows . W.sink)
    , ((modm                  ,  xK_comma                ), sendMessage (IncMasterN 1))
    , ((modm                  ,  xK_period               ), sendMessage (IncMasterN (-1)))
    , ((modm .|. shiftMask    ,  xK_c                    ), io (exitWith ExitSuccess))
    , ((modm .|. controlMask  ,  xK_g                    ), sendMessage $ ToggleGaps)               -- toggle all gaps
    , ((modm .|. controlMask  ,  xK_f                    ), sendMessage ToggleStruts)
    , ((modm                  ,  xK_r                    ), shellPrompt promptconfig)
    , ((modm                  ,  xK_x                    ), spawn "~/.config/xmobar/xmenu.sh")
    , ((modm                  ,  xK_c                    ), spawn "xmonad --recompile; xmonad --restart")
    , ((modm .|. controlMask  ,  xK_s                    ), spawn "__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia steam")    --to launch steam with dedicated nvidia gpu on pop os
    , ((modm                  ,  xK_b                    ), spawn "firefox")
    , ((modm                  ,  xK_f                    ), spawn "pcmanfm")
    , ((modm                  ,  xK_Print                ), spawn "maim ~/hdd/screenshots/$(date +%s).png")
    , ((modm .|. controlMask  ,  xK_Print                ), spawn "maim -s ~/hdd/screenshots/$(date +%s).png")
    , ((modm .|. controlMask  ,  xK_c                    ), spawn "maim -s | xclip -selection clipboard -t image/png")
    , ((0                     ,  xF86XK_AudioRaiseVolume ), raiseVolume 4 >> return())                                                    --increase volume
    , ((0                     ,  xF86XK_AudioLowerVolume ), lowerVolume 4 >> return ())                                                   --decrease volume
    , ((0                     ,  xF86XK_AudioMute        ), spawn "pactl set-sink-mute 0 toggle")                                         --toggle mute
    , ((0                     ,  xF86XK_MonBrightnessUp  ), spawn "xbrightness -inc +5")                                                           --increase brightness
    , ((0                     ,  xF86XK_MonBrightnessDown), spawn "xbrightness -dec +5")                                                          --decrease brighrness  
    , ((modm                  ,  xK_s                    ), SM.submap $ searchEngineMap $ S.promptSearch promptconfig)                    --search engine submap
    , ((modm .|. shiftMask    ,  xK_s                    ), SM.submap $ searchEngineMap $ S.selectSearch)                                 --search from clipboard keymap
    , ((modm                  ,  xK_a), goToSelected defaultGSConfig)
    , ((modm .|. controlMask  ,  xK_t), namedScratchpadAction myScratchPads "terminal")
    , ((modm .|. controlMask  ,  xK_h), namedScratchpadAction myScratchPads "htop")
    ]
    ++
    [((m .|. modm, k), windows $ f i)                                                                                           --change workspace
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))                                                    --move windows to workspaces
        | (key, sc) <- zip [xK_w, xK_e, xK_i
        ] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]  
    ++
       [((modm .|. shiftMask , xK_p), submap . M.fromList $                                                                     --system power submaps
       [ ((0, xK_1),     spawn "systemctl suspend")
       , ((0, xK_2),     spawn "systemctl poweroff")
       , ((0, xK_3),     spawn "systemctl reboot")
       ])]	
     ++
       [((modm,          xK_o), submap . M.fromList $                                                                           --other prompts submaps
       [ ((0, xK_m),     manPrompt promptconfig) 
       , ((0,  xK_t),     themePrompt promptconfig)
       ])]
    -- ++
      -- [((modm .|. controlMask,          xK_p), submap . M.fromList $
      -- [ ((0,  xK_p),    passPrompt promptconfig)
      -- , ((0,  xK_g),    passGeneratePrompt promptconfig)
      -- , ((0,  xK_e),    passEditPrompt promptconfig)
      -- , ((0,  xK_r),    passRemovePrompt promptconfig)
      -- ])]
-----------------------------------------------------------------------------------------
--myScratchPads :: [NamedScratchpad]
myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                , NS "htop" spawnMocp findMocp manageMocp
                ]
  where
    spawnTerm  = myTerminal ++ " -n scratchpad"
    findTerm   = resource =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w
    spawnMocp  = myTerminal ++ " -n htop 'htop'"
    findMocp   = resource =? "htop"
    manageMocp = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w
-------------------------------------------------------------------------------------------
--add custom search engines

stackoverflow = S.searchEngine "stackoverflow" "https://stackoverflow.com/search?q="
archwiki = S.searchEngine "archwiki" "https://wiki.archlinux.org/index.php?search="
reddit = S.searchEngine "reddit" "https://www.reddit.com/search/?q="
urban = S.searchEngine "urban" "https://www.urbandictionary.com/define.php?term="
  
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--searchengines

searchEngineMap method = M.fromList $
                         [ ((0, xK_g), method S.google)
                          ,((0, xK_y), method S.youtube)
                          ,((0, xK_w), method S.wikipedia)
			  ,((0, xK_d), method S.duckduckgo)
			  ,((0, xK_s), method stackoverflow)
			  ,((0, xK_a), method archwiki)
                          ,((0, xK_r), method reddit )
                          ,((0, xK_u), method urban)
                         ]
                         
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--prompt config

promptconfig :: XPConfig
promptconfig = def
      { font                = "xft:Hack Bold:size=11:bold:antialias=true" 
      , bgColor             = "#282a36"
      , fgColor             = "#f8f8f2"
      , bgHLight            = "#c792ea"
      , fgHLight            = "#000000"
      , borderColor         = "#bd93f9"
      , promptBorderWidth   = 3
      , position            = Top--CenteredAt { xpCenterY = 0.3, xpWidth = 0.3 } 
      , height              = 20
      , historySize         = 256
      , historyFilter       = id
      , defaultText         = []
      , showCompletionOnTab = False
      , alwaysHighlight     = True
      , searchPredicate     = fuzzyMatch
      , maxComplRows        = Nothing
      }

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster))			-- mod-button1, Set the window to floating mode and move by dragging
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))				            	-- mod-button2, Raise the window to the top of the stack
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster))		-- mod-button3, Set the window to floating mode and resize by dragging
    ]

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Layouts:

myLayout = avoidStruts( Tall 1 (3/100) (1/2) ||| Full ||| simpleTabbed ||| Grid ||| ThreeColMid 1 (3/100) (1/2) ||| Accordion ||| spiral (6/7))
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Window rules:

myManageHook = composeAll
    [ className  =? "Steam"       --> doFloat
     ,className  =? "Pavucontrol" --> doFloat
     ,className  =? "vlc" --> doFloat
     ,className  =? "VirtualBox Manager" --> doFloat
     ,className =? "Steam"     --> doShift ( myWorkspaces !! 2 )
     ,className =? "csgo_linux64"     --> doShift ( myWorkspaces !! 3)]<+> namedScratchpadManageHook myScratchPads
     
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Event handling

myEventHook = mempty

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Status bars and logging for StdinReader 

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

_topXmobarPP h = xmobarPP {
    ppCurrent = xmobarColor "#50fa7b" "" . wrap "[" "]"
    , ppVisible = xmobarColor "#bd93f9" "" . wrap "" ""
    , ppHidden = xmobarColor "#f1fa8c" "" . wrap "" ""
    , ppHiddenNoWindows = xmobarColor "#c792ea" ""
    , ppSep = "<fc=#ffffff> | </fc>" 
    , ppTitle = xmobarColor "#8be9fd" "" . shorten 60
    , ppLayout = xmobarColor "#ff79c6" ""
    , ppOutput = hPutStrLn h
    , ppExtras  = [windowCount]
    , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]}
    

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Startup hook

myStartupHook = return ()
	  --spawnOnce "udiskie --no-automount --no-notify --tray &"

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
main :: IO ()
main = do 
  _topXmobar <- spawnPipe "xmobar -x 0 /home/sam/.config/xmobar/xmobar.config"
  xmonad $ docks $ ewmh def
     {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        focusedBorderColor = myFocusedBorderColor,
        keys               = myKeys,
        layoutHook         = spacingRaw True (Border 0 2 2 2) True (Border 2 2 2 2) True $ gaps [(U,25), (D,6), (R,6), (L,6)] $ smartBorders $ myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = dynamicLogWithPP $ _topXmobarPP _topXmobar,
        startupHook        = myStartupHook
    }
 
