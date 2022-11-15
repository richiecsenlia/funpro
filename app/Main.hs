module Main (main) where

import Tes1
import Tes2
import Database.Persist

main :: IO ()
main = do migrateDB
          cobaupdate1
          cobaupdate2
          cobaupdate3
          isi <- cobaGet
          print(map entityVal isi)
