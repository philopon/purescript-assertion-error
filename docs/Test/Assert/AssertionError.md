# Module Documentation

## Module Test.Assert.AssertionError

#### `AssertionError`

``` purescript
data AssertionError :: *
```


#### `assertionError`

``` purescript
assertionError :: forall props ssf. String -> {  | props } -> Maybe ssf -> AssertionError
```


#### `showAssertionError`

``` purescript
instance showAssertionError :: Show AssertionError
```


#### `AssertionErrorJSON`

``` purescript
type AssertionErrorJSON = { stack :: Maybe String, showDiff :: Boolean, message :: String, name :: String }
```


#### `toJSON`

``` purescript
toJSON :: Boolean -> AssertionError -> AssertionErrorJSON
```


#### `toJSONString`

``` purescript
toJSONString :: Boolean -> AssertionError -> String
```


#### `toError`

``` purescript
toError :: AssertionError -> Error
```




