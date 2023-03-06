# Example use of script
# sh scripts/android_build.sh 1.0.0 1 prod bundle

BUILD_NAME="$1"
BUILD_NUMBER="$2"
ENVIRONMENT="$3"
BUILD_TYPE="$4"

if [ "$BUILD_TYPE" == "bundle" ] && [ "$ENVIRONMENT" == "prod" ]; then
    flutter build appbundle --build-name="$BUILD_NAME" --build-number="$BUILD_NUMBER" -t lib/main_prod.dart
    open build/app/outputs/bundle/release
elif [ "$BUILD_TYPE" == "bundle" ] && [ "$ENVIRONMENT" == "dev" ]; then
    flutter build appbundle --build-name="$BUILD_NAME" --build-number="$BUILD_NUMBER" -t lib/main_dev.dart
    open build/app/outputs/bundle/release
elif [ "$BUILD_TYPE" == "apk" ] && [ "$ENVIRONMENT" == "prod" ]; then
    flutter build apk --build-name="$BUILD_NAME" --build-number="$BUILD_NUMBER" -t lib/main_prod.dart
    open build/app/outputs/flutter-apk
elif [ "$BUILD_TYPE" == "apk" ] && [ "$ENVIRONMENT" == "dev" ]; then
    flutter build apk --build-name="$BUILD_NAME" --build-number="$BUILD_NUMBER" -t lib/main_dev.dart
    open build/app/outputs/flutter-apk/
fi

