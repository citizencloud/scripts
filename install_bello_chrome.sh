#!/bin/bash

# copy this script into your workplace
# ref wiki: https://w.amazon.com/bin/view/BelloBrowserExtension/

brazil ws create --name Bello
cd Bello
brazil ws use --vs live
brazil ws use --package BelloChromeExtension
cd src/BelloChromeExtension

brazil ws use --platform AL2_x86_64
brazil setup platform-support
y
brazil-build
brazil-build chrome
