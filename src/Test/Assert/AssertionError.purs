module Test.Assert.AssertionError
  ( AssertionError()
  , assertionError
  , AssertionErrorJSON()
  , toJSON, toJSONString
  , toError
  ) where

  import Control.Monad.Eff.Exception
  import Test.Assert.AssertionError.Foreign
  import Data.Maybe
  import Data.Function

  foreign import data AssertionError :: *

  foreign import assertionErrorImpl """
function assertionErrorImpl(c, msg, props, ssf){
  var ssf = c.fromMaybe(assertionErrorImpl)(ssf);
  return new c.assertionError(msg, props, ssf);
}""" :: forall assertionError props ssf.
        Fn4 { fromMaybe :: ssf -> Maybe ssf -> ssf
            , assertionError :: assertionError
            } String {|props} (Maybe ssf) AssertionError

  assertionError :: forall props ssf. String -> {|props} -> Maybe ssf -> AssertionError
  assertionError = runFn4 assertionErrorImpl
    {fromMaybe: fromMaybe, assertionError: assert}

  foreign import showAssertionErrorImpl """
function showAssertionErrorImpl(a){
  return a.toString();
}""" :: AssertionError -> String
  
  instance showAssertionError :: Show AssertionError where
    show = showAssertionErrorImpl

  type AssertionErrorJSON = {name :: String, message :: String, showDiff :: Boolean, stack :: Maybe String}

  foreign import toJSONImpl """
function toJSONImpl(maybe, with_stack, assetionError){
  var json  = assetionError.toJSON(with_stack);
  var stack = json.stack ? maybe.just(json.stack) : maybe.nothing;
  json.stack = stack;
  return json;
}
""" :: Fn3 {just :: String -> Maybe String, nothing :: Maybe String} Boolean AssertionError AssertionErrorJSON

  toJSON :: Boolean -> AssertionError -> AssertionErrorJSON
  toJSON = runFn3 toJSONImpl {just: Just, nothing: Nothing}

  foreign import toJSONStringImpl """
function toJSONStringImpl(with_stack, assetionError){
  return JSON.stringify(assetionError.toJSON(with_stack));
}""" :: Fn2 Boolean AssertionError String

  toJSONString :: Boolean -> AssertionError -> String
  toJSONString = runFn2 toJSONStringImpl

  foreign import toError """
function toError(ae){return ae;}
""" :: AssertionError -> Error
