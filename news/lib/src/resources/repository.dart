import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Repository {
  final apiProvider = NewsApiProvider();
  final dbProvider = NewsDbProvider();

   Future<List<int>> fetchTopIds() {
    return apiProvider.fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    var item = await dbProvider.fetchItem(id);
    
    // if cached
    if (item != null) {
      return item;
    }

    // if not cached
    item = await apiProvider.fetchItems(id);

    dbProvider.addItem(item);
    return item;
  }
}