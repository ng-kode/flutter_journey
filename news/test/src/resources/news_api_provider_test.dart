import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'dart:convert';
import 'package:news/src/resources/news_api_provider.dart';
import 'package:news/src/models/item_model.dart';

void main() {
  test("fetchTopIds returns List of ids", () async {
    // setup test case
    final NewsApiProvider newsApi = NewsApiProvider();

    newsApi.client = MockClient((Request req) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    final ids = await newsApi.fetchTopIds();
    
    // expectation
    expect(ids, [1, 2, 3, 4]);
  });

  test("fetchItems returns an ItemModel", () async {
    // setup test case
    final NewsApiProvider newsApi = NewsApiProvider();

    newsApi.client = MockClient((Request req) async {
      final jsonMap = {"id": 123};
      return Response(json.encode(jsonMap), 200);
    });

    final item = await newsApi.fetchItems(999);

    // expectation
    expect(item.id, 123);
  });
}