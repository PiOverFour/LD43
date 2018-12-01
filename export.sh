#!/bin/sh

GODOT=/opt/Godot_v3.0.6-stable_x11.64
GAME=LD43

mkdir -p export/$GAME.x11/
mkdir -p export/$GAME.HTML/
mkdir -p export/$GAME.mac/
mkdir -p export/$GAME.win/

$GODOT --export "Linux/X11" export/$GAME.x11/$GAME.x86_64
# $GODOT --export "HTML5" export/$GAME.HTML/$GAME.html
$GODOT --export "Mac OSX" export/$GAME.mac/$GAME.zip
$GODOT --export "Windows Desktop" export/$GAME.win/$GAME.exe

zip -r export/$GAME.x11.zip export/$GAME.x11/*
zip -r export/$GAME.mac.zip export/$GAME.mac/*
zip -r export/$GAME.win.zip export/$GAME.win/*
