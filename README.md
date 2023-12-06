# Recipe Roots

This repository contains the source code for the iOS and Android mobile app Recipe Roots.  
Authored by Owen Bean, SJ Franklin, and Shea Durgin.  
<img src="/assets/icons/reciperoots.png" alt="Recipe Roots Logo" width="100"/>

## Table of Contents

- [Introduction](#Introduction)
- [Installation](#Installation)
- [Editing the Code](#Editing-the-Code)
- [Project Structure](#Project-Structure)
- [Features](#Features)

## Introduction
Recipe Roots is a family cookbook that fits in your pocket. It holds records of your relatives recipes while properly attributing them as authors. You are able to construct your family tree to properly showcase your Recipe Roots.

## Installation
Follow these instructions to run and edit the app  

### Cloning & Installing Flutter
1. Follow the [Flutter installation guide](https://docs.flutter.dev/get-started/install)  
2. After running `doctor` in the VSCode Command Palette, install the Flutter SDK if prompted  
3. Clone the RecipeRootsApp Repository
4. `cd` into `RecipeRootsApp`
5. Execute `flutter pub get` for dependencies

### Running the Emulator
1. Follow the documentation for [android setup](https://flutter.dev/docs/get-started/install/windows#android-setup)  
2. Follow both the 'Install Android Studio' and 'Set up the Android Emulator' steps  
3. If having trouble finding the 'Device Manager' button, it is on the right tab on Android Studio  
4. Follow [this documentation](https://developer.android.com/studio/command-line) to locate you Android/Sdk folder
5. Make sure "Android SDK Command-line Tools (lastest)' is installed under Settings->Languages & Frameworks->Android SDK->SDK Tools  
6. Execute the following commands

`flutter config --android-sdk "path/to/android/sdk"`  
`flutter doctor --android-licenses`

7. Restart VSCode  

### Editing Workflow
1. `cd` to `RecipeRootsApp/lib/main.dart`
2. Press start debugging in the top right start dropdown menu
3. The app will launch in the emulator on Android Studio (First run may take a bit of time)  
4. While editing the code, you can save the file to instantly update the app on the emulator

## Project Structure

```bash
RecipeRootsApp/lib/
├── dao/recipe_roots_dao.dart                      # database and sql queries
├── domain/                                        # defines many classes
        ...
├── helper/                                        # helper functions
|   └── map_index.dart                             # apply function to items
|   └── the_person.dart                            # class for user
├── service/                                       # abstraction layer connecting UI to Database
|   └── family_service.dart                        # manage and retrieve family tree information
|   └── person_service.dart                        # define and interact with persons
|   └── recipe_service.dart                        # handle recipe operations
├── view/                                          # UI code
|  ├── widget/                                     # define global widgets
        ...
|  ├── window/                                     # three tab UI code
|  |  ├── family_tree/                             # family tree tab
|  |  |  ├── widget/                               # define family tree page widgets
        ...
|  |  |  ├── family_tree_add.dart                  # add child to parent relationships
|  |  |  ├── family_tree_view.dart                 # view family tree graph
|  |  |  ├── family_tree_view_list.dart            # list child to parent relationships
|  |  ├── people/                                  # people tab
|  |  |  ├── widget/                               # define people page widgets
        ...
|  |  |  ├── people_add.dart                       # add new people
|  |  |  ├── people_view.dart                      # view all people
|  |  ├── recipe/                                  # recipe tab
|  |  |  ├── widget/                               # define recipe page widgets
        ...
|  |  |  ├── recipe_edit.dart                      # edit recipes
|  |  |  ├── recipe_view.dart                      # view recipe
|  |  |  ├── recipes_view.dart                     # view list of recipes
        ...
|  └── navigation_view.dart                        # navigation bar
|  └── setup_user.dart                             # initial user setup
```

## Features
Sections and their Capabilities

### People

- Add/Edit Yourself and Relatives
- Delete Relatives
- Add/Edit/Delete Relatives Relationships to Yourself

### Family Tree

- Add/Edit/Delete Child-To-Parent Relations
- Move Nodes
- Search for Recipes from Node

### Recipes

- Add/Edit/Delete Recipes
  - Recipe Name
  - Description
  - Author(s)
  - Ingredients
  - Cooking Steps
- Search for Recipes by
  - Title
  - Description
  - People
  - Family Relation
  - Ingredients
