# Smart Class Check-in & Learning Reflection App

## Overview

Smart Class Check-in & Learning Reflection App is a Flutter-based mobile/web application designed to improve the class attendance process in universities.
The application allows students to check in to class using QR code scanning and GPS verification, and submit learning reflections after the class session.

This system helps instructors monitor attendance more accurately and encourages students to reflect on what they learned during class.

---

## Problem Statement

In many university classes, student attendance is still recorded using traditional methods such as signing a paper attendance sheet. This approach can lead to problems such as students signing in for others or inaccurate attendance records.

Additionally, there is no simple system that allows students to reflect on what they learned during the class.

Therefore, this application helps students:

* Check in to class
* Verify their physical presence using GPS
* Scan a QR code provided by the instructor
* Submit a learning reflection after class

---

## Target Users

1. University students attending classes
2. Instructors who want to monitor student participation and attendance

---

## Features

### 1. Class Check-in (Before Class)

Students can:

* Press the **Check-in button**
* Record GPS location automatically
* Record timestamp
* Scan the class **QR Code**
* Fill in a short reflection form

### 2. Pre-class Reflection

Students can input:

* Topic covered in the previous class
* What they expect to learn today
* Their mood before class (scale 1–5)

### 3. Class Completion (After Class)

Students must:

* Press **Finish Class**
* Scan the QR Code again
* Record GPS location

### 4. Post-class Reflection

Students can submit:

* What they learned in class
* Key takeaways
* Mood after class

---

## Technologies Used

* Flutter
* Dart
* Firebase Hosting
* SQLite (Local Database)
* QR Code Scanner
* Geolocation (GPS)

---

## Project Structure

```
lib/
 ├── main.dart
 ├── home_screen.dart
 ├── checkin_screen.dart
 ├── finish_screen.dart
 ├── database_helper.dart
```

---

## How to Run the Project

### 1. Clone the repository

```
git clone https://github.com/kaitod28/smart-class-app.git
```

### 2. Install dependencies

```
flutter pub get
```

### 3. Run the application

```
flutter run
```

### 4. Build for web

```
flutter build web
```

---

## Live Demo

Web Application:

https://smart-class-app-6731503027eiei.web.app

---

## GitHub Repository

https://github.com/kaitod28/smart-class-app

---

## Author

Student Project – Smart Class Mobile Application
Created using Flutter and Firebase.
