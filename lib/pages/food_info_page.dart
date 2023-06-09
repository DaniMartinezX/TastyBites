import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasty_bites/generics/iterable_extension.dart';
import 'package:tasty_bites/services/api/model/api_model.dart';
import 'package:tasty_bites/services/api/service/api_service.dart';
import 'package:tasty_bites/services/auth/auth_service.dart';
import 'package:tasty_bites/utilities/responsive.dart';
import 'package:tasty_bites/widgets/figures/circle.dart';
import 'package:tasty_bites/services/cloud/cloud_favorite.dart';
import 'package:tasty_bites/services/cloud/firebase_cloud_storage.dart';

class FoodInfoPage extends StatefulWidget {
  static const routeName = '/food-info';
  const FoodInfoPage({super.key});

  @override
  State<FoodInfoPage> createState() => _FoodInfoPageState();
}

class _FoodInfoPageState extends State<FoodInfoPage> {
  bool isFavorite = false;
  CloudFavorite? _favorite;
  List<Meals>? _mealById;
  late String? idMeal = '';
  bool _isLoading = true;
  String get userId => AuthService.firebase().currentUser!.id;
  late final FirebaseCloudStorage _favoritesService;

  @override
  void initState() {
    _favoritesService = FirebaseCloudStorage();
    super.initState();
    _favorite = null;
    _initializeData();
  }

  Future<void> _initializeData() async {
    if (idMeal!.isNotEmpty) {
      await _getDataFilteredById(id: idMeal!);
      await _checkFavorite();
    }
  }

  Future<void> _checkFavorite() async {
    final favorites = await _favoritesService.getFavorites(ownerUserId: userId);
    final isAlreadyFavorite = favorites.any(
      (favorite) =>
          favorite.idMeal == _mealById![0].idMeal &&
          favorite.ownerUserId == userId,
    );

    if (isAlreadyFavorite) {
      setState(() {
        _favorite = favorites.firstWhereOrNull(
          (favorite) =>
              favorite.idMeal == _mealById![0].idMeal &&
              favorite.ownerUserId == userId,
        );
      });
    } else {
      setState(() {
        _favorite = null;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as String?;
    idMeal = args ?? '';

    if (idMeal!.isNotEmpty && idMeal != null) {
      _initializeData();
    }
  }

  Future<void> _getDataFilteredById({required String id}) async {
    ApiService apiService = ApiService();
    List<Meals>? meal = await apiService.getMealById(id: id);
    setState(() {
      _mealById = meal;
      _isLoading = false;
    });
  }

  CloudFavorite parseToCloudFavorite(Meals meal) {
    return CloudFavorite(
      documentId: '',
      ownerUserId: '',
      idMeal: meal.idMeal.toString(),
      strMeal: meal.strMeal.toString(),
      strCategory: meal.strCategory.toString(),
      strArea: meal.strArea.toString(),
      strInstructions: meal.strInstructions.toString(),
      strMealThumb: meal.strMealThumb.toString(),
    );
  }

  Future<CloudFavorite> createOrGetExistingFavorites(
    BuildContext context,
    String idMeal,
    String nameMeal,
    String nameCategory,
    String nameArea,
    String instructions,
    String image,
  ) async {
    final widgetFavorite =
        ModalRoute.of(context)?.settings.arguments as CloudFavorite?;

    if (widgetFavorite != null) {
      _favorite = widgetFavorite;
      return widgetFavorite;
    }

    final currentUser = AuthService.firebase().currentUser!;
    final userId = currentUser.id;
    final newFavorite = await _favoritesService.createNewFavorite(
      ownerUserId: userId,
      idMeal: idMeal,
      nameMeal: nameMeal,
      nameCategory: nameCategory,
      nameArea: nameArea,
      instructions: instructions,
      image: image,
    );
    _favorite = newFavorite;
    return newFavorite;
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: responsive.height,
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: size.width * 0.8,
                  left: -(size.width * 0.82) * 1.2,
                  child: Circle(
                    size: size.width * 3,
                    colors: const [
                      Colors.deepPurpleAccent,
                      Color.fromARGB(255, 234, 79, 32),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SafeArea(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Stack(
                            children: [
                              Image.network(
                                _mealById?[0].strMealThumb.toString() ??
                                    'https://img.freepik.com/vector-premium/barra-progreso-estilo-dibujo-doodle-cargando-imagen-icono-ilustracion-vector-dibujado-mano_356415-1238.jpg',
                                fit: BoxFit.fitHeight,
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) {
                                    return child;
                                  }
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              ),
                              Positioned(
                                top: 15,
                                right: 15,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(226, 255, 255, 255),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    onPressed: () async {
                                      setState(() {
                                        isFavorite = !isFavorite;
                                      });

                                      if (isFavorite) {
                                        if (_favorite == null) {
                                          final newFavorite =
                                              await _favoritesService
                                                  .createNewFavorite(
                                            ownerUserId: userId,
                                            idMeal:
                                                _mealById![0].idMeal.toString(),
                                            nameMeal: _mealById![0]
                                                .strMeal
                                                .toString(),
                                            nameCategory: _mealById![0]
                                                .strCategory
                                                .toString(),
                                            nameArea: _mealById![0]
                                                .strArea
                                                .toString(),
                                            instructions: _mealById![0]
                                                .strInstructions
                                                .toString(),
                                            image: _mealById![0]
                                                .strMealThumb
                                                .toString(),
                                          );
                                          setState(() {
                                            _favorite = newFavorite;
                                          });
                                        }
                                      } else {
                                        if (_favorite != null) {
                                          await _favoritesService
                                              .deleteFavorite(
                                                  documentId:
                                                      _favorite!.documentId);
                                          setState(() {
                                            _favorite = null;
                                          });
                                        }
                                      }
                                    },
                                    icon: Icon(
                                      _favorite != null
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                              if (_isLoading)
                                const Center(
                                  child: CircularProgressIndicator(),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Text(
                          _mealById?[0].strMeal.toString() ?? '',
                          maxLines: 1,
                          textAlign: TextAlign
                              .center, // Reemplaza 'itemName' con el nombre real del item
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'Roboto'),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _mealById?[0].strCategory.toString() ?? '',
                          textAlign: TextAlign
                              .center, // Reemplaza 'itemName' con el nombre real del item
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Roboto'),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            constraints: const BoxConstraints(
                              maxHeight: 280,
                              maxWidth: double
                                  .infinity, // Establece una altura máxima para el contenedor
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                    maxWidth: double.infinity),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Text(
                                    _mealById?[0].strInstructions.toString() ??
                                        '',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  left: 15,
                  top: 20,
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
      ),
    );
  }
}
