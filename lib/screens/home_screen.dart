import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:news_c17_online/core/api_manager.dart';
import 'package:news_c17_online/core/theming/cubit/cubit.dart';
import 'package:news_c17_online/models/categories_model.dart';
import 'package:news_c17_online/models/sources_reponse.dart';
import 'package:news_c17_online/screens/bloc/cubit.dart';
import 'package:news_c17_online/screens/bloc/states.dart';
import 'package:news_c17_online/screens/news_screen.dart';
import 'package:news_c17_online/screens/views/categories_view.dart';
import 'package:news_c17_online/screens/views/drawer_view.dart';
import 'package:news_c17_online/screens/views/sources_view.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/";

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        drawer: DrawerView(onClick: onDrawerClicked),
        appBar: AppBar(
          backgroundColor: ThemingCubit.get(context).colors.primary,
          centerTitle: true,
          title: Text(
            selectedCategory == null ? "Home" : selectedCategory!.label,
          ),
        ),

        body: selectedCategory == null
            ? CategoriesView(onClick: onClick)
            : SourcesView(categoryId: selectedCategory!.id),
      ),
    );
  }

  CategoryModel? selectedCategory;

  void onDrawerClicked() {
    selectedCategory = null;
    Navigator.pop(context);
    setState(() {});
  }

  void onClick(CategoryModel category) {
    selectedCategory = category;
    setState(() {});
  }
}
