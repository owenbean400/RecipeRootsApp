# Recipe Roots

This repository contains the source code for the app recipe_roots, created by Owen Bean, SJ Franklin, and Shea Durgin.

## Table of Contents

- [What is Recipe Roots](#What-Is-Recipe-Roots)
- [Installation](#Installation)
- [Emulation](#Emulation)
- [Conclusion](#Conclusion)

## What is Recipe Roots

## Installation
Follow the documentation for Flutter
https://docs.flutter.dev/get-started/install
After running doctor in the VSCode Command Pallete, if it asks to download the Flutter SDK, install it.
Clone the Repository
Run the command 'flutter pub get --no-example'

## Emulation
Follow the documentation for android setup
https://flutter.dev/docs/get-started/install/windows#android-setup
Scroll down to 'Install Android Studio' and follow those steps
Then follow the 'Set up the Android Emulator" section
If having trouble finding the 'Device Manager' button, it is on the right tab on Android Studio
Follow this link to find out where your Android/Sdk folder is
https://developer.android.com/studio/command-line
Also make sure "Android SDK Command-line Tools (lastest)' is installed under Settings->Languages & Frameworks->Android SDK->SDK Tools
Then do these commands
-  flutter config --android-sdk "<path-to-your-android-sdk-path>"
-  flutter doctor --android-licenses

Restart VSCode
Navigate to RecipeRootsApp/lib/main.dart
Start debugging
The app will launch in the emulator on Android Studio (First run may take a bit of time)
While editing the code, you can save the file to instantly update the app on the emulator
