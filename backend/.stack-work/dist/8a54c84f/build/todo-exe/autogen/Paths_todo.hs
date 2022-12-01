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
bindir     = "D:\\KULIAH\\SMT 5\\FUNPRO\\TUGAS KELOMPOK\\funpro\\backend\\.stack-work\\install\\8f3660d6\\bin"
libdir     = "D:\\KULIAH\\SMT 5\\FUNPRO\\TUGAS KELOMPOK\\funpro\\backend\\.stack-work\\install\\8f3660d6\\lib\\x86_64-windows-ghc-9.2.4\\todo-0.1.0.0-GxmsDydXHudHO2uxd7j8NI-todo-exe"
dynlibdir  = "D:\\KULIAH\\SMT 5\\FUNPRO\\TUGAS KELOMPOK\\funpro\\backend\\.stack-work\\install\\8f3660d6\\lib\\x86_64-windows-ghc-9.2.4"
datadir    = "D:\\KULIAH\\SMT 5\\FUNPRO\\TUGAS KELOMPOK\\funpro\\backend\\.stack-work\\install\\8f3660d6\\share\\x86_64-windows-ghc-9.2.4\\todo-0.1.0.0"
libexecdir = "D:\\KULIAH\\SMT 5\\FUNPRO\\TUGAS KELOMPOK\\funpro\\backend\\.stack-work\\install\\8f3660d6\\libexec\\x86_64-windows-ghc-9.2.4\\todo-0.1.0.0"
sysconfdir = "D:\\KULIAH\\SMT 5\\FUNPRO\\TUGAS KELOMPOK\\funpro\\backend\\.stack-work\\install\\8f3660d6\\etc"

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
