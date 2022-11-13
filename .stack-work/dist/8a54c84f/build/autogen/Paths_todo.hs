{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_todo (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "C:\\Dev\\Haskell\\Project\\funpro\\.stack-work\\install\\58ccce14\\bin"
libdir     = "C:\\Dev\\Haskell\\Project\\funpro\\.stack-work\\install\\58ccce14\\lib\\x86_64-windows-ghc-9.2.4\\todo-0.1.0.0-Eka5IazVpF4590gN5AzrF6"
dynlibdir  = "C:\\Dev\\Haskell\\Project\\funpro\\.stack-work\\install\\58ccce14\\lib\\x86_64-windows-ghc-9.2.4"
datadir    = "C:\\Dev\\Haskell\\Project\\funpro\\.stack-work\\install\\58ccce14\\share\\x86_64-windows-ghc-9.2.4\\todo-0.1.0.0"
libexecdir = "C:\\Dev\\Haskell\\Project\\funpro\\.stack-work\\install\\58ccce14\\libexec\\x86_64-windows-ghc-9.2.4\\todo-0.1.0.0"
sysconfdir = "C:\\Dev\\Haskell\\Project\\funpro\\.stack-work\\install\\58ccce14\\etc"

getBinDir     = catchIO (getEnv "todo_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "todo_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "todo_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "todo_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "todo_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "todo_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '\\'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/' || c == '\\'
