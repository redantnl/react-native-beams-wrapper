# react-native-beams-wrapper

A react native wrapper for the Pusher Beams SDK

## Installation

### Android
yarn / npm
```sh
npm install react-native-beams-wrapper

yarn add react-native-beams-wrapper
```

Go to `android/app/build.gradle` and add the following lines:

```
android {
  ...
  defaultConfig {
        applicationId "com.example.reactnativebeamswrapper"
        minSdkVersion rootProject.ext.minSdkVersion
        targetSdkVersion rootProject.ext.targetSdkVersion
        versionCode 1
        versionName "1.0"
        multiDexEnabled true //Add this line
  }
  ...
}

dependencies {
      implementation fileTree(dir: "libs", include: ["*.jar"])
    //noinspection GradleDynamicVersion
    implementation "com.facebook.react:react-native:+"  // From node_modules

    implementation 'com.google.firebase:firebase-messaging:20.2.3' // Add this line
    implementation 'com.pusher:push-notifications-android:1.6.2' // Add this line

    implementation "androidx.swiperefreshlayout:swiperefreshlayout:1.0.0"
    ...
}
```

Then download your google.services.json from the [firebase console](https://console.firebase.google.com/),
and add the file to `android/app/`

## Usage

```js
import BeamsWrapper from "react-native-beams-wrapper";

// ...

const result = await BeamsWrapper.multiply(3, 7);
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
