import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // فقط لو عايز تحدد content-type
import 'dart:convert';

Future<String?> uploadToCloudinary({
  required String filePath,
  required String cloudName,
  required String uploadPreset,
}) async {
  final uri = Uri.parse(
    'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
  );

  final request = http.MultipartRequest('POST', uri);
  // file
  final file = await http.MultipartFile.fromPath(
    'file',
    filePath,
    contentType: MediaType('image', filePath.split('.').last),
  );
  request.files.add(file);

  // preset
  request.fields['upload_preset'] = uploadPreset;

  try {
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      // الرابط النهائي
      return map['secure_url'] as String?;
    } else {
      print('Upload failed: ${response.statusCode} ${response.body}');
      return null;
    }
  } catch (e) {
    print('Upload error: $e');
    return null;
  }
}
