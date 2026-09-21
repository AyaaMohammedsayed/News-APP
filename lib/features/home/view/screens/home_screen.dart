import 'package:flutter/material.dart';


import 'package:news/features/category/data/category_model.dart';
import 'package:news/features/category/view/widgets/category_view.dart';
import 'package:news/features/home/view/widgets/home_drawer.dart';
import 'package:news/features/news/view/widgets/new_view.dart';


class HomeScreen extends StatefulWidget {
  static const String routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryModel? categoryModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(resetModel:resetSelectedCategoryModel ,),
      appBar: AppBar(
        actionsPadding: EdgeInsets.all(24),
        actions: [Icon(Icons.search)],
        title: categoryModel == null ? Text('Home') : Text(categoryModel!.name),
      ),
      body: 
      categoryModel == null
           ?Expanded(child: CategoryView(onChangeCategory: onChangeCategory))
          : Expanded(child: NewView(categoryId: categoryModel!.id)),
    );
  }

  void onChangeCategory(CategoryModel model) {
    categoryModel = model;
    setState(() {});
  }

  void resetSelectedCategoryModel() {
    if (categoryModel == null) return;
    categoryModel = null;
    setState(() {
      
    });
  }
}
