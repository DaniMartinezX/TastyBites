import 'package:flutter/material.dart';
import 'package:tasty_bites/services/cloud/cloud_favorite.dart';
import 'package:tasty_bites/utilities/dialogs/delete_dialog.dart';

typedef FavoriteCallback = void Function(CloudFavorite favorite);

class FavoritesListPage extends StatelessWidget {
  final Iterable<CloudFavorite> favorites;
  final FavoriteCallback onDeleteFavorite;
  final FavoriteCallback onTap;
  const FavoritesListPage({
    Key? key,
    required this.favorites,
    required this.onDeleteFavorite,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final favorite = favorites.elementAt(index);
              return ListTile(
                onTap: () {
                  onTap(favorite);
                },
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.network(
                    favorite.strMealThumb,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                title: Text(
                  favorite.strMeal,
                  maxLines: 1,
                  softWrap: true,
                ),
                trailing: IconButton(
                  onPressed: () async {
                    final shouldDelete = await showDeleteDialog(context);
                    if (shouldDelete) {
                      onDeleteFavorite(favorite);
                    }
                  },
                  icon: const Icon(Icons.delete),
                ),
              );
            }),
      ),
      //body: ,
    );
  }
}
