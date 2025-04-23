plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    signingConfigs {
        create("keystore") {
            keyAlias = "key"
            keyPassword = "112233"
            storeFile = file("key.jks")
            storePassword = "112233"
        }
    }
    buildTypes {
        val signConfig = signingConfigs.getByName("keystore")
        getByName("release") {
            isMinifyEnabled = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rule.pro"
            )
            signingConfig = signConfig
        }
    }
    
    namespace = "com.CoinZone.CoinZone"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"  // flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.CoinZone.CoinZone"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

dependencies{
    implementation("com.appsflyer:ext:0.1.0")
    implementation("com.networkh.lib:ktx:0.0.8")
    implementation(platform("com.google.firebase:firebase-bom:33.11.0"))
    implementation("com.google.firebase:firebase-firestore")
    
}

flutter {
    source = "../.."
}
