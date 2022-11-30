module Main (main) where

import Tes1
import Tes2

main :: IO ()
main = do
        migrateDB
        startApp
