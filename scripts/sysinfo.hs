import System.IO
import Data.List

-- test functions/modules haskell
-- system info

toInt x = read x :: Int
getMbFromKb x = x `div` 1024

main = do
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
    
    -- Kernel
    cmdlineFile <- openFile "/proc/cmdline" ReadMode
    kernelInfo  <- hGetContents cmdlineFile
    
    let kernelInfo' = words kernelInfo
    
    -- OS
    osReleaseFile <- openFile "/etc/os-release" ReadMode
    osInfo        <- hGetContents osReleaseFile
    
    let osInfo' = words osInfo
    
    -- Final Print
    putStrLn $ "Mem     | " ++ (show $ getMbFromKb memUsed) ++ "MiB / " ++ (show $ getMbFromKb memTotal) ++ "MiB"
    putStrLn $ "Kernel  | " ++ (drop 25 $ kernelInfo'!!0)
    putStrLn $ "Os      | " ++ (drop 5 $ osInfo'!!0)
