module Main (main) where

import Lib
import Tes1

main :: IO ()
main = do migrateDB
          cobainsert
          putStrLn "halo"
