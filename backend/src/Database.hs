{-# LANGUAGE OverloadedStrings #-}

module Database where

import Control.Monad.IO.Unlift
import Control.Monad.Logger (LoggingT, runStdoutLoggingT)
import Control.Monad.Reader (runReaderT)
import Data.Int (Int64)
import Database.Persist
import Database.Persist.Postgresql
import Model
import Servant (NoContent)

connString :: ConnectionString
connString = "host=127.0.0.1 port=5432 user=postgres dbname=funpro password=forget1010"

runAction :: MonadUnliftIO m => ConnectionString -> SqlPersistT (LoggingT m) a -> m a
runAction connectionString action = runStdoutLoggingT $ withPostgresqlConn connectionString $ \backend -> runReaderT action backend

migrateDB :: IO ()
migrateDB = runAction connString (runMigration migrateAll)

createNote :: Note -> IO Int64
createNote note = fromSqlKey <$> runAction connString (insert note)

getAllNote :: IO [Entity Note]
getAllNote = runAction connString (selectList[][])

updateNoteById :: Int64 -> Note -> IO ()
updateNoteById id note = runAction connString (replace (toSqlKey id) note)

deleteNoteById :: Int64 -> IO ()
deleteNoteById id = runAction connString (delete (toSqlKey id :: NoteId))