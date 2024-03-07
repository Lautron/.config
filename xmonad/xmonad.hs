  -- Base
import XMonad
import System.Directory
import System.IO (hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

-- Actions
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.CycleWS (Direction1D(..), moveTo, shiftTo, WSType(..), nextScreen, prevScreen)
import XMonad.Actions.GridSelect
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.SpawnOn
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Actions.WithAll (sinkAll, killAll)
import qualified XMonad.Actions.Search as S

    -- Data
import Data.Char (isSpace, toUpper)
import Data.Maybe (fromJust)
import Data.Monoid
import Data.Maybe (isJust)
import Data.Tree
import Data.Ratio
import qualified Data.Map as M

    -- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, filterOutWsPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.EwmhDesktops  -- for some fullscreen events, also for xcomposite in obs.
import XMonad.Hooks.ManageDocks (avoidStruts, docks, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat, doCenterFloat)
import XMonad.Hooks.ServerMode
import XMonad.Hooks.SetWMName
import XMonad.Hooks.WorkspaceHistory

    -- Layouts
import XMonad.Layout.Accordion
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spiral
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns

    -- Layouts modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.Magnifier
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.WindowNavigation
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

   -- Utilities
import XMonad.Util.Dmenu
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce

myFont :: String
myFont = "xft:SauceCodePro Nerd Font Mono:regular:size=9:antialias=true:hinting=true"

myModMask :: KeyMask
myModMask = mod4Mask        -- Sets modkey to super/windows key

myTerminal :: String
myTerminal = "alacritty"    -- Sets default terminal

myBrowser :: String
myBrowser = "thor"  -- Sets qutebrowser as browser

myEmacs :: String
myEmacs = "emacsclient -c -a 'emacs' "  -- Makes emacs keybindings easier to type

myEditor :: String
-- myEditor = "emacsclient -c -a 'emacs' "  -- Sets emacs as editor
myEditor = myTerminal ++ " -e nvim "    -- Sets vim as editor

myBorderWidth :: Dimension
myBorderWidth = 2           -- Sets border width for windows

myNormColor :: String
myNormColor   = "#282c34"   -- Border color of normal windows

myFocusColor :: String
myFocusColor  = "#46d9ff"   -- Border color of focused windows

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

myWorkspaces = [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "]

myStartupHook :: X ()
myStartupHook = do
    spawnOnce "lxsession &"
    spawnOnce "dunst -conf ~/.config/dunst/dunstrc &"
    spawnOnce "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &"
    spawnOnce "picom -b --config ~/.config/dwm/picom.conf &"
    spawnOnce "redshift -P -O 7000 &"
    spawnOnce "config_tablet_buttons.sh &"
    spawnOnce "setxkbmap -option caps:none &"
    spawnOnce "sleep 20 && xmodmap ~/.Xmodmap &"
    spawnOnce "xset s 3600 3600 &"
    spawnOnce "reddit_notifs &"
    spawnOnce "xdg-settings set default-web-browser org.qutebrowser.qutebrowser.desktop &"
    spawnOnce "alarms.sh &"

    spawnOnce "feh --randomize --bg-fill ~/.config/wallpapers &"  -- feh set random wallpaper
    --spawnOnOnce (myWorkspaces !! 0) (myBrowser ++ " &")
    setWMName "LG3D"

myColorizer :: Window -> Bool -> X (String, String)
myColorizer = colorRangeFromClassName
                  (0x28,0x2c,0x34) -- lowest inactive bg
                  (0x28,0x2c,0x34) -- highest inactive bg
                  (0xc7,0x92,0xea) -- active bg
                  (0xc0,0xa7,0x9a) -- inactive fg
                  (0x28,0x2c,0x34) -- active fg

-- gridSelect menu layout
mygridConfig :: p -> GSConfig Window
mygridConfig colorizer = (buildDefaultGSConfig myColorizer)
    { gs_cellheight   = 40
    , gs_cellwidth    = 200
    , gs_cellpadding  = 6
    , gs_originFractX = 0.5
    , gs_originFractY = 0.5
    , gs_font         = myFont
    }

spawnSelected' :: [(String, String)] -> X ()
spawnSelected' lst = gridselect conf lst >>= flip whenJust spawn
    where conf = def
                   { gs_cellheight   = 40
                   , gs_cellwidth    = 200
                   , gs_cellpadding  = 6
                   , gs_originFractX = 0.5
                   , gs_originFractY = 0.5
                   , gs_font         = myFont
                   }

myAppGrid = [
              ("IS1 2022", myBrowser ++ " 'https://famaf-consultas.aulavirtual.unc.edu.ar/course/view.php?id=995'")
              ,("AdC 2022", myBrowser ++ " 'https://famaf-consultas.aulavirtual.unc.edu.ar/course/view.php?id=1023'")
              ,("BBDD 2022", myBrowser ++ " 'https://famaf-consultas.aulavirtual.unc.edu.ar/course/view.php?id=998'")
              ,("IS1", myBrowser ++ " 'https://famaf.aulavirtual.unc.edu.ar/course/view.php?id=179'")
              ,("AdC", myBrowser ++ " 'https://famaf.aulavirtual.unc.edu.ar/course/view.php?id=176'")
              ,("BBDD", myBrowser ++ " 'https://famaf.aulavirtual.unc.edu.ar/course/view.php?id=187'")
          ]

myScratchPads :: [NamedScratchpad]
myScratchPads = [ NS "spotify" spawnSpotify findSpotify manageSpotify
                , NS "calculator" spawnCalc findCalc manageCalc
                , NS "bullet" spawnBullet findBullet manageBullet
                ]
  where
    spawnSpotify = "spotify-launcher"
    findSpotify  = className =? "Spotify"
    manageSpotify = doFullFloat
    --customFloating $ W.RationalRect l t w h
              -- where
              --   h = 0.9
              --   w = 0.9
              --   t = 0.95 -h
              --   l = 0.95 -w
    spawnCalc  = "qalculate-gtk"
    findCalc   = className =? "Qalculate-gtk"
    manageCalc = customFloating $ W.RationalRect l t w h
               where
                 h = 0.5
                 w = 0.4
                 t = 0.75 -h
                 l = 0.70 -w

    spawnBullet  = "xournalpp ~/Documents/Menos_usados/Journaling/bullet_journal_2022.xopp"
    findBullet   = title =? "bullet_journal_2022.xopp - Xournal++"
    manageBullet = doFullFloat
    --customFloating $ W.RationalRect l t w h
    --           where
    --             h = 0.95
    --             w = 0.98
    --             t = 1 -h
    --             l = 1 -w

--Makes setting the spacingRaw simpler to write. The spacingRaw module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Below is a variation of the above except no borders are applied
-- if fewer than two windows. So a single window has no gaps.
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Defining a bunch of layouts, many that I don't use.
-- limitWindows n sets maximum number of windows displayed for layout.
-- mySpacing n sets the gap size around the windows.
tall     = renamed [Replace "tall"]
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 12
           $ mySpacing 4
           $ ResizableTall 1 (3/100) (1/2) []
magnifyLayout  = renamed [Replace "magnify"]
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ magnifier
           $ limitWindows 12
           $ mySpacing 8
           $ ResizableTall 1 (3/100) (1/2) []
--monocle  = renamed [Replace "monocle"]
--           $ smartBorders
--           $ windowNavigation
--           $ addTabs shrinkText myTabTheme
--           $ subLayout [] (smartBorders Simplest)
--           $ limitWindows 20 Full
floats   = renamed [Replace "floats"]
           $ smartBorders
           $ limitWindows 20 simplestFloat
--grid     = renamed [Replace "grid"]
--           $ smartBorders
--           $ windowNavigation
--           $ addTabs shrinkText myTabTheme
--           $ subLayout [] (smartBorders Simplest)
--           $ limitWindows 12
--           $ mySpacing 8
--           $ mkToggle (single MIRROR)
--           $ Grid (16/10)
--spirals  = renamed [Replace "spirals"]
--           $ smartBorders
--           $ windowNavigation
--           $ addTabs shrinkText myTabTheme
--           $ subLayout [] (smartBorders Simplest)
--           $ mySpacing' 8
--           $ spiral (6/7)
--threeCol = renamed [Replace "threeCol"]
--           $ smartBorders
--           $ windowNavigation
--           $ addTabs shrinkText myTabTheme
--           $ subLayout [] (smartBorders Simplest)
--           $ limitWindows 7
--           $ ThreeCol 1 (3/100) (1/2)
--threeRow = renamed [Replace "threeRow"]
--           $ smartBorders
--           $ windowNavigation
--           $ addTabs shrinkText myTabTheme
--           $ subLayout [] (smartBorders Simplest)
--           $ limitWindows 7
           -- Mirror takes a layout and rotates it by 90 degrees.
           -- So we are applying Mirror to the ThreeCol layout.
--           $ Mirror
--           $ ThreeCol 1 (3/100) (1/2)
tabs     = renamed [Replace "tabs"]
           -- I cannot add spacing to this layout because it will
           -- add spacing between window and tabs which looks bad.
           $ tabbed shrinkText myTabTheme
--tallAccordion  = renamed [Replace "tallAccordion"]
--           $ Accordion
--wideAccordion  = renamed [Replace "wideAccordion"]
--           $ Mirror Accordion

-- setting colors for tabs layout and tabs sublayout.
myTabTheme = def { fontName            = myFont
                 , activeColor         = "#46d9ff"
                 , inactiveColor       = "#313846"
                 , activeBorderColor   = "#46d9ff"
                 , inactiveBorderColor = "#282c34"
                 , activeTextColor     = "#282c34"
                 , inactiveTextColor   = "#d0d0d0"
                 }

-- Theme for showWName which prints current workspace when you change workspaces.
myShowWNameTheme :: SWNConfig
myShowWNameTheme = def
    { swn_font              = "xft:Ubuntu:bold:size=60"
    , swn_fade              = 1.0
    , swn_bgcolor           = "#1c1f24"
    , swn_color             = "#ffffff"
    }

-- The layout hook
myLayoutHook = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats
               $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
             where
               myDefaultLayout =     withBorder myBorderWidth tall
                                 ||| magnifyLayout
--                                 ||| noBorders monocle
                                 ||| noBorders tabs
--                                 ||| grid
--                                 ||| spirals
--                                 ||| threeCol
--                                 ||| threeRow
--                                 ||| tallAccordion

myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)

clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
     -- 'doFloat' forces a window to float.  Useful for dialog boxes and such.
     -- using 'doShift ( myWorkspaces !! 7)' sends program to workspace 8!
     -- I'm doing it this way because otherwise I would have to write out the full
     -- name of my workspaces and the names would be very long if using clickable workspaces.
     [ manageSpawn
     , className =? "confirm"         --> doFloat
     , className =? "file_progress"   --> doFloat
     , className =? "dialog"          --> doFloat
     , className =? "download"        --> doFloat
     , className =? "error"           --> doFloat
     , className =? "Gimp"            --> doFloat
     , className =? "Spotify"         --> doCenterFloat
     , className =? "notification"    --> doFloat
     , className =? "pinentry-gtk-2"  --> doFloat
     , className =? "splash"          --> doFloat
     , className =? "toolbar"         --> doFloat
     , className =? "Yad"             --> doCenterFloat
     , title =? "rate.sx"             --> centerCustomFloat 0.7 0.7
     , title =? "wttr.in"             --> centerCustomFloat 0.85 0.9
     , title =? "vimclip"             --> vimclipFloat 0.05 0.5 0.2
     , title =? "ttask"               --> centerCustomFloat 0.7 0.7
     , title =? "translate"           --> centerCustomFloat 0.7 0.7
     , isFullscreen -->  doFullFloat
     ] <+> namedScratchpadManageHook myScratchPads
     where
       centerCustomFloat w h = customFloating $ W.RationalRect l t w h
        where
          l = (1 - w)/2
          t = (1 - h)/2

       vimclipFloat y w h = customFloating $ W.RationalRect l y w h
        where
          l = (1 - w)/2


-- START_KEYS
myKeys :: [(String, X ())]
myKeys =
    -- KB_GROUP Xmonad
        [ ("M-C-r", spawn "xmonad --recompile")  -- Recompiles xmonad
        , ("M-S-r", spawn "xmonad --restart")    -- Restarts xmonad
        , ("M-S-q", io exitSuccess)              -- Quits xmonad
        , ("M-S-/", spawn "~/.xmonad/xmonad_keys.sh")

    -- KB_GROUP Run Prompt
        , ("M-p", spawn "dmenu_run -i") -- Dmenu

    -- KB_GROUP Other Dmenu Prompts
    -- In Xmonad and many tiling window managers, M-p is the default keybinding to
    -- launch dmenu_run, so I've decided to use M-p plus KEY for these dmenu scripts.
        -- , ("M-p p", spawn "passmenu")     -- passmenu

    -- KB_GROUP Useful programs to have a keybinding for launch
        , ("M-S-<Return>", spawn (myTerminal))

    -- KB_GROUP Kill windows
        , ("M-S-c", kill1)     -- Kill the currently focused client
        , ("M-S-a", killAll)   -- Kill all windows on current workspace

    -- KB_GROUP Floating windows
        , ("M-S-f", sendMessage (T.Toggle "floats")) -- Toggles my 'floats' layout
        , ("M-t", withFocused $ windows . W.sink)  -- Push floating window back to tile
        , ("M-S-t", sinkAll)                       -- Push ALL floating windows to tile

    -- KB_GROUP Increase/decrease spacing (gaps)
        , ("C-M1-j", decWindowSpacing 4)         -- Decrease window spacing
        , ("C-M1-k", incWindowSpacing 4)         -- Increase window spacing
        , ("C-M1-h", decScreenSpacing 4)         -- Decrease screen spacing
        , ("C-M1-l", incScreenSpacing 4)         -- Increase screen spacing

    -- KB_GROUP Grid Select (CTR-g followed by a key)
        , ("M-g", spawnSelected' myAppGrid)                 -- grid select favorite apps
       -- , ("M-g t", goToSelected $ mygridConfig myColorizer)  -- goto selected window
       -- , ("M-g b", bringSelected $ mygridConfig myColorizer) -- bring selected window

    -- KB_GROUP Windows navigation
        , ("M-m", windows W.focusMaster)  -- Move focus to the master window
        , ("M-j", windows W.focusDown)    -- Move focus to the next window
        , ("M-k", windows W.focusUp)      -- Move focus to the prev window
        , ("M-S-m", windows W.swapMaster) -- Swap the focused window and the master window
        , ("M-S-j", windows W.swapDown)   -- Swap focused window with next window
        , ("M-S-k", windows W.swapUp)     -- Swap focused window with prev window
        , ("M-<Return>", promote)      -- Moves focused window to master, others maintain order
        , ("M-S-<Tab>", rotSlavesDown)    -- Rotate all windows except master and keep focus in place
        , ("M-C-<Tab>", rotAllDown)       -- Rotate all the windows in the current stack

    -- KB_GROUP Layouts
        , ("M-<Tab>", sendMessage NextLayout)           -- Switch to next layout
        , ("M-b", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts) -- Toggles noborder/full

    -- KB_GROUP Increase/decrease windows in the master pane or the stack
        , ("M-S-<Up>", sendMessage (IncMasterN 1))      -- Increase # of clients master pane
        , ("M-S-<Down>", sendMessage (IncMasterN (-1))) -- Decrease # of clients master pane
        , ("M-C-<Up>", increaseLimit)                   -- Increase # of windows
        , ("M-C-<Down>", decreaseLimit)                 -- Decrease # of windows

    -- KB_GROUP Window resizing
        , ("M-h", sendMessage Shrink)                   -- Shrink horiz window width
        , ("M-l", sendMessage Expand)                   -- Expand horiz window width
        , ("M-M1-j", sendMessage MirrorShrink)          -- Shrink vert window width
        , ("M-M1-k", sendMessage MirrorExpand)          -- Expand vert window width

    -- KB_GROUP Scratchpads
    -- Toggle show/hide these programs.  They run on a hidden workspace.
    -- When you toggle them to show, it brings them to your current workspace.
    -- Toggle them to hide and it sends them back to hidden workspace (NSP).
        , ("M-s s", namedScratchpadAction myScratchPads "spotify")
        , ("M-s c", namedScratchpadAction myScratchPads "calculator")
        , ("M-s b", namedScratchpadAction myScratchPads "bullet")


    -- KB_GROUP Multimedia Keys
    -- Replace with spotify
        , ("<XF86AudioPlay>", spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause")
        , ("<XF86AudioStop>", spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop")
        , ("<XF86AudioNext>", spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous")
        , ("<XF86AudioPrev>", spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next")
        , ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
        , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
        , ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
        , ("<Print>", spawn "flameshot gui")

    -- Custom Hotkeys
        --, ("M-f", spawn (myTerminal ++ " -e fish -C ranger"))
        , ("M-f", spawn (myTerminal ++ " -e fish -C 'lf'"))
        , ("M-i", spawn (myTerminal ++ " -t vimclip -e vimclip"))
        , ("M-c r", spawn (myTerminal ++ " --hold -t rate.sx -e curl rate.sx"))
        , ("M-c w", spawn (myTerminal ++ " --hold -t wttr.in -e curl wttr.in/Cordoba+capital"))
        , ("M-c t", spawn (myTerminal ++ " --hold -t translate -e trslt"))
        , ("M1-x l", spawn "xmind_shortcut.sh")
        , ("M3-h", spawn "xdotool keyup h key --clearmodifiers Left")
        , ("M3-j", spawn "xdotool keyup j key --clearmodifiers Down")
        , ("M3-k", spawn "xdotool keyup k key --clearmodifiers Up")
        , ("M3-l", spawn "xdotool keyup l key --clearmodifiers Right")
        , ("M3-w", spawn "xdotool keyup w key --clearmodifiers ctrl+Right")
        , ("M3-b", spawn "xdotool keyup b key --clearmodifiers ctrl+Left")
        , ("M3-S-w", spawn "xdotool keyup W key --clearmodifiers ctrl+shift+Right")
        , ("M3-S-b", spawn "xdotool keyup B key --clearmodifiers ctrl+shift+Left")
        , ("M-o", spawn myBrowser)
        --, ("M1-t", spawn (myBrowser ++ " :'open -w https://track.toggl.com/timer'"))
        , ("M1-t", spawn "ttask")
        ]
    -- The following lines are needed for named scratchpads.
          where nonNSP          = WSIs (return (\ws -> W.tag ws /= "NSP"))
                nonEmptyNonNSP  = WSIs (return (\ws -> isJust (W.stack ws) && W.tag ws /= "NSP"))
-- END_KEYS

main :: IO ()
main = do
    -- Launching three instances of xmobar on their monitors.
    xmproc0 <- spawnPipe "xmobar -x 0 $HOME/.config/xmobar/xmobar.config"


    -- the xmonad, ya know...what the WM is named after!
    xmonad $ ewmh $ docks $ def
        { manageHook         = myManageHook <+> manageDocks
        --, handleEventHook    = docksEventHook
                               -- Uncomment this line to enable fullscreen support on things like YouTube/Netflix.
                               -- This works perfect on SINGLE monitor systems. On multi-monitor systems,
                               -- it adds a border around the window if screen does not have focus. So, my solution
                               -- is to use a keybinding to toggle fullscreen noborders instead.  (M-<Space>)
                               -- <+> fullscreenEventHook
        , modMask            = myModMask
        , terminal           = myTerminal
        , startupHook        = myStartupHook
        , layoutHook         = showWName' myShowWNameTheme $ myLayoutHook
        , workspaces         = myWorkspaces
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myNormColor
        , focusedBorderColor = myFocusColor
        , logHook = dynamicLogWithPP $ filterOutWsPP [scratchpadWorkspaceTag] $ xmobarPP
              -- the following variables beginning with 'pp' are settings for xmobar.
              { ppOutput = \x -> hPutStrLn xmproc0 x                          -- xmobar on monitor 1
                            -- >> hPutStrLn xmproc1 x                          -- xmobar on monitor 2
                             -- >> hPutStrLn xmproc2 x                          -- xmobar on monitor 3
              , ppCurrent = xmobarColor "#c792ea" "" . wrap "<box type=Bottom width=2 mb=2 color=#c792ea>" "</box>"         -- Current workspace
              , ppVisible = xmobarColor "#c792ea" "" . clickable              -- Visible but not current workspace
              , ppHidden = xmobarColor "#82AAFF" "" . wrap "<box type=Top width=2 mt=2 color=#82AAFF>" "</box>" . clickable -- Hidden workspaces
              , ppHiddenNoWindows = xmobarColor "#82AAFF" ""  . clickable     -- Hidden workspaces (no windows)
              , ppTitle = xmobarColor "#b3afc2" "" . shorten 60               -- Title of active window
              , ppSep =  "<fc=#666666> <fn=1>|</fn> </fc>"                    -- Separator character
              , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"            -- Urgent workspace
              , ppExtras  = [windowCount]                                     -- # of windows current workspace
              , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]                    -- order of things in xmobar
              }
        } `additionalKeysP` myKeys

