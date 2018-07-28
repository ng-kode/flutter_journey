import 'package:flutter/material.dart';
import 'dart:async';
import '../models/item_model.dart';
import '../bloc/stories_provider.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({this.itemId});

  Widget build(BuildContext context) {
    final storiesBloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: storiesBloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        
        if (!snapshot.hasData) {
          return Text('Stream loading');
        }

        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Text('Still loading item $itemId');
            }

            return Text(itemSnapshot.data.title);
          },
        );
      },
    );
  }
}