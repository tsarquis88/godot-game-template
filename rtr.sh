#!/bin/sh

echo "Running gdformat..."
gdformat . > /dev/null

echo "Running gdlint..."
gdlint . > /dev/null

