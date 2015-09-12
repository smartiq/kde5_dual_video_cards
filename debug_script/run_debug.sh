#!/bin/bash

NOW="$(date +%Y-%m-%d-%H:%M:%S)"

./debug_kde.sh > output/debug_${NOW}.txt
