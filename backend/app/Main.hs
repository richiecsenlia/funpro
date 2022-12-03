module Main (main) where

import MainServer
import Database
import Database2
main :: IO ()
main = do
        migrateDB
        migrateDB2
        startApp
