import 'package:flutter/cupertino.dart';
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

  TextEditingController _searchController = TextEditingController();
  String _searchKeyword = '';

  @override
  void initState() {
    super.initState();
    _getAllCategories();
    _getDataFilteredByName(name: _searchName);
    _getDataFilteredById(id: _idMeal);
    _getDataFilteredByCategory(category: _category);
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
                                      onTap: () {
                                        print("Se ha pulsado en la categoría");
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
                            itemCount: _categories!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    print("Se ha pulsado en la comida");
                                  },
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 20.0,
                                      ),

                                      //_randomMeal![index].strMealThumb.toString()
                                      Image.network(
                                        _categories![index]
                                            .strCategoryThumb
                                            .toString(),
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
                                          _categories![index]
                                              .strCategory
                                              .toString(),
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
