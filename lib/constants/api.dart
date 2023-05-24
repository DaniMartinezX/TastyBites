class ApiConstants {
  static String baseUrl = 'https://www.themealdb.com/api/json/v1/1';
  static String randomEndpoint = '/random.php'; //Funciona (api_model)
  static String categoriesEndpoint = '/categories.php';

  static String getFilteredByCategoryEndpoint(String category) {
    return '$baseUrl/filter.php?c=$category';
  }

  static String getFilteredByIdEndpoint(String id) {
    return '$baseUrl/lookup.php?i=$id';
  }

  static String getFilteredByNameEndpoint(String name) {
    return '$baseUrl/search.php?s=$name';
  }
}
