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
import Network.Wai.Middleware.Cors

import Model
import Database

type NotesAPI = "notes" :> "getall" :> Get '[JSON] [Entity Note]
           :<|> "notes" :> "create" :> ReqBody '[JSON] Note :> Post '[JSON] Int64
           :<|> "notes" :> "update" :> Capture "id" Int64 :> ReqBody '[JSON] Note :> Post '[JSON] ()
           :<|> "notes" :> "delete" :> Capture "id" Int64 :> Delete '[JSON] ()

notesAPI :: Proxy NotesAPI
notesAPI = Proxy

createNoteHandler :: Note -> Handler Int64
createNoteHandler note = liftIO $ createNote note

getAllNoteHandler :: Handler [Entity Note]
getAllNoteHandler = liftIO $ getAllNote

updateNoteHandler :: Int64 -> Note -> Handler ()
updateNoteHandler id note = liftIO $ updateNoteById id note

deleteNoteHandler :: Int64 -> Handler ()
deleteNoteHandler id = liftIO $ deleteNoteById id

notesServer :: Server NotesAPI
notesServer = getAllNoteHandler :<|> createNoteHandler :<|> updateNoteHandler :<|> deleteNoteHandler

corsPolicy :: Middleware
corsPolicy = cors (const $ Just policy)
    where
            policy = simpleCorsResourcePolicy
                -- { 
                --     corsMethods = [methodGet,methodPost,methodPut,methodHead,methodOptions],
                --     corsRequestHeaders = [hContentType,hAuthorization]
                    
                -- }

app :: Application
app = simpleCors $ serve notesAPI notesServer

startApp :: IO ()
startApp = run 8080 app