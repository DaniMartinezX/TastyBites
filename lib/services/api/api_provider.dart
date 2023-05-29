import 'package:tasty_bites/services/api/model/api_model.dart';
import 'package:tasty_bites/services/api/model/categories_model.dart';
import 'package:tasty_bites/services/api/model/filter_cat_model.dart';
import 'package:tasty_bites/services/auth/auth_user.dart';

abstract class ApiProvider {
  Future<void> initialize();

  AuthUser? get currentUser;

  Future<List<Meals>> getFavorites({
    required String email,
    required String password,
  });

  Future<List<Meals>?> getRandomMeal();
  Future<List<Categories>?> getAllCategories();

  Future<List<FilterCategory>?> getMealByName({required String name});

  Future<List<Meals>?> getMealById({required String id});

  Future<List<FilterCategory>?> getMealByCategory({required String category});
}
