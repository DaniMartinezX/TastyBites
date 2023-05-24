import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:tasty_bites/constants/api.dart';
import 'package:tasty_bites/services/api/model/api_model.dart';

class ApiService {
  Future<List<Meals>?> getRandomMeal() async {
    //Funciona
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

  Future<List<Meals>?> getMealByName({required String name}) async {
    //Funciona
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
}
