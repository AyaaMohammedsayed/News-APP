import 'package:flutter/material.dart';
import 'package:news/core/Theme/app_theme.dart';
import 'package:news/core/helper/helper.dart';
import 'package:news/core/provider/settings.dart';
import 'package:news/features/category/data/category_model.dart';
import 'package:news/features/category/view/widgets/category_view.dart';
import 'package:news/features/home/view/widgets/home_drawer.dart';
import 'package:news/features/news/view/widgets/new_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryModel? categoryModel;
  List<CategoryModel> searchedCategories = [];
  bool isSearching = false;

  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
late SettingServicesProvider provider;
  @override
  Widget build(BuildContext context) {
     provider = Provider.of<SettingServicesProvider>(context);
    return Scaffold(
      drawer: HomeDrawer(resetModel: resetSelectedCategoryModel),
      appBar: AppBar(
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16),
        title: isSearching
            ? TextField(
                controller: searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search Category...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: (query) {
                  setState(() {
                    searchedCategories = Helper.searchCategory(query);
                  });
                },
              )
            : Text(categoryModel == null ? 'Home' : categoryModel!.name),
        actions: [
          if (isSearching)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                setState(() {
                  isSearching = false;
                  searchController.clear();
                  searchedCategories = [];
                });
              },
            )
          else
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() {
                  isSearching = true;
                  searchedCategories = Helper.searchCategory('');
                });
              },
            ),
        ],
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    if (isSearching) {
      if (searchedCategories.isEmpty) {
        return const Center(
          child: Text(
            'No Categories Found',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        );
      }
      return ListView.builder(
        
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: searchedCategories.length,
        itemBuilder: (context, index) {
          final item = searchedCategories[index];
          return ListTile(
            
            leading:  Icon(Icons.category,color:provider.isDark ?AppTheme.white: AppTheme.black),
            title: Text(item.name,style: TextStyle(color:provider.isDark ?AppTheme.white: AppTheme.black),),
            onTap: () {
              onChangeCategory(item);
              setState(() {
                isSearching = false;
                searchController.clear();
                searchedCategories = [];
              });
            },
          );
        },
      );
    }

    if (categoryModel == null) {
      return CategoryView(onChangeCategory: onChangeCategory);
    }

    return NewView(categoryId: categoryModel!.id);
  }

  void onChangeCategory(CategoryModel model) {
    setState(() {
      categoryModel = model;
    });
  }

  void resetSelectedCategoryModel() {
  
    if (categoryModel == null) return;
    setState(() {
      categoryModel = null;
    });
  }
}