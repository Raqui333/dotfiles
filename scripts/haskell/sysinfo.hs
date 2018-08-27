import System.IO
import System.Environment
import Data.List
import Data.Char

-- test functions/modules haskell
-- system info

toInt :: String -> Int
toInt x = read x :: Int

getMbFromKb :: Int -> Int
getMbFromKb x = x `div` 1024

main = do
    -- USER and HOST
    --host <- getEnv "HOST"
    user <- getEnv "USER"
    
    putStrLn $ replicate 4 ' ' ++ user ++ "@gentoo\n" -- hostname hard coded

    -- MEM
    procFile <- openFile "/proc/meminfo" ReadMode
    memInfo  <- hGetContents procFile
    
    let memInfo' = words memInfo
    
    let memTotal = toInt $ memInfo'!!1
        memFree  = toInt $ memInfo'!!4
        buffers  = toInt $ memInfo'!!10 
        cached   = toInt $ memInfo'!!13
        sLab     = toInt $ memInfo'!!64
        memUsed  = memTotal - memFree - buffers - cached - sLab
    
    putStrLn $ "Mem\t  | \t" ++ (show $ getMbFromKb memUsed) ++ "MiB / " ++ (show $ getMbFromKb memTotal) ++ "MiB"
    hClose procFile
    
    -- Kernel
    cmdlineFile <- openFile "/proc/cmdline" ReadMode
    kernelInfo  <- hGetContents cmdlineFile
    
    let kernelInfo' = words kernelInfo
    
    putStrLn $ "Kernel\t  | \t" ++ (drop 25 $ kernelInfo'!!0)
    hClose cmdlineFile
    
    -- OS
    osReleaseFile <- openFile "/etc/os-release" ReadMode
    osInfo        <- hGetContents osReleaseFile
    
    let osInfo' = words osInfo
    
    putStrLn $ "Os\t  | \t" ++ (drop 5 $ osInfo'!!0)
    hClose osReleaseFile
    
    -- SHELL
    shell <- getEnv "SHELL"
    
    let shellHead = (toUpper . head . snd . splitAt 5) shell
        shellTail = (tail . snd . splitAt 5) shell
        shell'    = shellHead:shellTail
    
    putStrLn $ "Shell\t  | \t" ++ shell'