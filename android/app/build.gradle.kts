plugins {
  id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
  id("kotlin-android")
  id("dev.flutter.flutter-gradle-plugin")
}

android {
  namespace = "com.example.e_comerece"
  compileSdk = flutter.compileSdkVersion
  ndkVersion = "27.0.12077973"

  defaultConfig {
    applicationId = "com.example.e_comerece"
    minSdk = 23
    targetSdk = flutter.targetSdkVersion
    versionCode = flutter.versionCode
    versionName = flutter.versionName
  }

  compileOptions {
    sourceCompatibility = JavaVersion.VERSION_1_8
    targetCompatibility = JavaVersion.VERSION_1_8
    isCoreLibraryDesugaringEnabled = true
  }

  kotlinOptions {
    jvmTarget = "1.8"  // يفضل 1.8 مع desugaring
  }

  buildTypes {
    release {
      signingConfig = signingConfigs.getByName("debug")
    }
  }
}

flutter {
  source = "../.."
}

dependencies {
  coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
  // ... باقي dependencies
}
