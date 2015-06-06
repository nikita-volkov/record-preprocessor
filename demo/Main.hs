module Main where

import BasePrelude
import Control.Lens.Basic


type Person =
  {! name :: String, birthday :: {! year :: Int, month :: Int, day :: Int } }

person =
  {! 
    name = "Yuri Alekseyevich Gagarin", 
    birthday = {! year = 1934, month = 3, day = 9 },
    country = {! name = "Soviet Union", language = "Russian" }
  }

main = do
  putStrLn $ "Name: " <> show (view @name person)
  putStrLn $ "Country: " <> show (view (@country . @name) person)



