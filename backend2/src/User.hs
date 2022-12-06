{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module User where

import GHC.Generics
import Data.Int
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import Web.Scotty
import Control.Monad.IO.Class
import Data.Aeson 

data User = User
  {
  username :: String
  , email :: String
  , password :: String
  }
  deriving (Generic, Show)
instance FromJSON User
instance ToJSON User where
  toJSON (User username email password) =
         object ["username" .= username,
                 "email" .= email]
instance FromRow User where
  fromRow = User <$> field <*> field <*> field

getUser :: Connection -> (String,String)-> IO [User] 
getUser db (name,pass) = query db "SELECT * FROM funpro.users WHERE username=? and password=?" (name :: String, pass :: String) :: IO[User]

createUser :: Connection -> User -> IO Int64
createUser db User{username=name, email=mail, password=pass} =
  execute db "INSERT INTO funpro.users(username, email,password) VALUES (?, ?, ?)" (name :: String, mail :: String, pass :: String)

extractNP :: User -> (String,String)
extractNP User{username=name, email=mail, password=pass} = (name,pass)

