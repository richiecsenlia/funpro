module Main (main) where

import Server
import Database (migrateDB)

main :: IO ()
main = do migrateDB
          startApp
