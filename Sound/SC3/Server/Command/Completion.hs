-- | This module provides variations of the asynchronous server commands that
-- expect a /completion packet/ as the first argument. The completion packet
-- is executed by the server when the asynchronous command has finished. Note
-- that this mechanism is for synchronizing server side processes only, for
-- client side synchronization use @\/done@ message notification or the
-- @\/sync@ barrier.
module Sound.SC3.Server.Command.Completion
  ( -- *Synthdef handling
    d_recv'
  , d_load'
  , d_loadDir'
  -- *Buffer allocation
  , b_alloc'
  , b_allocRead'
  , b_allocReadChannel'
  , b_free'
  , b_close'
  -- *Buffer reading
  , b_read'
  , b_readChannel'
  -- *Buffer writing
  , b_write'
  -- *Buffer operations
  , b_zero'
  ) where

import Sound.OpenSoundControl
import Sound.SC3.Server.Synthdef

-- Encode an OSC packet as an OSC blob.
encode_message_blob :: Message -> Datum
encode_message_blob = Blob . encodeOSC

-- | Install a bytecode instrument definition. (Asynchronous)
d_recv' :: Message -> Synthdef -> Message
d_recv' osc d = message "/d_recv" [Blob (synthdefData d), encode_message_blob osc]

-- | Load an instrument definition from a named file. (Asynchronous)
d_load' :: Message -> String -> Message
d_load' osc p = message "/d_load" [String p, encode_message_blob osc]

-- | Load a directory of instrument definitions files. (Asynchronous)
d_loadDir' :: Message -> String -> Message
d_loadDir' osc p = message "/d_loadDir" [String p, encode_message_blob osc]

-- | Allocates zero filled buffer to number of channels and samples. (Asynchronous)
b_alloc' :: Message -> Int -> Int -> Int -> Message
b_alloc' osc nid frames channels = message "/b_alloc" [Int nid, Int frames, Int channels, encode_message_blob osc]

-- | Allocate buffer space and read a sound file. (Asynchronous)
b_allocRead' :: Message -> Int -> String -> Int -> Int -> Message
b_allocRead' osc nid p f n = message "/b_allocRead" [Int nid, String p, Int f, Int n, encode_message_blob osc]

-- | Allocate buffer space and read a sound file, picking specific channels. (Asynchronous)
b_allocReadChannel' :: Message -> Int -> String -> Int -> Int -> [Int] -> Message
b_allocReadChannel' osc nid p f n cs = message "/b_allocReadChannel" ([Int nid, String p, Int f, Int n] ++ map Int cs ++ [encode_message_blob osc])

-- | Free buffer data. (Asynchronous)
b_free' :: Message -> Int -> Message
b_free' osc nid = message "/b_free" [Int nid, encode_message_blob osc]

-- | Close attached soundfile and write header information. (Asynchronous)
b_close' :: Message -> Int -> Message
b_close' osc nid = message "/b_close" [Int nid, encode_message_blob osc]

-- | Read sound file data into an existing buffer. (Asynchronous)
b_read' :: Message -> Int -> String -> Int -> Int -> Int -> Bool -> Message
b_read' osc nid p f n f' z = message "/b_read" [Int nid, String p, Int f, Int n, Int f', Int (fromEnum z), encode_message_blob osc]

-- | Read sound file data into an existing buffer. (Asynchronous)
b_readChannel' :: Message -> Int -> String -> Int -> Int -> Int -> Bool -> [Int] -> Message
b_readChannel' osc nid p f n f' z cs = message "/b_readChannel" ([Int nid, String p, Int f, Int n, Int f', Int (fromEnum z)] ++ map Int cs ++ [encode_message_blob osc])

-- | Write sound file data. (Asynchronous)
b_write' :: Message -> Int -> String -> String -> String -> Int -> Int -> Bool -> Message
b_write' osc nid p h t f s z = message "/b_write" [Int nid, String p, String h, String t, Int f, Int s, Int (fromEnum z), encode_message_blob osc]

-- | Zero sample data. (Asynchronous)
b_zero' :: Message -> Int -> Message
b_zero' osc nid = message "/b_zero" [Int nid, encode_message_blob osc]

-- Local Variables:
-- truncate-lines:t
-- End:
