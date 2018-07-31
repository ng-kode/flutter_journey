import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class CommentsBloc {
  final _repo = Repository();

  // stream controllers
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }

  // Getters to streams
  Observable<Map<int, Future<ItemModel>>> get itemWithComments => _commentsOutput.stream;


  // Getters to sinks
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;


  // Contructor to pipe commentsFetcher to commentsOutput
  CommentsBloc() {
    _commentsFetcher.transform(_commentsTransformer()).pipe(_commentsOutput);
  }
  _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
      (cache, int itemId, int counter) {
        cache[itemId] = _repo.fetchItem(itemId);
        cache[itemId].then((ItemModel item) {
          item.kids.forEach((kidId) => fetchItemWithComments(kidId));
        });
        return cache;
      },
      <int, Future<ItemModel>>{}
    );
  }


}