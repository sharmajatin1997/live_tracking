# 📍 Live Tracking — Flutter App

A **Flutter-based real-time live location tracking application** using **Google Maps** and **device GPS**. This repository demonstrates how to track a user’s location in real time, display it on a map, and update markers smoothly — suitable for delivery, ride-sharing, logistics, and tracking apps.

---

## 🚀 What This Repository Does

This project showcases:

* 📍 Real-time user location tracking
* 🗺️ Google Maps integration
* 📌 Live marker updates on map
* 🎯 Camera movement with location changes
* 🔐 Runtime location permissions handling
* 🧭 Clean and simple tracking UI

This repository can be used as a **starter template** or **reference implementation** for live tracking features.

---

## 🛠️ Tech Stack

* **Flutter** (UI & application logic)
* **google_maps_flutter** (Map rendering)
* **geolocator** (GPS & live location updates)
* **permission_handler** (Location permissions)

---

## 📂 Project Structure

```
lib/
 ├── main.dart
 ├── screens/
 │    └── live_tracking_screen.dart
 ├── services/
 │    └── location_service.dart
 ├── widgets/
 │    └── map_view.dart

pubspec.yaml
```

---

## ✨ Features Breakdown

### 1️⃣ Live Location Tracking

* Continuously listens to GPS location updates
* High-accuracy positioning support

### 2️⃣ Google Maps

* Displays current location on map
* Animated camera updates
* Customizable markers

### 3️⃣ Permissions Handling

* Requests location permissions at runtime
* Gracefully handles denied permissions

---

## 📦 Dependencies

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  google_maps_flutter: ^2.5.0
  geolocator: ^10.1.0
  permission_handler: ^11.3.1
```

---

## 🗺️ Google Maps Setup

### 1. Get API Key

* Go to **Google Cloud Console**
* Enable **Maps SDK for Android** and **Maps SDK for iOS**
* Generate an API key

---

### 2. Android Setup

`android/app/src/main/AndroidManifest.xml`

```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_GOOGLE_MAPS_API_KEY" />

<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

---

### 3. iOS Setup

`ios/Runner/Info.plist`

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>Location access is required for live tracking</string>

<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>Location access is required for live tracking</string>
```

`ios/Runner/AppDelegate.swift`

```swift
import GoogleMaps

GMSServices.provideAPIKey("YOUR_GOOGLE_MAPS_API_KEY")
```

---

## ▶️ How to Run

```bash
flutter pub get
flutter run
```

Run the app on a real device or emulator with location enabled.

---

## 🧪 Use Cases

* 🚚 Delivery & logistics tracking
* 🚕 Ride-sharing applications
* 🧑‍💼 Employee location tracking
* 📦 Fleet management systems
* 📍 Live location sharing apps

---

## 🧑‍💻 Author

**Jatin Sharma**
Flutter Developer

GitHub: [https://github.com/sharmajatin1997](https://github.com/sharmajatin1997)

---

## ⭐ Support

If this repository helps you:

* ⭐ Star the repo
* 🍴 Fork it
* 🧑‍💻 Use it in your projects

---

## 📄 License

This project is open-source and available under the **MIT License**.

---

> ⚠️ Note: For production apps, always secure your Google Maps API key and handle background location permissions carefully.
