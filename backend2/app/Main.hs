{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Main (main) where

import Database.PostgreSQL.Simple
import Data.Text.Lazy
import Web.Scotty
import Control.Monad.IO.Class
import Network.Wai.Middleware.Cors
import Network.Wai
import Network.HTTP.Types
import User
import Jadwal

localPG :: ConnectInfo
localPG = defaultConnectInfo
        { connectHost = "db.gnvlenttjmyipsadlofe.supabase.co"
        , connectDatabase = "postgres"
        , connectUser = "postgres"
        , connectPassword = "Rt9GTWC2pSP1mvsB"
        }

corsPolicy :: Middleware
corsPolicy = cors (const $ Just policy)
  where
    policy = simpleCorsResourcePolicy
      { 
        corsMethods = [methodGet,methodPost,methodPut,methodHead,methodOptions,methodDelete],
        corsRequestHeaders = [hContentType,hAuthorization]          
      }

main :: IO()
main = do
  db <- connect localPG
  scotty 8000 $ do
    middleware corsPolicy
    get "/" $ 
      do
        html "Hello!!"
    get "/jadwal/:username" $ 
      do
        getUsername <- param "username"
        json =<< liftIO (getJadwal db getUsername)
    post "/jadwal/" $
      do
        newJadwal <- jsonData :: ActionM Jadwal
        out <- liftIO (insertJadwal db newJadwal)
        html $ pack $ show $ fromInt64ToInt out
    delete "/delete-jadwal/:jadwalId" $
      do
        jadwalId <- param "jadwalId"
        out <- liftIO (deleteJadwal db jadwalId)
        html $ pack $ show $ fromInt64ToInt out
    get "/user" $
      do
        name <- param "username"
        pass <- param "password"
        json =<< liftIO (getUser db (name,pass))
    post "/user" $
      do
        newUser <- jsonData :: ActionM User
        out <- liftIO(createUser db newUser)
        json =<< liftIO (getUser db (extractNP newUser))

-- ref/docs:
-- https://stackoverflow.com/questions/33374136/using-postgres-simple-how-do-i-get-multiple-parameters-from-a-row
-- https://dev.to/cdimitroulas/a-very-simple-json-api-in-haskell-1jgk
-- https://hackage.haskell.org/package/scotty-0.12.1/docs/Web-Scotty.html # Web-Scotty documentation
-- https://hackage.haskell.org/package/postgresql-simple-0.6.5/docs/Database-PostgreSQL-Simple.html # Postgresql-simple documentation
