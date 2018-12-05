#!/bin/sh

GODOT=/opt/Godot_v3.0.6-stable_x11.64
GAME=O_Soliloquy

mkdir -p export/$GAME.lin/
mkdir -p export/$GAME.HTML/
#mkdir -p export/$GAME.mac/
mkdir -p export/$GAME.win/

$GODOT --export-debug "Linux/X11" export/$GAME.lin/$GAME.x86_64
$GODOT --export-debug "HTML5" export/$GAME.HTML/$GAME.html
$GODOT --export-debug "Mac OSX" export/$GAME.mac.zip
$GODOT --export-debug "Windows Desktop" export/$GAME.win/$GAME.exe

cd export

zip -r $GAME.lin.zip $GAME.lin/*
zip -r $GAME.win.zip $GAME.win/*
zip -r $GAME.HTML.zip $GAME.HTML/*
