flutter clean && flutter pub get && flutter build ios --release --no-codesign && cd ios/ && bundle install --path vendor/bundle && bundle exec fastlane firebase_distribution --env public