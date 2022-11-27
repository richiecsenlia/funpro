module Cors where

import           Network.Wai                 (Middleware)
import           Network.Wai.Middleware.Cors (cors, simpleCorsResourcePolicy)

corsConfig :: Middleware
corsConfig = cors (const $ Just simpleCorsResourcePolicy)