import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:tasty_bites/constants/api.dart';
import 'package:tasty_bites/services/api/model/api_model.dart';
import 'package:tasty_bites/services/api/model/categories_model.dart';
import 'package:tasty_bites/services/api/model/filter_cat_model.dart';

class ApiService {
  Future<List<Meals>?> getRandomMeal() async {
    //Funciona
    try {
      //1º step: hit the GET HTTP request.
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.randomEndpoint);
      var response = await http.get(url);
      var jsonResponse = json.decode(response.body);

      //2º step: check wheter the API call was successful or not.
      if (response.statusCode == 200) {
        var apiModel = ApiModel.fromJson(jsonResponse);
        List<Meals>? meals = apiModel.meals;
        return meals;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Categories>?> getAllCategories() async {
    //Funciona
    try {
      //1º step: hit the GET HTTP request.
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.categoriesEndpoint);
      var response = await http.get(url);
      var jsonResponse = json.decode(response.body);

      //2º step: check wheter the API call was successful or not.
      if (response.statusCode == 200) {
        var apiModel = CategoriesModel.fromJson(jsonResponse);
        List<Categories>? categories = apiModel.categories;
        return categories;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Meals>?> getMealByName({required String name}) async {
    //Funciona
    try {
      //1º step: hit the GET HTTP request.
      var url = Uri.parse("${ApiConstants.baseUrl}/search.php?s=$name");
      var response = await http.get(url);
      var jsonResponse = json.decode(response.body);

      //2º step: check wheter the API call was successful or not.
      if (response.statusCode == 200) {
        var apiModel = ApiModel.fromJson(jsonResponse);
        List<Meals>? meals = apiModel.meals;
        return meals;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Meals>?> getMealById({required String id}) async {
    //Funciona
    try {
      //1º step: hit the GET HTTP request.
      var url = Uri.parse("${ApiConstants.baseUrl}/lookup.php?i=$id");
      var response = await http.get(url);
      var jsonResponse = json.decode(response.body);

      //2º step: check wheter the API call was successful or not.
      if (response.statusCode == 200) {
        var apiModel = ApiModel.fromJson(jsonResponse);
        List<Meals>? meals = apiModel.meals;
        return meals;
      }
    } catch (e) {
      log('Error during API call: $e');
      throw Exception('Failed to get meal by ID');
    }
    return null;
  }

  Future<List<FilterCategory>?> getMealByCategory(
      {required String category}) async {
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}/filter.php?c=$category");
      var response = await http.get(url);
      var jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        List<FilterCategory>? meals = (jsonResponse['meals'] as List<dynamic>)
            .map((json) => FilterCategory.fromJson(json))
            .toList();
        return meals;
      }
    } catch (e) {
      throw Exception('Failed to get meal by category');
    }
    return null;
  }
}
