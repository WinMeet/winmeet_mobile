# WinMeet Mobile

## Project Structure

- "core" folder contains application-agnostic code that can be reused in other projects.
- "app" folder holds files specific to this particular application.

## How to run

First, clone the repository by entering the following command in your terminal:

```sh
git clone https://github.com/WinMeet/winmeet_mobile
```

Second, navigate to the root folder of the project and install the dependencies by running:

```sh
flutter pub get
```

Then, generate necessary files by running the following command in the same folder:

```sh
flutter pub run build_runner build --delete-conflicting-outputs
```

Finally, start the app using the command:

```sh
flutter run
```
