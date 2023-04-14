#!/bin/sh

echo "Running gdlint..."
gdlint . > /dev/null

echo "Running gdformat..."
gdformat . > /dev/null
