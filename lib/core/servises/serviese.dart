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
    // await secureStorage.delete(key: token);
    // await secureStorage.write(
    //   key: token,
    //   value:
    //       "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiIwMTliN2FjZi1iMWQ0LTcyMmQtYjIzYi00MzUyNzFjZjIyNjQiLCJlbWFpbCI6Im1oNjI4NTQzNkBnbWFpbC5jb20iLCJ1bmlxdWVfbmFtZSI6InNkZnNkZnNkIiwibmJmIjoxNzY3NTU5NTcyLCJleHAiOjE3Njc1NjEzNzIsImlhdCI6MTc2NzU1OTU3MiwiaXNzIjoiTXlBdXRoU2VydmVyIiwiYXVkIjoiTXlBdXRoQ2xpZW50In0.pCSlapU-mhKLzOx7sBg_-WoU-U7IHPxTLP1e48ZuXwo",
    // );
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
