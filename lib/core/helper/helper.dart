import 'package:news/features/category/data/category_model.dart';

class Helper {
  static List<CategoryModel> searchCategory(String query) {
    if (query.trim().isEmpty) {
      return CategoryModel.categoryModels; 
    }

    return CategoryModel.categoryModels.where((category) {
      return category.name.toLowerCase().contains(query.toLowerCase().trim());
    }).toList();
  }
}