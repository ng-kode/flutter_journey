import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _repo = Repository();

  // stream controllers
  final _topIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemsFetcher = PublishSubject<int>();
  dispose() {
    _topIds.close();
    _itemsFetcher.close();
    _itemsOutput.close();
  }

  // Getters to streams
  Observable<List<int>> get topIds => _topIds.stream;
  Observable<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  // Getters to Sinks
  Function(int) get fetchItem => _itemsFetcher.sink.add;  

  // Contructor to pipe itemFetcher to itemOutput
  StoriesBloc() {
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }
  _itemsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
      (cache, int itemId, int counter) {
        cache[itemId] = _repo.fetchItem(itemId);
        return cache;
      },
      <int, Future<ItemModel>>{}
    );
  }

  // Other public methods

  fetchTopIds() async {
    final ids = await _repo.fetchTopIds();
    _topIds.sink.add(ids);
  }

  Future clearCache() {
    return _repo.clearCache();
  }  
}