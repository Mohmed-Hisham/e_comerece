import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ServicesHelper {
  static void saveLocal(String key, String value) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: key, value: value);
  }

  static Future<String?> getLocal(String key) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: key);
    return token;
  }

  static void removeLocal(String key) async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: key);
  }
}
