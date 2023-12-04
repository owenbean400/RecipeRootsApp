# Recipe Roots

This repository contains the source code for the app recipe_roots, created by Owen Bean, SJ Franklin, and Shea Durgin.

## Table of Contents

- [What is Recipe Roots](#What-Is-Recipe-Roots)
- [Installation](#Installation)
- [Emulation](#Emulation)
- [Conclusion](#Conclusion)

## What is Recipe Roots

## Installation
Follow the documentation for [Flutter installation](https://docs.flutter.dev/get-started/install)
After running doctor in the VSCode Command Palette, install the Flutter SDK if prompted.
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
-  flutter config --android-sdk "<path-to-your-android-sdk-path>"
-  flutter doctor --android-licenses

Restart VSCode
Navigate to RecipeRootsApp/lib/main.dart
Start debugging
The app will launch in the emulator on Android Studio (First run may take a bit of time)
While editing the code, you can save the file to instantly update the app on the emulator
