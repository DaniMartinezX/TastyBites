import 'package:flutter/material.dart';
import 'package:tasty_bites/services/api/model/api_model.dart';
import 'package:tasty_bites/services/api/model/categories_model.dart';
import 'package:tasty_bites/services/api/model/filter_cat_model.dart';
import 'package:tasty_bites/services/api/service/api_service.dart';

class SearchFood extends StatefulWidget {
  const SearchFood({super.key});

  @override
  State<SearchFood> createState() => _SearchFoodState();
}

class _SearchFoodState extends State<SearchFood> {
  late List<Meals>? _mealByName = [];
  late List<Meals>? _mealById = [];
  late List<Categories>? _categories = [];
  late List<FilterCategory>? _mealsByCategory = [];
  final String _searchName = "apple";
  final String _idMeal = "52775";
  final String _category = "Seafood";

  @override
  void initState() {
    super.initState();
    _getAllCategories();
    _getDataFilteredByName(name: _searchName);
    _getDataFilteredById(id: _idMeal);
    _getDataFilteredByCategory(category: _category);
  }

  void _getAllCategories() async {
    _categories = (await ApiService().getAllCategories())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(
          () {},
        ));
  }

  void _getDataFilteredByName({required String name}) async {
    _mealByName = (await ApiService().getMealByName(name: name))!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(
          () {},
        ));
  }

  void _getDataFilteredById({required String id}) async {
    _mealById = (await ApiService().getMealById(id: id))!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(
          () {},
        ));
  }

  void _getDataFilteredByCategory({required String category}) async {
    _mealsByCategory =
        (await ApiService().getMealByCategory(category: category))!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(
          () {},
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _categories == null || _categories!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _categories!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      //_randomMeal![index].strMealThumb.toString()
                      Image.network(
                        _categories![index].strCategoryThumb.toString(),
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
