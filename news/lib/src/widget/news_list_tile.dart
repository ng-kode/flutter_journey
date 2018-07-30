import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import '../models/item_model.dart';
import '../bloc/stories_provider.dart';
import 'loading_container.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({this.itemId});

  Widget build(BuildContext context) {
    final storiesBloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: storiesBloc.items,
      builder: (context, AsyncSnapshot<Map> snapshot) {        
        if (!snapshot.hasData || snapshot.data[itemId] == null) {
          return LoadingContainer();
        }

        return buildTile(snapshot.data[itemId]);
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