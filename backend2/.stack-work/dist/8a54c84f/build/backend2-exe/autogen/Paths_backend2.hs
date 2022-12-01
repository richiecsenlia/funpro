{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_backend2 (
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
bindir     = "D:\\KULIAH\\SMT 5\\FUNPRO\\TUGAS KELOMPOK\\funpro\\backend2\\.stack-work\\install\\5234697e\\bin"
libdir     = "D:\\KULIAH\\SMT 5\\FUNPRO\\TUGAS KELOMPOK\\funpro\\backend2\\.stack-work\\install\\5234697e\\lib\\x86_64-windows-ghc-9.2.5\\backend2-0.1.0.0-LH9YkV7afyp7mhJ6sRLgxT-backend2-exe"
dynlibdir  = "D:\\KULIAH\\SMT 5\\FUNPRO\\TUGAS KELOMPOK\\funpro\\backend2\\.stack-work\\install\\5234697e\\lib\\x86_64-windows-ghc-9.2.5"
datadir    = "D:\\KULIAH\\SMT 5\\FUNPRO\\TUGAS KELOMPOK\\funpro\\backend2\\.stack-work\\install\\5234697e\\share\\x86_64-windows-ghc-9.2.5\\backend2-0.1.0.0"
libexecdir = "D:\\KULIAH\\SMT 5\\FUNPRO\\TUGAS KELOMPOK\\funpro\\backend2\\.stack-work\\install\\5234697e\\libexec\\x86_64-windows-ghc-9.2.5\\backend2-0.1.0.0"
sysconfdir = "D:\\KULIAH\\SMT 5\\FUNPRO\\TUGAS KELOMPOK\\funpro\\backend2\\.stack-work\\install\\5234697e\\etc"

getBinDir     = catchIO (getEnv "backend2_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "backend2_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "backend2_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "backend2_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "backend2_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "backend2_sysconfdir") (\_ -> return sysconfdir)




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
