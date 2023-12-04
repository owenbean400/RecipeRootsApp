# Recipe Roots

This repository contains the source code for the app Recipe Roots, created by Owen Bean, SJ Franklin, and Shea Durgin.

## Table of Contents

- [What is Recipe Roots](#What-Is-Recipe-Roots)
- [Installation](#Installation)
- [Emulation](#Emulation)

## What is Recipe Roots
Recipe Roots is your family cookbook that fits in your pocket.  
It holds records of your relatives recipes while properly attributing them as authors.  
You are able to construct your family tree to properly showcase your Recipe Roots.  

## Installation
Follow the documentation for [Flutter installation](https://docs.flutter.dev/get-started/install)  
After running doctor in the VSCode Command Palette, install the Flutter SDK if prompted  
Clone the RecipeRootsApp Repository  
Run this command  
-  flutter pub get --no-example

## Emulation
Follow the documentation for [android setup](https://flutter.dev/docs/get-started/install/windows#android-setup)  
Follow both the 'Install Android Studio' and 'Set up the Android Emulator' steps  
If having trouble finding the 'Device Manager' button, it is on the right tab on Android Studio  
Follow this [link](https://developer.android.com/studio/command-line) to find out where your Android/Sdk folder is  
Also make sure "Android SDK Command-line Tools (lastest)' is installed under Settings->Languages & Frameworks->Android SDK->SDK Tools  
Execute the following commands  
-  flutter config --android-sdk "path/to/android/sdk"
-  flutter doctor --android-licenses

Restart VSCode  
Navigate to RecipeRootsApp/lib/main.dart  
Start debugging  
The app will launch in the emulator on Android Studio (First run may take a bit of time)  
While editing the code, you can save the file to instantly update the app on the emulator  
