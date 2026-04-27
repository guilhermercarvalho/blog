#!/bin/bash
set -e

find public -type f -name "*.html" -print0 | xargs -0 sed -i 's|https://guilhermercarvalho.github.io/en/blog/|https://guilhermercarvalho.github.io/blog/en/|g'

find public -type f -name "*.html" -print0 | xargs -0 sed -i 's|http://localhost:1313/en/blog/|http://localhost:1313/blog/en/|g'
