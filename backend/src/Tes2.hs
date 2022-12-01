{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators   #-}
module Tes2
    ( startApp
    , app
    ) where
import Control.Monad.IO.Class (liftIO)
import qualified Data.Aeson
import Data.Aeson.TH
import Network.Wai
import Network.Wai.Handler.Warp
import Servant
import Tes1
import Data.Int (Int64)
import Database.Persist
import Network.Wai.Middleware.Cors
import Network.HTTP.Types

import Model
import Database

type UsersAPI = "expenseall" :> Get '[JSON] [Expense] 
                :<|> "expense" :> ReqBody '[JSON] Expense :> Post '[JSON] Int64
                :<|> "delete" :> Capture "id" Int64 :> Get '[JSON] String
                :<|> "expensekey" :> Get '[JSON] [Key Expense]
                :<|> "filterexpenseyear" :> Capture "year" Integer :> Get '[JSON] [Expense]
                :<|> "filterexpensemonth" :> Capture "month" Int :> Get '[JSON] [Expense]
                :<|> "expenseinyear" :> Capture "year" Integer :> Get '[JSON] [Int]
                :<|>"notes" :> "getall" :> Get '[JSON] [Entity Note]
                :<|> "notes" :> "create" :> ReqBody '[JSON] Note :> Post '[JSON] Int64
                :<|> "notes" :> "update" :> Capture "id" Int64 :> ReqBody '[JSON] Note :> Post '[JSON] ()
                :<|> "notes" :> "delete" :> Capture "id" Int64 :> Delete '[JSON] ()

cobacoba = do isi <- cobaGet
              return (map entityVal isi)
cobacoba2 = do 
              isi <- cobaGet
              return (map entityKey isi)
cobacoba3 year = do
              isi <- cobaGet
              return (filterYear year (map entityVal isi))
cobacoba4 month = do
              isi <- cobaGet
              return (filterMonth month (map entityVal isi))
cobacoba5 year = do
              isi <- cobaGet
              return (getTotalPerMonthInYear year (map entityVal isi))
            
fetchExpenseHandler ::  Handler [Expense]
fetchExpenseHandler = liftIO cobacoba
createExpenseHandler :: Expense -> Handler Int64
createExpenseHandler expense = liftIO $ createExpense expense
deleteExpenseHandler :: Int64 -> Handler String
deleteExpenseHandler id = liftIO $ deleteExpense id
getIdHandler :: Handler [Key Expense]
getIdHandler = liftIO cobacoba2
filterYearHandler :: Integer -> Handler [Expense]
filterYearHandler year = liftIO $ cobacoba3 year
filterMonthHandler :: Int -> Handler [Expense]
filterMonthHandler month = liftIO $ cobacoba4 month
totalPerMonthInYearHandler :: Integer -> Handler [Int]
totalPerMonthInYearHandler year = liftIO $ cobacoba5 year

createNoteHandler :: Note -> Handler Int64
createNoteHandler note = liftIO $ createNote note

getAllNoteHandler :: Handler [Entity Note]
getAllNoteHandler = liftIO $ getAllNote

updateNoteHandler :: Int64 -> Note -> Handler ()
updateNoteHandler id note = liftIO $ updateNoteById id note

deleteNoteHandler :: Int64 -> Handler ()
deleteNoteHandler id = liftIO $ deleteNoteById id

usersServer :: Server UsersAPI
usersServer =   (fetchExpenseHandler) 
                :<|> (createExpenseHandler) 
                :<|> (deleteExpenseHandler) 
                :<|> (getIdHandler) 
                :<|> (filterYearHandler) 
                :<|> (filterMonthHandler) 
                :<|> (totalPerMonthInYearHandler) 
                :<|> getAllNoteHandler 
                :<|> createNoteHandler 
                :<|> updateNoteHandler 
                :<|> deleteNoteHandler

usersAPI :: Proxy UsersAPI
usersAPI = Proxy :: Proxy UsersAPI

corsPolicy :: Middleware
corsPolicy = cors (const $ Just policy)
    where
            policy = simpleCorsResourcePolicy
                { 
                     corsMethods = [methodGet,methodPost,methodPut,methodHead,methodOptions],
                     corsRequestHeaders = [hContentType,hAuthorization]
                    
                 }

app :: Application
app =  corsPolicy $ serve usersAPI usersServer
startApp :: IO ()
startApp = run 8080 app