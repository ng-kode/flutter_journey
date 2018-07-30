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

            return buildTile(itemSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildTile(ItemModel item) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(item.title),
          subtitle: Text('${item.score} votes'),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.comment),
              Text('${item.descendants}')
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}