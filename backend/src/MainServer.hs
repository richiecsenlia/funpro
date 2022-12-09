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
type UsersAPI = "expenseall" :> Capture "username" String :> Get '[JSON] [Entity Expense]
                :<|> "expense" :> ReqBody '[JSON] Expense :> Post '[JSON] Int64
                :<|> "delete" :> Capture "id" Int64 :> Delete '[JSON] String
                :<|> "filterexpenseyear" :> Capture "year" Integer :> Capture "username" String :> Get '[JSON] [Expense]
                :<|> "filterexpensemonth" :> Capture "month" Int :> Capture "username" String :>  Get '[JSON] [Expense]
                :<|> "expenseinyear" :> Capture "year" Integer :> Capture "username" String :> Get '[JSON] [Int]
                :<|>"notes" :> "getall" :> Get '[JSON] [Entity Note]
                :<|> "notes" :> "create" :> ReqBody '[JSON] Note :> Post '[JSON] Int64
                :<|> "notes" :> "update" :> Capture "id" Int64 :> ReqBody '[JSON] Note :> Post '[JSON] ()
                :<|> "notes" :> "delete" :> Capture "id" Int64 :> Delete '[JSON] ()


-- cobacoba3 year = do
--               isi <- getAllExpense
--               return (filterYear year (map entityVal isi))
-- cobacoba4 month = do
--               isi <- getAllExpense
--               return (filterMonth month (map entityVal isi))
-- cobacoba5 year = do
--               isi <- getAllExpense
--               return (getTotalPerMonthInYear year (map entityVal isi))

filterExpense f x y = do
                    isi <- getAllExpense y
                    return (f x (map entityVal isi))

getFilterYear = filterExpense (filterYear) 

getFIlterMonth = filterExpense (filterMonth) 

getTotal =  filterExpense (getTotalPerMonthInYear) 

createExpenseHandler :: Expense -> Handler Int64
createExpenseHandler expense = liftIO $ createExpense expense

deleteExpenseHandler :: Int64 -> Handler String
deleteExpenseHandler id = liftIO $ deleteExpense id


filterYearHandler :: Integer -> String -> Handler [Expense]
filterYearHandler year username = liftIO $ getFilterYear year username

filterMonthHandler :: Int -> String -> Handler [Expense]
filterMonthHandler month username = liftIO $ getFIlterMonth month username

totalPerMonthInYearHandler :: Integer -> String -> Handler [Int]
totalPerMonthInYearHandler year username = liftIO $ getTotal year username

getAllExpenseHandler :: String -> Handler [Entity Expense]
getAllExpenseHandler username = liftIO $ getAllExpense username

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