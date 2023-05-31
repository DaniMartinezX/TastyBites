import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasty_bites/services/cloud/cloud_favorite.dart';
import 'package:tasty_bites/services/cloud/cloud_storage_constants.dart';
import 'package:tasty_bites/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  final favorites = FirebaseFirestore.instance.collection('favorites');

  Future<void> deleteFavorite({required String documentId}) async {
    try {
      await favorites.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteFavoriteMealException();
    }
  }

  Stream<Iterable<CloudFavorite>> allFavorites({required String ownerUserId}) =>
      favorites.snapshots().map((event) => event.docs
          .map((doc) => CloudFavorite.fromSnapshot(doc))
          .where((favorite) => favorite.ownerUserId == ownerUserId));

  Future<Iterable<CloudFavorite>> getFavorites(
      {required String ownerUserId}) async {
    try {
      return await favorites
          .where(
            ownerUserIdFieldName,
            isEqualTo: ownerUserId,
          )
          .get()
          .then(
            (value) => value.docs.map(
              (doc) => CloudFavorite.fromSnapshot(doc),
            ),
          );
    } catch (e) {
      throw CouldNotGetAllFavoritesException();
    }
  }

  Future<CloudFavorite> createNewFavorite({
    required String ownerUserId,
    required String idMeal,
    required String nameMeal,
    required String nameCategory,
    required String nameArea,
    required String instructions,
    required String image,
  }) async {
    final document = await favorites.add({
      ownerUserIdFieldName: ownerUserId,
      idMealFieldName: idMeal,
      nameMealFieldName: nameMeal,
      nameCategoryFieldName: nameCategory,
      nameAreaFieldName: nameArea,
      instructionsFieldName: instructions,
      imageFieldName: image,
    });
    final fetchedFavorite = await document.get();
    return CloudFavorite(
      documentId: fetchedFavorite.id,
      ownerUserId: ownerUserId,
      idMeal: fetchedFavorite.data()![idMealFieldName],
      strMeal: fetchedFavorite.data()![nameMealFieldName],
      strCategory: fetchedFavorite.data()![nameCategoryFieldName],
      strArea: fetchedFavorite.data()![nameAreaFieldName],
      strInstructions: fetchedFavorite.data()![instructionsFieldName],
      strMealThumb: fetchedFavorite.data()![imageFieldName],
    );
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}
