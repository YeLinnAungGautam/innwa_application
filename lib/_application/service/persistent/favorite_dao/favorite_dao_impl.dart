import 'package:hive/hive.dart';

import '../../../constant/hive_constant.dart';
import 'favorite_dao.dart';

class FavoriteDaoImpl extends FavoriteDao {
  FavoriteDaoImpl._();
  static final FavoriteDaoImpl _singleton = FavoriteDaoImpl._();
  factory FavoriteDaoImpl() => _singleton;

  @override
  void addFavorite(String productSlug, int favoriteProductId) =>
      _favoriteBox().put(productSlug, favoriteProductId);

  @override
  void removeFavorite(String productSlug) => _favoriteBox().delete(productSlug);

  @override
  List<int>? getAllFavoriteId() => _favoriteBox().values.toList();

  Box<int> _favoriteBox() => Hive.box<int>(kFavoriteBox);

  @override
  void removeAllFavorite() => _favoriteBox().clear();
}
