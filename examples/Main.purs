module Main where

import Control.Monad.Eff.Exception
import Test.Assert.AssertionError
import Debug.Trace
import Data.Maybe

main = do
  -- create AssertionError
  let a = assertionError "test" {prop1: 12} Nothing

  -- show error
  trace "======= show error      ======="
  print a

  -- error to JSON with stack trace
  let j = toJSON true a
  trace "======= show stack      ======="
  print j.stack

  -- error to JSON String with stack trace
  let s = toJSONString true a
  trace "======= show JSON       ======="
  trace s

  -- convert to Error
  let e = toError a
  trace "======= show message    ======="
  trace (message e)

  -- throw exception
  trace "======= throw exception ======="
  throwException e
