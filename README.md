# HeroVaultRepository

# Table of Contents
1. [Description](#description)
2. [Getting started](#getting-started)
3. [Usage](#usage)
4. [Architecture](#architecture)
5. [Tests](#tests)
6. [Dependencies](#dependencies)
7. [Design](#design)
8. [API](#api)

# HeroVault
A pet project used to entertain and inform comic readers.

## Description

<b>HeroVault</b> is a comic app that allows users to browse through Marvel comics and characters. Overviews of the characters and comics are provided which allows users to decide whether to add them to their favourites. Additionally, there is a Marvel-themed game which allows users to pause their browsing and test their comic knowledge. 

The idea of this app is to have a comic store experience inside an app. There is information on comics and characters as well as entertainment from the built-in game feature. 


<p align="row">
  <img width="455" alt="Screenshot 2024-05-03 at 12 24 06" src="https://github.com/giacatano/HeroVaultRepository/assets/142597978/bd0f049b-8a2a-4f9e-af1e-6f1483c09140">
<img width="454" alt="Screenshot 2024-05-03 at 12 23 04" src="https://github.com/giacatano/HeroVaultRepository/assets/142597978/a8d7e934-4f0d-4994-a7bc-c8b9c73851ea"> 
</p>

## Getting Started

1. Xcode version 14.0 or above should be installed on your computer
2. Download the <b>HerVault</b> project files from the repository
3. Open the project files in Xcode
4. Run the active schema

The app should start up on the simulator directing you to the login page

## Usage

At this point in the app development there isn't any authentication to gain access there are default credentials
- Username: "Admin"
- Password: "Hero"

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

## Dependencies

Currently, there are no dependencies in the project

## Design

- The design tool used is [Figma](https://www.figma.com)
- The link to the design is [here](https://www.figma.com/file/m8iZXD0DrLYiKyclhNI7RO/Marvel-App?type=design&node-id=0-1&mode=design&t=ZKrxWB460JuuS4Sf-0)
- The colour scheme used should also be used in the Xcode project

## API
- The API being used is called [SoccersApi](https://developer.marvel.com/), it is a Marvel Comics API.
- All data provided is via the RESTful API which returns in JSON format only.
- The list of API calls can be found [here](https://developer.marvel.com/docs)
