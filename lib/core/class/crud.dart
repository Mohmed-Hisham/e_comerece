import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/checkinternet.dart';
import 'package:http/http.dart' as http;

class Crud {
  Future<Either<Statusrequest, Map>> postData(String linlurl, Map data) async {
    try {
      if (await checkinternet()) {
        var response = await http.post(Uri.parse(linlurl), body: data);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map respnsebody = jsonDecode(response.body);
          return Right(respnsebody);
        } else {
          return const Left(Statusrequest.serverfailuer);
        }
      } else {
        return const Left(Statusrequest.oflinefailuer);
      }
    } catch (e) {
      print('Exception Error in Crud: $e');

      return const Left(Statusrequest.failuerException);
    }
  }

  Future<Either<Statusrequest, Map<String, dynamic>>> getData(
    String linkUrl, {
    Map<String, String>? headers,
    Duration timeout = const Duration(seconds: 15),
    http.Client? client,
    bool debug = false,
  }) async {
    client ??= http.Client();
    try {
      if (!await checkinternet()) {
        return const Left(Statusrequest.oflinefailuer);
      }

      final uri = Uri.parse(linkUrl);
      final response = await client.get(uri, headers: headers).timeout(timeout);

      final statusCode = response.statusCode;
      final body = response.body;

      if (debug) {
        print('GET $uri -> $statusCode');
        print('GET Response: $body');
      }

      if (statusCode == 204 || body.trim().isEmpty) {
        return const Left(Statusrequest.noData);
      }

      if (statusCode >= 200 && statusCode < 300) {
        try {
          final decoded = jsonDecode(body);

          if (decoded is Map<String, dynamic>) {
            return Right(decoded);
          }

          if (decoded is List) {
            return Right(<String, dynamic>{'data': decoded});
          }

          if (debug) {
            print('Unexpected JSON type: ${decoded.runtimeType}');
          }
          return const Left(Statusrequest.failuer);
        } on FormatException catch (e, st) {
          if (debug) {
            print('JSON Format Error: $e\n$st');
            print('Response body: $body');
          }
          return const Left(Statusrequest.failuerException);
        }
      }

      if (statusCode >= 500) {
        if (debug) {
          print('Server Error $statusCode: ${response.body}');
        }
        return const Left(Statusrequest.serverfailuer);
      } else if (statusCode >= 400) {
        if (debug) {
          print('Client Error $statusCode: ${response.body}');
        }
        return const Left(Statusrequest.failuer);
      }

      return const Left(Statusrequest.failuer);
    } on TimeoutException catch (e, st) {
      if (debug) print('Timeout Error: $e\n$st');
      return const Left(Statusrequest.serverfailuer);
    } on SocketException catch (e, st) {
      if (debug) print('Socket Error: $e\n$st');
      return const Left(Statusrequest.oflinefailuer);
    } catch (e, st) {
      if (debug) {
        print('Unhandled Exception: $e\n$st');
      }
      return const Left(Statusrequest.failuerException);
    } finally {
      client.close();
    }
  }
}

// import 'dart:convert';
// import 'package:dartz/dartz.dart';
// import 'package:e_comerece/core/class/statusrequest.dart';
// import 'package:e_comerece/core/funcations/checkinternet.dart';
// import 'package:http/http.dart' as http;

// class Crud {
//   Future<Either<Statusrequest, Map>> postData(String linlurl, Map data) async {
//     try {
//       if (await checkinternet()) {
//         var response = await http.post(Uri.parse(linlurl), body: data);
//         if (response.statusCode == 200 || response.statusCode == 201) {
//           Map respnsebody = jsonDecode(response.body);
//           return Right(respnsebody);
//         } else {
//           return const Left(Statusrequest.serverfailuer);
//         }
//       } else {
//         return const Left(Statusrequest.oflinefailuer);
//       }
//     } catch (e) {
//       return const Left(Statusrequest.failuerException);
//     }
//   }
// }
