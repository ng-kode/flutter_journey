import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _repo = Repository();
  var cacheItems = {};

  // stream controllers
  final _topIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map>();
  final _itemsFetcher = PublishSubject<int>();

  // Getters to streams
  Observable<List<int>> get topIds => _topIds.stream;
  Observable<Map> get items => _itemsOutput.stream;

  // Getters to Sinks
  Function(int) get fetchItem => _itemsFetcher.sink.add;  

  StoriesBloc() {
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }
  
  fetchTopIds() async {
    final ids = await _repo.fetchTopIds();
    _topIds.sink.add(ids);
  }

  Future clearCache() {
    return _repo.clearCache();
  }

  _itemsTransformer() {
    return StreamTransformer<int, Map>.fromHandlers(
      handleData: (data, sink) async {
        ItemModel item = await _repo.fetchItem(data);
        cacheItems[data] = item;
        sink.add(cacheItems);
      }
    );
  }

  dispose() {
    _topIds.close();
    _itemsFetcher.close();
    _itemsOutput.close();
  }
}