import 'package:flutter/material.dart';
import 'package:tasty_bites/pages/favorites_list_page.dart';
import 'package:tasty_bites/pages/food_info_page.dart';
import 'package:tasty_bites/services/auth/auth_service.dart';
import 'package:tasty_bites/services/cloud/cloud_favorite.dart';
import 'package:tasty_bites/services/cloud/firebase_cloud_storage.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late final FirebaseCloudStorage _favoritesService;
  String get userId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    _favoritesService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite),
            SizedBox(width: 5),
            Text("Favorites"),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 234, 79, 32),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: _favoritesService.allFavorites(ownerUserId: userId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              if (snapshot.hasData) {
                final allFavorites = snapshot.data as Iterable<CloudFavorite>;
                return FavoritesListPage(
                  favorites: allFavorites,
                  onDeleteFavorite: (favorite) async {
                    await _favoritesService.deleteFavorite(
                        documentId: favorite.documentId);
                  },
                  onTap: (favorite) {
                    Navigator.of(context).pushNamed(FoodInfoPage.routeName,
                        arguments: favorite.idMeal);
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
//TODO 