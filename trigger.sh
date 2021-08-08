#!/bin/bash
date="`date +"%m%d-%H%M"`"
git commit -m "trigger $date" --allow-empty
