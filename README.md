# PocketPet

An anime-inspired PocketPet virtual companion. Supports Android, iOS, Web, Windows, macOS, and Linux from a single codebase.

## Getting Started

1. [Install Flutter](https://docs.flutter.dev/get-started/install) 3.4 or newer and enable desired platforms (`flutter config --enable-web`, `--enable-windows-desktop`, `--enable-macos-desktop`, `--enable-linux-desktop`).
2. Fetch platform scaffolding:
   ```sh
   flutter create .
   ```
3. Get dependencies:
   ```sh
   flutter pub get
   ```
4. Run on your target platform, for example:
   ```sh
   flutter run -d chrome      # Web
   flutter run -d android     # Android emulator or device
   flutter run -d ios         # iOS simulator
   flutter run -d linux       # Linux desktop
   flutter run -d macos       # macOS desktop
   flutter run -d windows     # Windows desktop
   ```

## Game Features

- Persistent pet stats (hunger, energy, happiness) stored locally
- Timed stat decay even while the app is closed
- Simple interactions (feed, play, rest)
- Responsive layout that adapts to phones, tablets, and desktops

## Build Releases

- **Android:** `flutter build apk` or `flutter build appbundle`
- **iOS:** `flutter build ipa`
- **Web:** `flutter build web`
- **Windows:** `flutter build windows`
- **macOS:** `flutter build macos`
- **Linux:** `flutter build linux`

Refer to the official Flutter documentation for platform-specific signing and store submission steps.
