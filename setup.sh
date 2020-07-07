#!/usr/bin/env bash
find . -maxdepth 1 -mindepth 1 -not -path '*/\.*' | cut -c '3-' | xargs -I '_' stow -Rv _
