module Main (main) where

import Tes1
import Tes2
import Database.Persist

main :: IO ()
main = do migrateDB
          startApp
