{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE OverloadedStrings #-}

module Server
  ( startApp,
    app,
  ) where

import Control.Monad.IO.Class (liftIO)
import Data.Int (Int64)
import Network.Wai
import Network.Wai.Handler.Warp
import Servant
import Database.Persist (Entity)

import Model
import Database

type NotesAPI = "notes" :> Get '[JSON] [Entity Note]
           :<|> "notes" :> ReqBody '[JSON] Note :> Post '[JSON] Int64
           :<|> "notes" :> Capture "id" Int64 :> ReqBody '[JSON] Note :> Post '[JSON] ()

notesAPI :: Proxy NotesAPI
notesAPI = Proxy

createNoteHandler :: Note -> Handler Int64
createNoteHandler note = liftIO $ createNote note

getAllNoteHandler :: Handler [Entity Note]
getAllNoteHandler = liftIO $ getAllNote

updateNoteHandler :: Int64 -> Note -> Handler ()
updateNoteHandler id note = liftIO $ updateNoteById id note

notesServer :: Server NotesAPI
notesServer = getAllNoteHandler :<|> createNoteHandler :<|> updateNoteHandler

app :: Application
app = serve notesAPI notesServer

startApp :: IO ()
startApp = run 8080 app