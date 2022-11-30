{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Main (main) where

import GHC.Generics
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import Data.Time.Calendar
import Data.Time.LocalTime
import Data.Int
import Data.Text.Lazy
import Web.Scotty
import Control.Monad.IO.Class
import Data.Aeson (FromJSON, ToJSON)

localPG :: ConnectInfo
localPG = defaultConnectInfo
        { connectHost = "127.0.0.1"
        , connectDatabase = "funpro"
        , connectUser = "postgres"
        , connectPassword = "12052001"
        }

data Jadwal = Jadwal
  { id_jadwal :: Int,
    nama_jadwal :: String,
    tanggal :: Day,
    waktu :: TimeOfDay,
    catatan :: String
  }
  deriving (Generic, Show)
instance ToJSON Jadwal
instance FromJSON Jadwal
instance FromRow Jadwal where
  fromRow = Jadwal <$> field <*> field <*> field <*> field <*> field

main :: IO()
main = do
  db <- connect localPG
  scotty 8000 $ do
    get "/" $ 
      do
        html "Hello!!"
    get "/jadwal" $ 
      do
        json =<< liftIO (getJadwal db)
    post "/jadwal" $
      do
        newJadwal <- jsonData :: ActionM Jadwal
        out <- liftIO (insertJadwal db newJadwal)
        html $ pack $ show $ fromInt64ToInt out

fromInt64ToInt :: Int64 -> Int
fromInt64ToInt = fromIntegral

getJadwal :: Connection -> IO [Jadwal]
getJadwal db = (query_ db "SELECT * FROM funpro.jadwal" :: IO [Jadwal])

insertJadwal :: Connection -> Jadwal -> IO Int64
insertJadwal db Jadwal {nama_jadwal = nama, tanggal = tgl, waktu = wkt, catatan = cat} =
  execute db "INSERT INTO funpro.jadwal(nama_jadwal, tanggal, waktu, catatan) VALUES (?, ?, ?, ?)" (nama :: String, tgl :: Day, wkt :: TimeOfDay, cat :: String)

-- https://stackoverflow.com/questions/33374136/using-postgres-simple-how-do-i-get-multiple-parameters-from-a-row
-- https://dev.to/cdimitroulas/a-very-simple-json-api-in-haskell-1jgk
-- https://hackage.haskell.org/package/scotty-0.12.1/docs/Web-Scotty.html # Web-Scotty documentation
-- https://hackage.haskell.org/package/postgresql-simple-0.6.5/docs/Database-PostgreSQL-Simple.html # Postgresql-simple documentation