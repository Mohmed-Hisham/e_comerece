import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/core/funcations/checkinternet.dart';
import 'package:http/http.dart' as http;

class Crud {
  Future<Either<Statusrequest, Map>> postData(
    String linlurl,
    Map data, {
    bool sendJson = false,
  }) async {
    try {
      if (await checkInternet()) {
        http.Response response;

        if (sendJson) {
          // log('data: ${jsonEncode(data)}');

          response = await http.post(
            Uri.parse(linlurl),
            headers: {'Content-Type': 'application/json; charset=utf-8'},
            body: jsonEncode(data),
          );
          log('response======: ${response.statusCode}');
          // log('response======: ${response.body}');
        } else {
          final Map<String, String> bodyFields = {};
          data.forEach((key, value) {
            bodyFields[key] = value == null ? '' : value.toString();
          });

          response = await http.post(Uri.parse(linlurl), body: bodyFields);
        }
        log('cod: ${response.statusCode}');
        // log('response======: ${response.body}');
        if (response.statusCode == 200 || response.statusCode == 201) {
          final Map respnsebody = jsonDecode(response.body);
          // log('respnsebody: $respnsebody');
          return Right(respnsebody);
        } else if (response.statusCode == 400 || response.statusCode == 401) {
          return const Left(Statusrequest.failuer);
        } else if (response.statusCode == 404 || response.statusCode == 500) {
          return const Left(Statusrequest.noData);
        } else {
          return const Left(Statusrequest.serverfailuer);
        }
      } else {
        return const Left(Statusrequest.oflinefailuer);
      }
    } catch (e, st) {
      log('Exception Error in Crud: $e \n $st');
      return const Left(Statusrequest.failuerException);
    }
  }
  // --------------------------------------------------------------------------

  Future<Either<Statusrequest, Map<String, dynamic>>> getData(
    String linkUrl, {
    Map<String, String>? headers,
    Duration timeout = const Duration(minutes: 1),
    http.Client? client,
    bool debug = false,
  }) async {
    client ??= http.Client();
    try {
      if (!await checkInternet()) {
        return const Left(Statusrequest.oflinefailuer);
      }

      final uri = Uri.parse(linkUrl);
      final response = await client.get(uri, headers: headers).timeout(timeout);

      final statusCode = response.statusCode;
      final body = response.body;

      if (debug) {
        log('GET $uri -> $statusCode');
        log('GET Response: $body');
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
            log('Unexpected JSON type: ${decoded.runtimeType}');
          }
          return const Left(Statusrequest.failuer);
        } on FormatException catch (e, st) {
          if (debug) {
            log('JSON Format Error: $e\n$st');
            log('Response body: $body');
          }
          return const Left(Statusrequest.failuerException);
        }
      }

      if (statusCode >= 500) {
        if (debug) {
          log('Server Error $statusCode: ${response.body}');
        }
        return const Left(Statusrequest.serverfailuer);
      } else if (statusCode >= 400) {
        if (debug) {
          log('Client Error $statusCode: ${response.body}');
        }
        return const Left(Statusrequest.failuer);
      }

      return const Left(Statusrequest.failuer);
    } on TimeoutException catch (e, st) {
      if (debug) log('Timeout Error: $e\n$st');
      return const Left(Statusrequest.serverfailuer);
    } on SocketException catch (e, st) {
      if (debug) log('Socket Error: $e\n$st');
      return const Left(Statusrequest.oflinefailuer);
    } catch (e, st) {
      if (debug) {
        log('Unhandled Exception: $e\n$st');
      }
      return const Left(Statusrequest.failuerException);
    } finally {
      client.close();
    }
  }
}
