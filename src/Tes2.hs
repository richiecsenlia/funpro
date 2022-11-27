{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators   #-}
module Tes2
    ( startApp
    , app
    ) where
import Control.Monad.IO.Class (liftIO)
import Data.Aeson
import Data.Aeson.TH
import Network.Wai
import Network.Wai.Handler.Warp
import Servant
import Tes1
import Data.Int (Int64)
import Database.Persist
import Network.Wai.Middleware.Cors
type UsersAPI = "expenseall" :> Get '[JSON] [Expense] :<|> "expense" :> ReqBody '[JSON] Expense :> Post '[JSON] Int64

corsConfig :: Middleware
corsConfig = cors (const $ Just policy)
  where
    policy = simpleCorsResourcePolicy {corsExposedHeaders = Just ["X-Total-Count"]}
cobacoba = do isi <- cobaGet
              return (map entityVal isi)

fetchExpenseHandler ::  Handler [Expense]
fetchExpenseHandler = liftIO cobacoba
createExpenseHandler :: Expense -> Handler Int64
createExpenseHandler expense = liftIO $ createExpense expense

usersServer :: Server UsersAPI
usersServer = (fetchExpenseHandler) :<|> (createExpenseHandler)

usersAPI :: Proxy UsersAPI
usersAPI = Proxy :: Proxy UsersAPI

app :: Application
app =  simpleCors $ serve usersAPI usersServer
startApp :: IO ()
startApp = run 8080 app