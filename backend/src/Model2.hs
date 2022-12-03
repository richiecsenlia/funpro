{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE StandaloneDeriving #-}

module Model2 where

import Data.Aeson (defaultOptions, ToJSON, toJSON)
import Data.Aeson.TH (deriveJSON)
import Data.Text (Text)
import Database.Persist 
import qualified Database.Persist.TH as PTH
import Data.Time
PTH.share [PTH.mkPersist PTH.sqlSettings, PTH.mkMigrate "migrateAll"] [PTH.persistLowerCase|
Expense sql = expenses
    total Int
    usage String
    date Day Nullable nullable
    deriving Show Read
|]
deriveJSON defaultOptions ''Expense

instance ToJSON (Entity Expense) where
  toJSON = entityIdToJSON