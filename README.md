# WinMeet Mobile

## Project Structure

- The app folder contains files specific to this particular application.
- The core folder contains application-agnostic code that can be reused in other projects.
- The feature folder represents the app's feature set. Each feature is divided into subfolders for data and presentation.

## How to run

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

Finally, start the app using the command:

```sh
flutter run lib/main_dev.dart
```
