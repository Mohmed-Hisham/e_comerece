class CategorisModel {
  CategorisModel({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
  });

  final bool? success;
  final dynamic message;
  final Data? data;
  final dynamic errors;

  factory CategorisModel.fromJson(Map<String, dynamic> json) {
    return CategorisModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      errors: json["errors"],
    );
  }
}

class Data {
  Data({required this.result});

  final Result? result;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      result: json["result"] == null ? null : Result.fromJson(json["result"]),
    );
  }
}

class Result {
  Result({required this.status, required this.resultList});

  final Status? status;
  final List<ResultListCat> resultList;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      status: json["status"] == null ? null : Status.fromJson(json["status"]),
      resultList: json["resultList"] == null
          ? []
          : List<ResultListCat>.from(
              json["resultList"]!.map((x) => ResultListCat.fromJson(x)),
            ),
    );
  }
}

class ResultListCat {
  ResultListCat({required this.name, required this.id, required this.list});

  final String? name;
  final int? id;
  final List<ListElement> list;

  factory ResultListCat.fromJson(Map<String, dynamic> json) {
    return ResultListCat(
      name: json["name"],
      id: json["id"],
      list: json["list"] == null
          ? []
          : List<ListElement>.from(
              json["list"]!.map((x) => ListElement.fromJson(x)),
            ),
    );
  }
}

class ListElement {
  ListElement({required this.name, required this.id});

  final String? name;
  final int? id;

  factory ListElement.fromJson(Map<String, dynamic> json) {
    return ListElement(name: json["name"], id: json["id"]);
  }
}

class Status {
  Status({
    required this.code,
    required this.data,
    required this.executionTime,
    required this.requestTime,
    required this.requestId,
    required this.endpoint,
    required this.apiVersion,
    required this.functionsVersion,
    required this.la,
    required this.pmu,
    required this.mu,
  });

  final int? code;
  final String? data;
  final String? executionTime;
  final DateTime? requestTime;
  final String? requestId;
  final String? endpoint;
  final String? apiVersion;
  final String? functionsVersion;
  final String? la;
  final int? pmu;
  final int? mu;

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      code: json["code"],
      data: json["data"],
      executionTime: json["executionTime"],
      requestTime: DateTime.tryParse(json["requestTime"] ?? ""),
      requestId: json["requestId"],
      endpoint: json["endpoint"],
      apiVersion: json["apiVersion"],
      functionsVersion: json["functionsVersion"],
      la: json["la"],
      pmu: json["pmu"],
      mu: json["mu"],
    );
  }
}
