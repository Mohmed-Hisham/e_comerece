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
    compileSdk = 36
    ndkVersion = "27.0.12077973"

    defaultConfig {
        applicationId = "com.example.e_comerece"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // اختياري: لتضمين فقط هذه الـ ABIs داخل APK واحد (إذا تريد تقليل حجم الـ fat APK بدون split-per-abi)
        // احذف هذا الجزء إذا تريد دعم جميع الـ ABIs.
        // ndk {
        //     abiFilters += setOf("armeabi-v7a", "arm64-v8a")
        // }
    }

    compileOptions {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
    isCoreLibraryDesugaringEnabled = true
}

kotlinOptions {
    jvmTarget = "17"
}

    buildTypes {
        getByName("release") {
            // إيقاف الـ minification لتجنب حذف الكلاسات المهمة
            isMinifyEnabled = false
            isShrinkResources = false

            // signing config كما كان عندك
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
