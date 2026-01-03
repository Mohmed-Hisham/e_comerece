import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServises extends GetxService {
  late SharedPreferences sharedPreferences;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  String? step;

  Future<MyServises> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    step = await secureStorage.read(key: "step");
    return this;
  }

  Future<void> saveStep(String value) async {
    step = value;
    await secureStorage.write(key: "step", value: value);
  }

  Future<void> saveSecureData(String key, String value) async {
    if (key == "step") step = value;
    await secureStorage.write(key: key, value: value);
  }

  Future<String?> getSecureData(String key) async {
    if (key == "step") return step;
    return await secureStorage.read(key: key);
  }

  Future<void> deleteSecureData(String key) async {
    if (key == "step") step = null;
    await secureStorage.delete(key: key);
  }

  Future<void> clearAllSecureData() async {
    step = null;
    await secureStorage.deleteAll();
  }
}

initlizserviese() async {
  await Get.putAsync(() => MyServises().init());
}
