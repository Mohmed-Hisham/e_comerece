import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class FirebaseStorageHelper {
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static const _uuid = Uuid();

  /// Upload a file to Firebase Storage and return the download URL
  ///
  /// [file] - The file to upload
  /// [folder] - The folder path in Firebase Storage (e.g., 'images', 'sliders', 'about_us')
  /// [customFileName] - Optional custom file name. If null, a unique name will be generated
  ///
  /// Returns the download URL of the uploaded file, or null if upload fails
  static Future<String?> uploadFile({
    required File file,
    required String folder,
    String? customFileName,
  }) async {
    try {
      // Generate unique file name if not provided
      final String extension = path.extension(file.path);
      final String fileName = customFileName ?? '${_uuid.v4()}$extension';

      // Create reference to the file location
      final Reference ref = _storage.ref().child(folder).child(fileName);

      // Upload file
      final UploadTask uploadTask = ref.putFile(file);

      // Wait for upload to complete
      final TaskSnapshot snapshot = await uploadTask;

      // Get download URL
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      log('File uploaded successfully: $downloadUrl');
      return downloadUrl;
    } on FirebaseException catch (e) {
      log('Firebase Storage Error: ${e.code} - ${e.message}');
      return null;
    } catch (e) {
      log('Error uploading file: $e');
      return null;
    }
  }

  /// Upload an image file specifically
  ///
  /// [imageFile] - The image file to upload
  /// [folder] - The folder path (defaults to 'images')
  ///
  /// Returns the download URL of the uploaded image
  static Future<String?> uploadImage({
    required File imageFile,
    String folder = 'images',
  }) async {
    return uploadFile(file: imageFile, folder: folder);
  }

  /// Upload multiple files and return list of download URLs
  ///
  /// [files] - List of files to upload
  /// [folder] - The folder path in Firebase Storage
  ///
  /// Returns list of download URLs (null entries for failed uploads)
  static Future<List<String?>> uploadMultipleFiles({
    required List<File> files,
    required String folder,
  }) async {
    final List<Future<String?>> uploadFutures = files.map((file) {
      return uploadFile(file: file, folder: folder);
    }).toList();

    return Future.wait(uploadFutures);
  }

  /// Delete a file from Firebase Storage by its URL
  ///
  /// [fileUrl] - The download URL of the file to delete
  ///
  /// Returns true if deletion was successful
  static Future<bool> deleteFileByUrl(String fileUrl) async {
    try {
      final Reference ref = _storage.refFromURL(fileUrl);
      await ref.delete();
      log('File deleted successfully: $fileUrl');
      return true;
    } on FirebaseException catch (e) {
      log('Firebase Storage Delete Error: ${e.code} - ${e.message}');
      return false;
    } catch (e) {
      log('Error deleting file: $e');
      return false;
    }
  }

  /// Delete a file from Firebase Storage by its path
  ///
  /// [filePath] - The path of the file in storage (e.g., 'images/my-image.jpg')
  ///
  /// Returns true if deletion was successful
  static Future<bool> deleteFileByPath(String filePath) async {
    try {
      final Reference ref = _storage.ref().child(filePath);
      await ref.delete();
      log('File deleted successfully: $filePath');
      return true;
    } on FirebaseException catch (e) {
      log('Firebase Storage Delete Error: ${e.code} - ${e.message}');
      return false;
    } catch (e) {
      log('Error deleting file: $e');
      return false;
    }
  }
}
