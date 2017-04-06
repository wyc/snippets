import Data.List
import Data.Bits
import Data.Word
import qualified Data.ByteString as BS

-- Create a list: [(255,8),(254,7),(252,6),(248,5),...]
byteAList :: [(Word8, Int)]
byteAList = map (\x -> ((shift 0xFF x) .&. 0xFF, 8-x)) [0..7]

-- Count how many leading ones the Word8 b has
countByteLeadingOnes :: Word8 -> Int
countByteLeadingOnes b = case find (\x -> (fst x) .&. b == (fst x)) byteAList of
    Nothing -> 0
    Just (x, y) -> y

-- Determines if the bytestring bs has at least n leading ones
hasLeadingOnes :: Int -> BS.ByteString -> Bool
hasLeadingOnes n bs = hasLeadingOnes' n bs 0

hasLeadingOnes' :: Int -> BS.ByteString -> Int -> Bool
hasLeadingOnes' n bs count = case BS.uncons bs of
    Nothing -> count >= n
    Just (b, bs') -> hasLeadingOnes' n bs' (currentCount + count)
        where currentCount = countByteLeadingOnes b
