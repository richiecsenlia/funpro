{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TypeOperators   #-}

{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE TypeFamilies               #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE RecordWildCards            #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE DerivingStrategies         #-}
{-# LANGUAGE StandaloneDeriving         #-}
{-# LANGUAGE UndecidableInstances       #-}

module Database2
    
     where

import qualified Data.Aeson as Aeson
import Data.Aeson.TH
import Network.Wai
import Network.Wai.Handler.Warp
import Servant
import qualified Database.Persist.TH as PTH
import Control.Monad.Logger 
import Control.Monad.Reader
import Control.Monad.IO.Unlift
import Database.Persist.Postgresql 
import Database.Persist
import Data.Int (Int64)
import Data.Time
import Model2

connString :: ConnectionString
connString = "host=db.gnvlenttjmyipsadlofe.supabase.co port=5432 user=postgres dbname=postgres password=Rt9GTWC2pSP1mvsB"

runAction :: MonadUnliftIO m => SqlPersistT (LoggingT m) a ->  m a
runAction action = runStdoutLoggingT $ withPostgresqlConn connString $ \backend -> runReaderT action backend

migrateDB2 :: IO ()
migrateDB2 = runAction (runMigration migrateAll)

getAllExpense :: IO [Entity Expense]
getAllExpense = runAction (selectList[][])

createExpense :: Expense -> IO Int64
createExpense expense = fromSqlKey <$> runAction (insert $ expense) 

deleteById :: Int64 -> IO ()
deleteById id = runAction (delete (toSqlKey id :: ExpenseId))

deleteExpense :: Int64 -> IO (String)
deleteExpense id = do 
                    deleteById id
                    return "expense dihapus"



getYear (a,b,c) = a
getMonth (a,b,c) = b
isValid f x y = x == ((f . toGregorian . expenseDate) y)

isYear =  isValid (getYear) 
isMonth = isValid (getMonth)

filterYear x y = filter (isYear x) (y) 

filterMonth x y = filter (isMonth x) y

totalExpense :: [Expense] -> Int
totalExpense [] = 0
totalExpense x = foldr (+) 0 (map (expenseTotal) x)

getTotalPerMonthInYear year x = forMonth [1,2,3,4,5,6,7,8,9,10,11,12] (filterYear year x)
                                where
                                    forMonth [] y = []
                                    forMonth (a:b) y = (totalExpense (filterMonth a y)) : (forMonth b y)

