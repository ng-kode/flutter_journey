import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Repository {  
  List<Source> sources = <Source>[
    newsDbProvider,
    NewsApiProvider(),    
  ];

  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];

  Future<List<int>> fetchTopIds() {
    Future<List<int>> ids;

    for (var source in sources) {
      ids = source.fetchTopIds();

      if (ids != null) {
        break;
      }
    }

    return ids;
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    Source exactSource;

    for (var source in sources) {
      exactSource = source;
      item = await exactSource.fetchItem(id);
      if (item != null) {
        break;
      }
    }

    for (var cache in caches) {
      if ((cache as Source) != exactSource) {
        cache.addItem(item);
      }
    }

    return item;
  }

  Future clearCache() async {
    for (var cache in caches) {
      await cache.clear();
    }
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
  
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
  Future<int> clear();
}