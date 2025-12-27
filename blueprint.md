# E-Scooter Dashboard App Blueprint

## Overview

This document outlines the plan and implementation details for the E-Scooter Dashboard Flutter application. The app will feature a futuristic glassmorphism UI and connect to Firebase for real-time data updates.

## Current Plan

The current development goal is to build the main dashboard screen with the following features:

### UI & Design

*   **Background:** A deep purple/dark blue gradient.
*   **Style:** Glassmorphism with rounded, semi-transparent frosted-glass containers.
*   **Font:** `Inter` from Google Fonts.
*   **Layout:**
    *   A main container with the E-Scooter title and a battery indicator.
    *   A central circular speedometer.
    *   A row with phone battery, distance traveled, and a digital clock.
    *   A large animated button at the bottom.

### Features

1.  **Speedometer:**
    *   A circular gauge with a max speed of 70km/h.
    *   The current speed will be displayed prominently in the center.
    *   The speed will be updated in real-time from Firebase Realtime Database.

2.  **Data Display:**
    *   **Phone Battery:** Show the phone's current battery percentage.
    *   **Distance Traveled:** Display the distance, updated from Firebase.
    *   **Digital Clock:** Show the current time.

3.  **Animated Button:**
    *   A large glassmorphism button at the bottom.
    *   Initially shows a clock icon.
    *   On press, it will animate to show "Traveled Time".
    *   After 3 seconds, it will automatically animate back to the clock icon.

4.  **Backend:**
    *   Use Firebase Realtime Database to listen for changes in `speed` and `distance`.
    *   The app will require Firebase to be initialized.

## Action Steps

1.  **Project Setup:**
    *   Add dependencies: `firebase_core`, `firebase_database`, `battery_plus`, `google_fonts`, `intl`, `provider`, `sleek_circular_slider`, `glassmorphism`.
    *   Initialize Firebase in `lib/main.dart`.
    *   Create `blueprint.md`.

2.  **UI Development:**
    *   Create the main app structure with the background gradient.
    *   Implement the glassmorphism containers.
    *   Add the speedometer using `sleek_circular_slider`.
    *   Create the data row with icons and text.
    *   Implement the animated button with `AnimatedSwitcher`.

3.  **State Management & Backend Integration:**
    *   Set up a `ChangeNotifier` with `provider` to manage the app state (speed, distance, etc.).
    *   Implement the Firebase Realtime Database listener to update the state.
    *   Use the `battery_plus` package to get the phone's battery level.

4.  **Refinement:**
    *   Ensure the UI matches the design provided.
    *   Test the real-time data updates and animations.
    *   Format code and ensure good practices.
