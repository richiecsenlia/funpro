{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators   #-}
module MainServer
    ( startApp
    , app
    ) where
import Control.Monad.IO.Class (liftIO)
import qualified Data.Aeson
import Data.Aeson.TH
import Network.Wai
import Network.Wai.Handler.Warp
import Servant
import Data.Int (Int64)
import Database.Persist
import Network.Wai.Middleware.Cors
import Network.HTTP.Types

import Model
import Database
import Model2
import Database2
type UsersAPI = "expenseall" :> Get '[JSON] [Entity Expense]
                :<|> "expense" :> ReqBody '[JSON] Expense :> Post '[JSON] Int64
                :<|> "delete" :> Capture "id" Int64 :> Delete '[JSON] String
                :<|> "expensekey" :> Get '[JSON] [Key Expense]
                :<|> "filterexpenseyear" :> Capture "year" Integer :> Get '[JSON] [Expense]
                :<|> "filterexpensemonth" :> Capture "month" Int :> Get '[JSON] [Expense]
                :<|> "expenseinyear" :> Capture "year" Integer :> Get '[JSON] [Int]
                :<|>"notes" :> "getall" :> Get '[JSON] [Entity Note]
                :<|> "notes" :> "create" :> ReqBody '[JSON] Note :> Post '[JSON] Int64
                :<|> "notes" :> "update" :> Capture "id" Int64 :> ReqBody '[JSON] Note :> Post '[JSON] ()
                :<|> "notes" :> "delete" :> Capture "id" Int64 :> Delete '[JSON] ()

getId = do 
              isi <- getAllExpense
              return (map entityKey isi)

-- cobacoba3 year = do
--               isi <- getAllExpense
--               return (filterYear year (map entityVal isi))
-- cobacoba4 month = do
--               isi <- getAllExpense
--               return (filterMonth month (map entityVal isi))
-- cobacoba5 year = do
--               isi <- getAllExpense
--               return (getTotalPerMonthInYear year (map entityVal isi))

filterExpense f x = do
                    isi <- getAllExpense
                    return (f x (map entityVal isi))

getFilterYear x = filterExpense (filterYear) x

getFIlterMonth x = filterExpense (filterMonth) x

getTotal x =  filterExpense (getTotalPerMonthInYear) x

createExpenseHandler :: Expense -> Handler Int64
createExpenseHandler expense = liftIO $ createExpense expense

deleteExpenseHandler :: Int64 -> Handler String
deleteExpenseHandler id = liftIO $ deleteExpense id

getIdHandler :: Handler [Key Expense]
getIdHandler = liftIO getId

filterYearHandler :: Integer -> Handler [Expense]
filterYearHandler year = liftIO $ getFilterYear year

filterMonthHandler :: Int -> Handler [Expense]
filterMonthHandler month = liftIO $ getFIlterMonth month

totalPerMonthInYearHandler :: Integer -> Handler [Int]
totalPerMonthInYearHandler year = liftIO $ getTotal year

getAllExpenseHandler :: Handler [Entity Expense]
getAllExpenseHandler = liftIO $ getAllExpense

createNoteHandler :: Note -> Handler Int64
createNoteHandler note = liftIO $ createNote note

getAllNoteHandler :: Handler [Entity Note]
getAllNoteHandler = liftIO $ getAllNote

updateNoteHandler :: Int64 -> Note -> Handler ()
updateNoteHandler id note = liftIO $ updateNoteById id note

deleteNoteHandler :: Int64 -> Handler ()
deleteNoteHandler id = liftIO $ deleteNoteById id

usersServer :: Server UsersAPI
usersServer =   getAllExpenseHandler
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
                     corsMethods = [methodGet,methodPost,methodPut,methodHead,methodOptions,methodDelete],
                     corsRequestHeaders = [hContentType,hAuthorization]
                 }

app :: Application
app =  corsPolicy $ serve usersAPI usersServer
startApp :: IO ()
startApp = run 8080 app