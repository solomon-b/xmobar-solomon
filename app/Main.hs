{-# LANGUAGE LambdaCase #-}
module Main where

import           Xmobar
import qualified Web.FontAwesomeType as FA

data Icon =
    HDD
  | VolumeUp
  | VolumeDown
  | VolumeOff
  | Wifi
  | NoComment
  deriving Show

class Render a where
  render :: a -> String

instance Render Icon where
  render = \case
    HDD        -> showIcon FA.FaHddO
    VolumeUp   -> showIcon FA.FaVolumeUp
    VolumeDown -> showIcon FA.FaVolumeDown
    VolumeOff  -> showIcon FA.FaVolumeOff
    Wifi       -> showIcon FA.FaWifi
    NoComment  -> wrapIcon ['\62643']
    where
      showIcon :: FA.FontAwesome -> String
      showIcon = wrapIcon . pure . FA.fontAwesomeChar

      wrapIcon :: String -> String
      wrapIcon str = mconcat ["<fn=1>", str, "</fn>"]

config :: Config
config = defaultConfig
  { font = "xft:Bitstream Vera Sans Mono:size=11:bold:antialias=true"
  , additionalFonts = ["xft:Font Awesome 5 Free Solid:style=Solid:size=11"]
  , allDesktops  = False
  , pickBroadest = True
  , bgColor      = "#2d2d2d"
  , fgColor      = "#515151"
  , alpha        = 175
  , position     = Static { xpos = 0, ypos = 0, width = 1920, height = 23 } --TopW L 95
  , commands = [
        Run StdinReader
      , Run $ DiskU [("/", render HDD <> " <used>/<size>")] ["-L","20","-H","50","-m","1","-p","3"] 20
      , Run $ Volume "default" "Master"
          [ "-t", "<status> <volume>%" , "--", "-O", render VolumeUp, "-o", render VolumeOff, "-C", "#585858" ] 1
      , Run $ Com "acpiPower" [] "battery" 100
      , Run $ Com "dunstStatus" [] "dunstStatus" 10
      , Run $ Date "<fc=#ffcc66>%a %b %_d %Y %I:%M %p</fc>" "date" 9
      , Run $ Wireless "wlp4s0" [ "--template" , render Wifi <> " <essid>" ] 10
              ]
  , sepChar = "%"
  , alignSep = "}{"
  , template = "%StdinReader% }{ %disku% %default:Master% %battery% %wlp4s0wi% %dunstStatus% %date%          "
  }

main :: IO ()
main = xmobar config
