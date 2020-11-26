#!/bin/bash

rm -rf .circleci
cp -rf $1 .circleci
git add .
git commit -m "Update"
git push
