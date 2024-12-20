# gabriel_tour_app

A Flutter project for Gabriel Tour Travel Agency (App + WebApp).

## Installation Guide

Prerequisites

Install Git for version control.
Install Flutter SDK.
Install VS Code and the Flutter extension.

Clone the Repository
Open a terminal or command prompt.
Navigate to the directory where you want to store the project.
Clone the repository using: git clone https://github.com/ViktorVegh/GabrielTourFrontend.git and navigate to project fodler: cd GabrielTourFrontend

Fetch Dependencies
flutter pub get


Installation on Android

1. Setup for Android Emulator

Install Android Studio:

Download and install Android Studio.

Open Android Studio and go to Configure > AVD Manager.

Create a new virtual device and select a phone model (e.g., Pixel 5).

Choose a system image (e.g., Android 12 or higher) and download it.

Start the emulator.

Run the App in VS Code:

Open your Flutter project in VS Code.

Launch the emulator from the Device dropdown in the bottom-right corner of VS Code.

Run the app using the command:

flutter run

2. Installation on a Physical Android Device

Enable Developer Options and USB Debugging:

On your Android device, go to Settings > About Phone.

Tap Build Number 7 times to enable Developer Mode.

Go to Developer Options and enable USB Debugging.

Connect the Device to Your Computer:

Use a USB cable to connect your Android device to your computer.

Ensure the device is detected by running:

flutter devices

Build and Install the APK:

Build the APK file by running:

flutter build apk

Install the APK on your device:

flutter install

Open the app on your Android device.

Installation on iOS

1. Setup for iOS Simulator

Install Xcode:

Download and install Xcode.

Open Xcode and go to Preferences > Locations to set the command-line tools path.

Run the iOS Simulator:

Open Xcode and go to Window > Devices and Simulators > Simulators.

Select a device (e.g., iPhone 14) and start the simulator.

Run the App in VS Code:

Open your Flutter project in VS Code.

Select the iOS Simulator from the Device dropdown in VS Code.

Run the app using the command:

flutter run

2. Installation on a Physical iOS Device

Register and Configure Your Apple Developer Account:

Sign in to your Apple Developer account at developer.apple.com.

Register your device's UDID in the Developer Portal.

Connect the Device to Your Computer:

Use a USB cable to connect your iPhone to your computer.

Trust the computer on your device when prompted.

Build and Install the App:

Build the app for iOS by running:

flutter build ios

Open the project in Xcode:

open ios/Runner.xcworkspace

In Xcode, select your connected device and click Run to install the ap
