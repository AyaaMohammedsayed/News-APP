import 'package:flutter/material.dart';
import 'package:news/features/category/category_model.dart';


class CategoryItem extends StatelessWidget {
  CategoryModel model;
  CategoryItem({required this.model});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Image.asset(
        'assets/images/${model.imageName}.png',
        width: MediaQuery.sizeOf(context).width,
        fit: BoxFit.fill,
        height: MediaQuery.sizeOf(context).height * 0.25,
      ),
    );
  }
}
