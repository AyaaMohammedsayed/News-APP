class CategoryModel {
  String name;
  String id;
  String imageName;
  CategoryModel({
    required this.name,
    required this.id,
    required this.imageName,
  });
 static List<CategoryModel> categoryModels = [
    CategoryModel(name: 'Busniess', id: 'business', imageName: "busniess"),
    CategoryModel(name: 'Entertainment', id: 'entertainment', imageName: "entertrainment"),
    CategoryModel(name: 'General', id: 'general', imageName: "general"),
    CategoryModel(name: 'Health', id: 'health', imageName: "health"),
    CategoryModel(name: 'Science', id: 'science', imageName: "sceince"),
    CategoryModel(name: 'Sport', id: 'sports', imageName: "sports"),
    CategoryModel(name: 'Technology', id: 'technology', imageName: "tech"),

  ];
}
