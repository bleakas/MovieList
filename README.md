# MovieBrowser

App lets you browse and search movies from [TMDB](https://www.themoviedb.org/)

# Requirements
- Supports only iphones in portrait
- IOS >= 16  
First really stable and configurable navigation API(NavigationStack), so no navigation migration is needed in the future(NavigationView is now deprecated) <br />
\>80% iphone use base will be available in less than half a year([Proof](https://www.macrumors.com/2022/06/03/ios-15-installation-numbers-apple/))  
So when our product reaches the market IOS 16 will be widely distributed  
- Xcode 14.2(Works best with IOS 16 target)

# Installation
1. Install [HomeBrew](https://brew.sh/)
2. Install SwiftLint
> brew install swiftlint
3. Open project, wait until all packages are fetched and installed
4. Click run button
# Troubleshooting
- Clean build folder(Product->Clean Build Folder)
- Clear SwiftPM chache(File->Packages->Reset Package Chaches)

# Features
- Supports Light/Dark mode
- SwiftPM modularization for scalability
- Resources(Colors, strings) generated via R.swift in separated package  
It helps us move away string literals, make our code more clean and compile time safer
- DI via Resolver  
It has some SwiftUI injection features, it's ultralight and perfomant
- TDD
- SwiftLint  
Makes our code more clean, prevents stupid mistakes in PRs
- MVVM  
The best choice for SwiftUI  
Low overhead  
Scallable and testable
- Fully SwiftUI app  
Scallable UI out of box  
Easy to reuse  
Speeds up development  
Easy to maintain and adapt  
- Combine
- Networking layer and models automatically generated from OpenAPI(Swagger) file via [CreateAPI](https://github.com/CreateAPI/CreateAPI)  
It helps have consistent API over all project's platforms  
It provides great scalability and adaptability to change  
Saves time

# ToDo
- Add more tests
- Add error visualization
- Add network error handling
- Add more attractive loading visualization
- Extract models from TMDBClient into separate package
- Make openAPI generated models code more clean
- Fix some not working previews(some bug with Resolver)

# UI
UI is similar to design photos provided, but app uses navigation bar from IOS 15(It looks better)  
But it's possible to configure navigation bar old style(IOS<15)
