#!/bin/bash

rm -rf .circleci
cp -rf $1 .circleci
git commit -a -m "Update"
git push
