#!/bin/bash
flutter build web
rm -r docs/*
cp -r build/web/* docs/
git add docs
git commit -m "Deployed new version"

