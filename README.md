# MovieMaster

MovieMaster is an iOS application that allows users to browse and view details of popular movies. It leverages SwiftUI for the user interface, Core Data for local storage, and Alamofire for network requests.

## Features

- **Browse Popular Movies**: View a list of popular movies with pagination support.
- **Movie Details**: Tap on a movie to view detailed information, including title, release date, and overview.
- **Offline Support**: Caches movie data locally to provide offline access.
- **Error Handling**: Displays alerts for network errors and allows retrying operations.

## Architecture

- **MVVM**: Utilizes the Model-View-ViewModel pattern to separate concerns and improve testability.
- **Core Data**: Used for local data storage and caching.
- **Alamofire**: Handles network requests to fetch movie data.
- **SwiftUI**: Provides a modern, declarative UI framework for building the app's interface.

## Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/MovieMaster.git
   ```

2. **Navigate to the project directory**:
   ```bash
   cd MovieMaster
   ```

3. **Open the project in Xcode**:
   ```bash
   open MovieMaster.xcodeproj
   ```

4. **Build and run the project**:
   - Select a simulator or a connected device.
   - Press `Cmd + R` to build and run the app.

## Usage

- **Browse Movies**: Launch the app to see a list of popular movies. Scroll to load more movies.
- **View Details**: Tap on a movie to view its details.
- **Offline Access**: The app will use cached data when offline.

## Dependencies

- **Alamofire**: For network requests.
- **SDWebImageSwiftUI**: For asynchronous image loading (can be replaced with SwiftUI's `AsyncImage`).
- **Core Data**: For local data storage.
