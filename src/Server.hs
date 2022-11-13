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

import Model
import Database

type NotesAPI = "notes" :> ReqBody '[JSON] Note :> Post '[JSON] Int64

notesAPI :: Proxy NotesAPI
notesAPI = Proxy

createNoteHandler :: Note -> Handler Int64
createNoteHandler note = liftIO $ createNote note

notesServer :: Server NotesAPI
notesServer = createNoteHandler

app :: Application
app = serve notesAPI notesServer

startApp :: IO ()
startApp = run 8080 app