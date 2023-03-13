flutter clean
rm -f ios/Podfile.lock
rm -f pubspec.lock
flutter pub get
cd ../ios
pod deintegrate
pod install
pod update
cd ..