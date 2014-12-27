#!/bin/bash

cd `dirname $0`

../node_modules/webpack/bin/webpack.js --output-library assert assertion-error bundle.js 1>&2

cat <<EOC
module Test.Assert.AssertionError.Foreign (assert) where

foreign import assert """
EOC

cat bundle.js | tr -d '\r'

cat <<EOC
""" :: forall a. a
EOC
