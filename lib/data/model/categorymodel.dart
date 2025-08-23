// category_model.dart

class CategoryModel {
  final String categoryName;
  final int categoryId;
  final int? parentCategoryId;

  CategoryModel({
    required this.categoryName,
    required this.categoryId,
    this.parentCategoryId,
  });

  // دالة ثابتة لتحويل قائمة JSON إلى قائمة من CategoryModel
  static List<CategoryModel> fromJsonList(Map<String, dynamic> json) {
    // نصل مباشرة إلى قائمة 'category' داخل 'data'
    if (json['data'] != null && json['data']['category'] != null) {
      final List<dynamic> categoryListJson = json['data']['category'];

      // نقوم بتحويل كل عنصر في القائمة إلى كائن CategoryModel
      return categoryListJson
          .map((itemJson) => CategoryModel.fromJson(itemJson))
          .toList();
    }
    // في حالة عدم وجود بيانات، نرجع قائمة فارغة
    return [];
  }

  // دالة لتحويل عنصر JSON واحد إلى كائن CategoryModel
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryName: json['category_name'] ?? 'Unnamed',
      categoryId: json['category_id'] ?? 0,
      parentCategoryId:
          json['parent_category_id'], // سيكون null تلقائياً إذا لم يكن موجوداً
    );
  }
}
