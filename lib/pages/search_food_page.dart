import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasty_bites/pages/food_info_page.dart';
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
  List<FilterCategory>? _mealByName;
  List<Meals>? _mealById;
  List<Categories>? _categories;
  List<FilterCategory>? _mealsByCategory;
  final String _searchName = "apple";
  final String _idMeal = "52775";

  TextEditingController _searchController = TextEditingController();
  String _searchKeyword = '';

  @override
  void initState() {
    super.initState();
    _getAllCategories();
    _getDataFilteredByName(name: _searchName);
    _getDataFilteredById(id: _idMeal);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _getAllCategories() async {
    _categories = (await ApiService().getAllCategories())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(
          () {},
        ));
  }

  Future<void> _getDataFilteredByName({required String name}) async {
    List<FilterCategory>? mealsByCategory =
        await ApiService().getMealByName(name: name);

    setState(() {
      _mealsByCategory = mealsByCategory;
    });
  }

  void _getDataFilteredById({required String id}) async {
    _mealById = (await ApiService().getMealById(id: id))!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(
          () {},
        ));
  }

  Future<void> _getDataFilteredByCategory({required String category}) async {
    List<FilterCategory>? mealsByCategory =
        await ApiService().getMealByCategory(category: category);

    setState(() {
      _mealsByCategory = mealsByCategory;
    });
  }

  // Método para manejar la selección de una categoría
  void _onCategorySelected(String category) {
    _getDataFilteredByCategory(category: category).then((_) {
      print('Búsqueda por categoría: $category');

      List<FilterCategory>? filteredList;

      if (_searchKeyword.isNotEmpty) {
        _getDataFilteredByName(name: _searchKeyword).then((_) {
          print('Búsqueda por nombre: $_searchKeyword');

          if (_mealsByCategory != null && _mealByName != null) {
            filteredList = _mealsByCategory!
                .where((category) =>
                    _mealByName!.any((meal) => meal.idMeal == category.idMeal))
                .toList();
          } else {
            filteredList = _mealByName ?? _mealsByCategory;
          }

          setState(() {
            _mealByName = filteredList;
          });
        });
      } else {
        setState(() {
          _mealByName = _mealsByCategory;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String selectedCategory = '';

    return Scaffold(
      body: _categories == null || _categories!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 20.0,
                        ),
                        SafeArea(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: 300.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      labelText: 'Search',
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.fromLTRB(
                                          16.0, 10.0, 16.0, 10.0),
                                    ),
                                    controller: _searchController,
                                    onChanged: (value) {
                                      setState(() {
                                        _searchKeyword = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Filter by category",
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 150.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _categories!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: SizedBox(
                                  width: 160.0,
                                  child: Card(
                                    child: InkWell(
                                      onTap: () async {
                                        selectedCategory = _categories![index]
                                            .strCategory
                                            .toString();
                                        _onCategorySelected(selectedCategory);
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          ClipOval(
                                            child: Image.network(
                                              _categories![index]
                                                  .strCategoryThumb
                                                  .toString(),
                                              fit: BoxFit
                                                  .fitHeight, // Ajusta la imagen a la altura disponible
                                            ),
                                          ),
                                          Container(
                                            decoration: const BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 234, 79, 32),
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(4.0),
                                                bottomRight:
                                                    Radius.circular(4.0),
                                              ),
                                            ),
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              _categories![index]
                                                  .strCategory
                                                  .toString(),
                                              textAlign: TextAlign
                                                  .center, // Reemplaza 'itemName' con el nombre real del item
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _mealByName?.length ?? 1,
                            itemBuilder: (context, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    if (_mealByName != null &&
                                        _mealByName!.isNotEmpty) {
                                      Navigator.pushNamed(
                                        context,
                                        FoodInfoPage.routeName,
                                        arguments: _mealByName![index]
                                            .idMeal
                                            .toString(),
                                      );
                                    }
                                  },
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 20.0,
                                      ),

                                      //_randomMeal![index].strMealThumb.toString()
                                      Image.network(
                                        _mealByName?[index]
                                                .strMealThumb
                                                .toString() ??
                                            'https://img.freepik.com/vector-premium/barra-progreso-estilo-dibujo-doodle-cargando-imagen-icono-ilustracion-vector-dibujado-mano_356415-1238.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 234, 79, 32),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(4.0),
                                            bottomRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          _mealByName?[index]
                                                  .strMeal
                                                  .toString() ??
                                              '',
                                          textAlign: TextAlign
                                              .center, // Reemplaza 'itemName' con el nombre real del item
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              fontFamily: 'Roboto'),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      left: 15,
                      top: 35,
                      child: SafeArea(
                        child: CupertinoButton(
                          color: Colors.black26,
                          padding: const EdgeInsets.all(10),
                          borderRadius: BorderRadius.circular(30),
                          child: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
