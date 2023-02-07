# MovieBrowser

App lets you browse and search movies from [TMDB](https://www.themoviedb.org/)

# Requirements
- Supports only iphones in portrait
- IOS >= 16
- Xcode 14.2

# Installation
1. Just open project and run!

# Features
- Supports Light/Dark mode
- SwiftPM modularization for scalability
- Resources(Colors, strings) generated via R.swift in separated package
- DI via Resolver
- TDD
- SwiftLint checks for code style
- Kingfisher for image chaching and downloading
- MVVM
- Fully SwiftUI app
- Networking layer and models automatically generated from OpenAPI(Swagger) file via [CreateAPI](https://github.com/CreateAPI/CreateAPI)

# ToDo
- Add more tests
- Add error visualization
- Add network error handling
- Add more attractive loading visualization
- Extract models from TMDBClient into separate package
- Make openAPI generated models code more clean

# UI
UI is similiar to design photos provided, but app uses navigation bar from IOS 15(It looks better)
But its possible to configure navigation bar old style
