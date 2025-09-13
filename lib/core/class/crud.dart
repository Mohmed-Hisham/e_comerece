import 'dart:convert';
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

  Future<Either<Statusrequest, Map>> getData(
    String linkurl, {
    Map<String, String>? headers,
  }) async {
    try {
      if (await checkinternet()) {
        var response = await http.get(Uri.parse(linkurl), headers: headers);

        if (response.statusCode == 200 || response.statusCode == 201) {
          if (response.body.isEmpty) {
            print('No Data: ${response.body}');

            return const Left(Statusrequest.noData);
          }
          Map responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else {
          print('Server Error: ${response.body}');
          return const Left(Statusrequest.serverfailuer);
        }
      } else {
        return const Left(Statusrequest.oflinefailuer);
      }
    } catch (e) {
      print('Exception Error: $e');
      return const Left(Statusrequest.failuerException);
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
