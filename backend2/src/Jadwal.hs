{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Jadwal where

import GHC.Generics
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import Data.Time.Calendar
import Data.Time.LocalTime
import Data.Int
import Data.Text.Lazy
import Web.Scotty
import Control.Monad.IO.Class
import Network.Wai.Middleware.Cors
import Network.Wai
import Network.HTTP.Types
import Data.Aeson (FromJSON, ToJSON)

data Jadwal = Jadwal
  { id_jadwal :: Int,
    nama_jadwal :: String,
    tanggal :: Day,
    waktu :: TimeOfDay,
    catatan :: String,
    user_username :: String
  }
  deriving (Generic, Show)
instance ToJSON Jadwal
instance FromJSON Jadwal
instance FromRow Jadwal where
  fromRow = Jadwal <$> field <*> field <*> field <*> field <*> field <*> field

fromInt64ToInt :: Int64 -> Int
fromInt64ToInt = fromIntegral

getJadwal :: Connection -> String -> IO [Jadwal]
getJadwal db user = (query db "SELECT * FROM jadwal WHERE user_username = ?" [user :: String]) :: IO [Jadwal]

insertJadwal :: Connection -> Jadwal -> IO Int64
insertJadwal db Jadwal {nama_jadwal = nama, tanggal = tgl, waktu = wkt, catatan = cat, user_username = user}=
  execute db "INSERT INTO jadwal(nama_jadwal, tanggal, waktu, catatan, user_username) VALUES (?, ?, ?, ?, ?)" (nama :: String, tgl :: Day, wkt :: TimeOfDay, cat :: String, user :: String)

deleteJadwal :: Connection -> Int -> IO Int64
deleteJadwal db jadwalId = execute db "DELETE FROM jadwal WHERE id_jadwal = ?" [jadwalId :: Int]