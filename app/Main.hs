{-# LANGUAGE ImportQualifiedPost #-}

module Main where

--------------------------------------------------------------------------------

import App
import Options.Applicative qualified as Opt
import Xmobar
import Options.Applicative ((<**>))

--------------------------------------------------------------------------------

parseInterface :: Opt.Parser InterfaceName
parseInterface =
  InterfaceName <$> Opt.strOption (Opt.long "network" <> Opt.short 'n' <> Opt.metavar "INTERFACE" <> Opt.help "Wireles network interface to monitor")

main :: IO ()
main =
  let opts = Opt.info (parseInterface <**> Opt.helper) Opt.fullDesc
  in Opt.execParser opts >>= xmobar . config
