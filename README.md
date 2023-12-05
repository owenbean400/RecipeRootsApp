# Recipe Roots

This repository contains the source code for the iOS and Android mobile app Recipe Roots, created by Owen Bean, SJ Franklin, and Shea Durgin.

## Table of Contents

- [Introduction](#Introduction)
- [Installation](#Installation)
- [Editing the Code](#Editing-the-Code)

## Introduction
Recipe Roots is a family cookbook that fits in your pocket. It holds records of your relatives recipes while properly attributing them as authors. You are able to construct your family tree to properly showcase your Recipe Roots.

## Installation
Follow these instructions to run and edit the app  

### Cloning & Installing Flutter
1. Follow the [Flutter installation guide](https://docs.flutter.dev/get-started/install)  
2. After running 'doctor' in the VSCode Command Palette, install the Flutter SDK if prompted  
3. Clone the RecipeRootsApp Repository and navigate to it
4. Run this command in your terminal
-  flutter pub get --no-example  

### Running the Emulator
Follow the documentation for [android setup](https://flutter.dev/docs/get-started/install/windows#android-setup)  
Follow both the 'Install Android Studio' and 'Set up the Android Emulator' steps  
If having trouble finding the 'Device Manager' button, it is on the right tab on Android Studio  
Follow this [link](https://developer.android.com/studio/command-line) to find out where your Android/Sdk folder is  
Also make sure "Android SDK Command-line Tools (lastest)' is installed under Settings->Languages & Frameworks->Android SDK->SDK Tools  
Execute the following commands  
-  flutter config --android-sdk "path/to/android/sdk"
-  flutter doctor --android-licenses

Finally, restart VSCode  

### Editing Workflow
Navigate to RecipeRootsApp/lib/main.dart  
Press start debugging in the top right start dropdown menu
The app will launch in the emulator on Android Studio (First run may take a bit of time)  
While editing the code, you can save the file to instantly update the app on the emulator  
