# Trip Tracker

## Synopsis

Trip Tracker is a mobile application designed to parse .txt files for Driver and Trip data. The application was built using the Flutter framework and works on both iOS and Android.

## Setting up for running and testing

If you do not have the [Flutter SDK](https://flutter.dev/docs/get-started/install), click the link provided to get setup! After that, make sure the Flutter and Dart extentions are installed in your preferred IDE. VSCode was used for the construction of this project, so the helpful hints will be coming from that perspective.

## Testing

In order to run all available tests, simply run `flutter test` from the top of the project directory. You may also use the VSCode command pallette to search for `Dart: Run All Tests`.

You can run indiividual tests by running `flutter test path_to_test_file.dart`. For example: `flutter run test/driver_test.dart`

## Running

`flutter run` can be used to run the application on a single connected device/emulator. If there are multiple devices connected, use `flutter run -d all` to run the app on all devices.

Before the app can be ran on iOS, a development team must be selected using Xcode.

## Screenshot

![screenshot](https://github.com/drexel-ue/trip_tracker_mobile/blob/master/example.png)
