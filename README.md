# WinMeet Mobile

# Table of Contents

1. [Project Architecture and Structure](#project-architecture-and-structure)
   - [Architecture](#architecture)
   - [Structure](#structure)
2. [Coding Standards](#coding-standards)
3. [How to Run](#how-to-run)

## Project Architecture and Structure <a name="project-architecture-and-structure"></a>

### Architecture <a name="architecture"></a>

In our project, we used feature-first layered architecture, which divides each feature into distinct layers, such as data and presentation. This approach reduces coupling between features, enhances modularity and maintainability, resulting in a more organized and manageable codebase.

### Structure <a name="structure"></a>

- app: This folder contains files specific to the current application.
- core: This folder contains application-agnostic code that can be reused in other projects.
- feature: This folder represents the application's feature set.
  - Each feature is divided into subfolders for "data" and "presentation".
    - data: Contains "api", "model", and "repository" files
      - api: Responsible for sending requests to the backend.
      - model: Contains data classes of the respective feature.
      - repository: Calls the methods of the "api" files and returns either success or failure objects.
    - presentation: Contains "view" and "cubit" files.
      - view: Contains the UI code for the feature
      - cubit: Calls "repositories" and emits new states based on the results returned from the repository.

## Coding Standards <a name="coding-standards"></a>

To ensure code consistency, maintainability, and readability across the project, we are following coding standards below:

- Naming conventions:
  - We use "camelCase" for variables and function names.
  - We use "PascalCase" for class and enum names.
  - We name files using "snake_case".
- Code formatting:
  - We use the [very_good_analysis](https://pub.dev/packages/very_good_analysis) package as a linter to automate the formatting and linting process.
- Code modularization:
  - We break down our code into smaller, reusable components or functions.
  - We organize code into folders based on feature.
- Error handling:
  - We implement proper error handling using functional programming concepts like "Either" to manage errors.
  - We catch exceptions and provide meaningful error messages to users when necessary.
- Version Control:
  - We use a version control system as Git to keep track of our code changes

## How to Run <a name="how-to-run"></a>

First, ensure that the Flutter SDK is installed on your computer.

Second, clone the repository by entering the following command in your terminal:

```sh
git clone https://github.com/WinMeet/winmeet_mobile
```

Third, navigate to the root folder of the project and install the dependencies by running:

```sh
flutter pub get
```

Then, generate necessary files by running the following command in the same folder:

```sh
flutter pub run build_runner build --delete-conflicting-outputs
```

Finally, start the app using the appropriate command based on your desired environment:

- For development environment, use:

  ```sh
  flutter run lib/main_dev.dart
  ```

- For production environment, use:

  ```sh
  flutter run lib/main_prod.dart
  ```
