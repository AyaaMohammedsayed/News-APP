import 'package:flutter/material.dart';
import 'package:news/features/category/category_item.dart';
import 'package:news/features/category/category_model.dart';


class CategoryView extends StatelessWidget {
  CategoryView({required this.onChangeCategory});
  void Function(CategoryModel model) onChangeCategory;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Good Morning\nHere is Some News For You",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (_, _) => SizedBox(height: 16),
              itemCount: CategoryModel.categoryModels.length,
              itemBuilder: (_, index) => GestureDetector(
                onTap: () {
                  onChangeCategory(CategoryModel.categoryModels[index]);
                },
                child: CategoryItem(model: CategoryModel.categoryModels[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
