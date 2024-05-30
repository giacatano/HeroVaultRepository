# HeroVaultRepository

# Table of Contents
1. [Description](#description)
2. [Getting started](#getting-started)
3. [Usage](#usage)
4. [Architecture](#architecture)
5. [Tests](#tests)
6. [CI CD](#tests)
7. [Dependencies](#dependencies)
8. [Design](#design)
9. [API](#api)

# HeroVault
A pet project used to entertain and inform comic fans.

## Description

<b>HeroVault</b> is a comic app that allows users to browse through Marvel comics and characters. Overviews of the characters and comics are provided which allows users to decide whether to add them to their favourites. Additionally, there is a Marvel-themed game which allows users to pause their browsing and test their comic knowledge. 

The idea of this app is to have a comic store experience inside an app. There is information on comics and characters as well as entertainment from the built-in game feature. 

![HomeScreen](https://github.com/giacatano/HeroVaultRepository/assets/142597978/8c734a99-3adb-47dd-8958-96174fd42104)

![FavouritesScreen](https://github.com/giacatano/HeroVaultRepository/assets/142597978/71514e24-b602-49a4-8152-954430e1b295)

![GameScreen](https://github.com/giacatano/HeroVaultRepository/assets/142597978/a93c46da-274e-46a2-a908-c9fa159e95bc)


## Getting Started

1. Xcode version 14.0 or above should be installed on your computer
2. Download the <b>HerVault</b> project files from the repository
3. Open the project files in Xcode
4. Run the active schema

The app should start up on the simulator directing you to the login page

## Usage

To access certain features or content within the application, user authentication is required. This involves creating a unique user account, which is securely stored using Core Data.

## Architecture

- <b><i>HeroVault</i></b> is a native iOS application built using the Model-View-View Model (MVVM) architecture
- The Model has any data and business logic that is used by the application
- The View is responsible for the interface in which the user interacts with
- The View model is necessary to transform information from the model and to update the View
- Currently, the project doesn't have a database or any external dependencies

<!-- ## Structure

- "AbstractInterfaces": Files pertaining 
- "Resources": Non-code files that are used by the project. This includes images, videos and other assets
- "Config":
- "Views": 
- "UserInterfaces":
- "Models"
    - "ApiModels":
    - "ViewModels":
- "Utilities": -->

## Tests
The project is tested using the built-in framework XCTest.

## CI/CD

This project utilizes Continuous Integration (CI) and Continuous Deployment (CD) practices to automate the build, test, and deployment processes. CI/CD pipelines are managed through GitHub Actions and Fastlane, streamlining the development workflow and ensuring consistent deployment processes.

## Dependencies

Currently, there are no dependencies in the project

## Design

- The design tool used is [Figma](https://www.figma.com)
- The link to the design is [here](https://www.figma.com/file/m8iZXD0DrLYiKyclhNI7RO/Marvel-App?type=design&node-id=0-1&mode=design&t=ZKrxWB460JuuS4Sf-0)
- The colour scheme used should also be used in the Xcode project

## API
- The API being used is [MarvelComicsAPI](https://developer.marvel.com/)
- All data provided is via the RESTful API which returns in JSON format only.
- The list of API calls can be found [here](https://developer.marvel.com/docs)
