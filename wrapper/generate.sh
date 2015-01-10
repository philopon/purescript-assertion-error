#!/bin/bash

OUT=src/Test/Assert/AssertionError/Foreign.purs

cat <<EOC > $OUT
module Test.Assert.AssertionError.Foreign (assert) where

foreign import assert """
var assert = (function(module, exports){
EOC

cat node_modules/assertion-error/index.js >> $OUT

cat <<EOC >> $OUT

return module.exports;
}({}, {}));""" :: forall a. a
EOC
