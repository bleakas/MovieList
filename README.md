# MovieBrowser

App lets you browse and search movies from [TMDB](https://www.themoviedb.org/)

# Requirements
- Supports only iphones in portrait
- IOS >= 16(Really stable navigation & UI API, ~80% iphone user base available in the next year)
- Xcode 14.2

# Installation
1. Install [HomeBrew](https://brew.sh/)
2. Install SwiftLint
> brew install swiftlint

# Features
- Supports Light/Dark mode
- SwiftPM modularization for scalability
- Resources(Colors, strings) generated via R.swift in separated package
- DI via Resolver(It has a lot SwiftUI injection features)
- TDD
- SwiftLint checks for code style(Helps otpimize review proccess)
- MVVM(The best choice for SwiftUI)
- Fully SwiftUI app(Scallable UI out of box)
- Networking layer and models automatically generated from OpenAPI(Swagger) file via [CreateAPI](https://github.com/CreateAPI/CreateAPI) 
It helps have consistent API over all project's platforms

# ToDo
- Add more tests
- Add error visualization
- Add network error handling
- Add more attractive loading visualization
- Extract models from TMDBClient into separate package
- Make openAPI generated models code more clean
- Fix some not working previews(some bug with Resolver)

# UI
UI is similiar to design photos provided, but app uses navigation bar from IOS 15(It looks better)
But its possible to configure navigation bar old style(IOS<15)
