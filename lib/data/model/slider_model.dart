class SliderModel {
  final String? id;
  final bool? active;
  final String? imageUrl;
  final int? sortOrder;
  final String? platform;
  final String? actionType;
  final String? targetId;

  SliderModel({
    this.id,
    this.active,
    this.imageUrl,
    this.sortOrder,
    this.platform,
    this.actionType,
    this.targetId,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      id: json['id'],
      active: json['active'],
      imageUrl: json['imageUrl'],
      sortOrder: json['sortOrder'],
      platform: json['platform'],
      actionType: json['actionType'],
      targetId: json['targetId'],
    );
  }
}
