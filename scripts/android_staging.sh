flutter clean &&
flutter pub get &&
flutter build apk -t lib/main.dart --obfuscate --split-debug-info "obfuscate" &&
cd android/ && bundle install --path vendor/bundle &&
bundle exec fastlane firebase_distribution --env public