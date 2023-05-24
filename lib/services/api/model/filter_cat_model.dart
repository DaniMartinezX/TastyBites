class FilterCategory {
  String? idMeal;
  String? strMeal;
  String? strMealThumb;

  FilterCategory({
    this.idMeal,
    this.strMeal,
    this.strMealThumb,
  });

  factory FilterCategory.fromJson(Map<String, dynamic> json) {
    return FilterCategory(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strMealThumb: json['strMealThumb'],
    );
  }
}
