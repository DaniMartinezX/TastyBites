class CloudStorageException implements Exception {
  const CloudStorageException();
}

class CouldNotAddMealToFavoritesException extends CloudStorageException {}

class CouldNotGetAllFavoritesException extends CloudStorageException {}

class CouldNotDeleteFavoriteMealException extends CloudStorageException {}
