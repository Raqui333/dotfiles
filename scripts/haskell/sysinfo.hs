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

main :: IO ()
main = do
    -- USER and HOST
    --host <- getEnv "HOST"
    user <- getEnv "USER"
    
    putStrLn $ replicate 4 ' ' ++ user ++ "@gentoo\n" -- hostname hard coded

    -- MEM
    memInfo <- readFile "/proc/meminfo"
    
    let memInfo' = words memInfo
    
    let memTotal = toInt $ memInfo'!!1
        memFree  = toInt $ memInfo'!!4
        buffers  = toInt $ memInfo'!!10 
        cached   = toInt $ memInfo'!!13
        sLab     = toInt $ memInfo'!!64
        memUsed  = memTotal - memFree - buffers - cached - sLab
    
    putStrLn $ "Mem\t  | \t" ++ (show $ getMbFromKb memUsed) ++ "MiB / " ++ (show $ getMbFromKb memTotal) ++ "MiB"
    
    -- Kernel
    kernelInfo <- readFile "/proc/cmdline"
    
    let kernelInfo' = words kernelInfo
    
    putStrLn $ "Kernel\t  | \t" ++ (drop 25 $ kernelInfo'!!0)
    
    -- OS
    osInfo <- readFile "/etc/os-release"
    
    let osInfo' = words osInfo
    
    putStrLn $ "Os\t  | \t" ++ (drop 5 $ osInfo'!!0)
    
    -- SHELL
    shell <- getEnv "SHELL"
    
    let shellHead = (toUpper . head . snd . splitAt 5) shell
        shellTail = (tail . snd . splitAt 5) shell
        shell'    = shellHead:shellTail
    
    putStrLn $ "Shell\t  | \t" ++ shell'