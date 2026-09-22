# WristSync — Smartwatch Companion Application

WristSync is a Bluetooth Low Energy (BLE) smartwatch companion application built with Flutter, GetX, and Clean Architecture principles. It features a complete pairing lifecycle: splash routing, device categorization, active BLE advertisement scanning with real-time RSSI sorting, GATT service discovery, and connection state management.

---

## Architecture & Design Patterns

The project follows Clean Architecture separated into distinct layers to maintain scalability, readability, and testability:

- **Presentation Layer (`lib/features/`):** Strict separation using GetX pattern (`View`, `Controller`, `Binding`). Views remain declarative and stateless where possible, observing reactive variables (`RxList`, `RxBool`) to prevent unnecessary full-tree rebuilds.
- **Service Layer (`lib/core/services/`):** Persistent background singleton (`BleService`) that manages native Bluetooth hardware states, stream subscriptions, and GATT connections independently of the UI lifecycle.
- **Design System (`lib/core/`):** Centralized theme tokens (`AppTheme`, `AppColors`, `customTextTheme`) and reusable atomic components (`AppCard`, `AppButton`, `AppHeader`, `AppSnackbar`) to prevent UI duplication.

---

## Features Implemented

- **Splash & Run-Once Onboarding:** Native splash integration paired with a persistent routing gatekeeper via `SharedPreferences`.
- **Hardware Permission Negotiation:** Runtime permission handling for Android 12+ (`BLUETOOTH_SCAN`, `BLUETOOTH_CONNECT`) and legacy versions (`FINE_LOCATION`).
- **Real-Time BLE Scanning:** Live packet listener that filters unnamed peripherals and dynamically sorts devices by signal strength (`RSSI`).
- **GATT Connection & Lifecycle Monitoring:** Real GATT connection negotiation with automatic fallback and disconnection stream listeners.
- **Dual-Perspective Device Info:**
  - *Consumer View:* Device name, active connection badge, and battery metric.
  - *System Diagnostics:* Live MAC address, negotiated MTU packet size, and discovered GATT service channels.
- **Clean Termination:** Manual disconnect trigger that closes the GATT client and safely resets app state.

---

## Tech Stack

- **Framework:** Flutter (Channel stable)
- **State Management:** GetX
- **Bluetooth Low Energy:** `flutter_blue_plus`
- **Permissions:** `permission_handler`
- **Persistence:** `shared_preferences`

---

## Getting Started

### Prerequisites
- Flutter SDK installed
- A physical Android device with Bluetooth enabled (BLE scanning cannot be performed on standard Android emulators).

### Installation & Run
```bash
git clone [https://github.com/](https://github.com/)<your-username>/wrist_sync.git
cd wrist_sync
flutter pub get
flutter run