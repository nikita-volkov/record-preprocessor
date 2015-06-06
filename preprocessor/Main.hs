module Main where

import BasePrelude
import System.IO
import Conversion
import Conversion.Text
import Record.Syntax
import qualified Data.Text.IO as Text
import qualified Data.Text.Lazy.IO as LazyText


main =
  do
    [sourcePath, inputPath, outputPath] <- getArgs
    inHandle <- openFile inputPath ReadMode
    outHandle <- openFile outputPath WriteMode

    Text.hGetContents inHandle >>= return . processModule >>= \case
      Left x -> do
        hPutStrLn stderr $ formatError x
        hFlush outHandle
        exitWith $ ExitFailure 1
      Right x -> do
        LazyText.hPutStrLn outHandle $ convert $ x
        hFlush outHandle
        exitWith $ ExitSuccess
  where
    formatError ((line, column), message) =
      "Error at " <> show line <> ":" <> show column <> ": " <> message
