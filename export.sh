#!/bin/sh

GODOT=/opt/Godot_v3.0.6-stable_x11.64
GAME=O_Soliloquy

mkdir -p export/$GAME.lin/
mkdir -p export/$GAME.HTML/
#mkdir -p export/$GAME.mac/
mkdir -p export/$GAME.win/

$GODOT --export "Linux/X11" export/$GAME.lin/$GAME.x86_64
$GODOT --export "HTML5" export/$GAME.HTML/$GAME.html
$GODOT --export "Mac OSX" export/$GAME.mac.zip
$GODOT --export "Windows Desktop" export/$GAME.win/$GAME.exe

mv export/$GAME.HTML/$GAME.html export/$GAME.HTML/index.html

cd export

zip -r $GAME.lin.zip $GAME.lin/*
zip -r $GAME.win.zip $GAME.win/*

# Move to dir so index.html is at the zip's root
cd $GAME.HTML
zip -r $GAME.HTML.zip ./*
mv $GAME.HTML.zip ..
