import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'dart:async';
import '../models/item_model.dart';
import 'repository.dart';

final _domain = "https://hacker-news.firebaseio.com/v0";

class NewsApiProvider implements Source {
  // use client instead of the get method for testing purpose
  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    final response = await client.get("$_domain/topstories.json");
    final ids = json.decode(response.body);

    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get("$_domain/item/$id.json");
    final parsedJson = json.decode(response.body);
    final item = ItemModel.fromJson(parsedJson);

    return item;
  }
}