class ServiceRequestModel {
  String? status;
  List<ServiceRequestData>? data;

  ServiceRequestModel({this.status, this.data});

  ServiceRequestModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ServiceRequestData>[];
      json['data'].forEach((v) {
        data!.add(ServiceRequestData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceRequestData {
  int? requestId;
  int? userId;
  int? serviceId;
  String? status;
  String? quotedPrice;
  String? note;
  int? addressId;
  String? createdAt;

  ServiceRequestData({
    this.requestId,
    this.userId,
    this.serviceId,
    this.status,
    this.quotedPrice,
    this.note,
    this.addressId,
    this.createdAt,
  });

  ServiceRequestData.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
    userId = json['user_id'];
    serviceId = json['service_id'];
    status = json['status'];
    quotedPrice = json['quoted_price'];
    note = json['note'];
    addressId = json['address_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['request_id'] = requestId;
    data['user_id'] = userId;
    data['service_id'] = serviceId;
    data['status'] = status;
    data['quoted_price'] = quotedPrice;
    data['note'] = note;
    data['address_id'] = addressId;
    data['created_at'] = createdAt;
    return data;
  }
}
