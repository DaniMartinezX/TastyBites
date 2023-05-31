import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasty_bites/services/cloud/cloud_storage_constants.dart';
import 'package:flutter/foundation.dart';

@immutable
class CloudFavorite {
  final String documentId;
  final String ownerUserId;
  final String idMeal;
  final String strMeal;
  final String strCategory;
  final String strArea;
  final String strInstructions;
  final String strMealThumb;

  const CloudFavorite({
    required this.documentId,
    required this.ownerUserId,
    required this.idMeal,
    required this.strMeal,
    required this.strCategory,
    required this.strArea,
    required this.strInstructions,
    required this.strMealThumb,
  });

  CloudFavorite.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserIdFieldName],
        idMeal = snapshot.data()[idMealFieldName] as String,
        strMeal = snapshot.data()[nameMealFieldName] as String,
        strCategory = snapshot.data()[nameCategoryFieldName] as String,
        strArea = snapshot.data()[nameAreaFieldName] as String,
        strInstructions = snapshot.data()[instructionsFieldName] as String,
        strMealThumb = snapshot.data()[imageFieldName] as String;
}
