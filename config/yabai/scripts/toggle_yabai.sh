#!/bin/sh

if pgrep yabai > /dev/null;
then
  yabai --stop-service
else 
  yabai --start-service
fi
