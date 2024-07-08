abstract class FavoriteDao {
  void addFavorite(String productSlug, int favoriteProductId);

  void removeFavorite(String productSlug);

  void removeAllFavorite();

  List<int>? getAllFavoriteId();
}
