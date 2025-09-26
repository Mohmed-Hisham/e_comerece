import 'package:e_comerece/core/class/statusrequest.dart';

Statusrequest handlingData(response) {
  if (response is Statusrequest) {
    return response;
  } else {
    return Statusrequest.success;
  }
}

// Statusrequest handlingData(dynamic response) {
//   if (response is Statusrequest) return response;

//   if (response is Map && response.containsKey('result')) {
//     final result = response['result'];
//     if (result != null && result is Map && result.containsKey('status')) {
//       final status = result['status'];
//       if (status != null && status is Map && status.containsKey('code')) {
//         final dynamic rawCode = status['code'];
//         int? code;
//         if (rawCode is int) {
//           code = rawCode;
//         } else if (rawCode is String) {
//           code = int.tryParse(rawCode);
//         }

//         if (code != null) {
//           if (code == 200) return Statusrequest.success;
//           if (code == 205) return Statusrequest.noData;
//           return Statusrequest.failuer;
//         }
//       }
//     }
//   } else if (response['status'] == 'success') {
//     return Statusrequest.success;
//   }

//   return Statusrequest.failuer;
// }
