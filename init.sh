#!/bin/bash

set -ex

main(){
  git submodule update --recursive --init
  sed -i '.bak' 's/post_count\: 5/post_count\: 16/g' themes/cactus/_config.yml
}

main
