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

module Tes1
    -- ( migrateDB,
    -- insert1,
    -- insert2,
    -- cobainsert,
    -- cobaGet,
    
    -- getAllExpense
     where

import qualified Data.Aeson as Aeson
import Data.Aeson.TH
import Network.Wai
import Network.Wai.Handler.Warp
import Servant
import qualified Database.Persist.TH as PTH
import Control.Monad.Logger --(runStdoutLoggingT,runReaderT)
import Control.Monad.Reader
import Control.Monad.IO.Unlift
import Database.Persist.Postgresql --(ConnectionString, withPostgresqlConn, SqlPersistT,IsSqlBackend,runMigration,insert)
import Database.Persist
import Data.Int (Int64)
import Data.Time
--import Schema (migrateAll)

PTH.share [PTH.mkPersist PTH.sqlSettings, PTH.mkMigrate "migrateAll"] [PTH.persistLowerCase|
Expense sql = expenses
    total Int
    usage String
    date Day Nullable nullable
    deriving Show Read
|]
deriveJSON defaultOptions ''Expense
-- data Expense = Expense
--   { total        :: Int
--   , usage :: String
--   } deriving (Eq, Show)

connString :: ConnectionString
connString = "host=127.0.0.1 port=5432 user=postgres dbname=funpro password=user"

-- Also various constraints on the monad m
-- withPostgresqlConn :: (IsSqlBackend backend) => ConnectionString -> (backend -> m a) -> m a

--runAction :: (MonadUnliftIO m, IsPersistBackend r,BaseBackend r ~ SqlBackend) => ConnectionString -> ReaderT r (LoggingT m) a -> m a                                                                     
--runAction connectionString action = runStdoutLoggingT                                                                        
--                                    $ withPostgresqlConn connectionString                                                    
--                                    $ \backend ->                                                                            
--
--                                        runReaderT action backend
runAction :: MonadUnliftIO m => ConnectionString -> SqlPersistT (LoggingT m) a ->  m a
runAction connectionString action = runStdoutLoggingT $ withPostgresqlConn connectionString $ \backend -> runReaderT action backend

migrateDB :: IO ()
migrateDB = runAction connString (runMigration migrateAll)

ekstrak (Just x) = x

insertExpense :: (MonadIO m) => Int -> String -> Day -> SqlPersistT m (Key Expense)
insertExpense a b c = insert $ Expense a  b  c
insert1 :: (MonadIO m) => SqlPersistT m (Key Expense) 
insert1 = insertExpense 30  "halo" (ekstrak(fromGregorianValid 2022 1 1))
-- insert2 :: (MonadIO m) =>  SqlPersistT m (Key Expense)
-- insert2 = insertExpense 10 "amin"
cobainsert :: IO (Key Expense)
cobainsert = runAction connString (insert1)
createExpense :: Expense -> IO Int64
createExpense expense = fromSqlKey <$> runAction connString (insert $ expense) 

getAllExpense :: (MonadIO m, MonadLogger m) => SqlPersistT m [Entity Expense]
getAllExpense = selectList [] []
cobaGet :: IO ([Entity Expense])
cobaGet = runAction connString (getAllExpense)

getAllExpense2 :: (MonadIO m, MonadLogger m) => SqlPersistT m [Entity Expense]
getAllExpense2 = selectList [] []

updateById:: (MonadIO m) => Int64 -> SqlPersistT m ()
updateById id = update (toSqlKey id) [ExpenseTotal =. 1 ,ExpenseUsage =. "berhasil",ExpenseDate =. ekstrak(fromGregorianValid 2022 2 2) ]

update1 :: (MonadIO m) => SqlPersistT m ()
update1 = updateById 1
update2 :: (MonadIO m) => SqlPersistT m ()
update2 = updateById 2

update3 :: (MonadIO m) => SqlPersistT m ()
update3 = updateById 3


cobaupdate1 :: IO ()
cobaupdate1 = runAction connString (update1)


cobaupdate2 :: IO ()
cobaupdate2 = runAction connString (update2)

cobaupdate3 :: IO ()
cobaupdate3 = runAction connString (update3)
