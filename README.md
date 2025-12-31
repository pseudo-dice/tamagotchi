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

### Current Linux Builds

- **Android APK** — Generated with `flutter build apk --release`; output at `build/app/outputs/flutter-apk/app-release.apk`.
- **Linux desktop bundle** — Generated with `flutter build linux`; output folder at `build/linux/x64/release/bundle/`.
- **Web bundle** — Generated with `flutter build web`; static assets in `build/web/` ready to deploy to any static host.

Recreate the artifacts by running the commands above from the project root after `flutter pub get`. Copy the resulting files/folders to your distribution channel (for example, attach the APK and Linux bundle to a GitHub Release, and upload the web directory to a CDN or static hosting service).

### Other Platforms

Additional targets remain available when building on their respective host operating systems:

- **Android App Bundle:** `flutter build appbundle`
- **iOS:** `flutter build ipa` *(requires macOS with Xcode)*
- **Windows:** `flutter build windows` *(requires Windows with Visual Studio build tools)*
- **macOS:** `flutter build macos` *(requires macOS)*

Review the Flutter docs for platform-specific code signing and store submission details.
