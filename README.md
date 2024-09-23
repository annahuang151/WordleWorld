# WordleWorld
A flutter project. Can be played for fun! Please follow the instructions to download!

### Steps to Generate an APK in Flutter:

1. **Ensure You Have the Necessary Setup:**
    - You should have **Flutter** and **Android Studio** installed and set up with the appropriate Android SDK.
2. **Switch to Release Mode:**
    - By default, Flutter runs apps in `debug` mode, but for distribution, you’ll want to use `release` mode. In your terminal, run:
        
        ```bash
        flutter build apk --release
        ```
        
3. **Locate the APK:**
    - After the build is successful, you’ll find the APK in the following path:
        
        ```arduino
        /build/app/outputs/flutter-apk/app-release.apk
        ```
        
4. **Transfer the APK to Your Phone:**
    - You can transfer the APK file to your phone via USB, email, or a cloud service like Google Drive.
5. **Install the APK:**
    - On your Android device, navigate to the APK file and open it. You may need to enable installation from unknown sources in your phone’s settings:
        - Go to **Settings** > **Security** > **Install unknown apps** and enable the app you used to transfer the APK (e.g., Google Drive, file browser).
        - After enabling this, proceed with the APK installation.
6. **Run the App:**
    - Once installed, you can run the app on your phone like any other app.
