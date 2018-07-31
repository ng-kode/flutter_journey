import 'dart:async';
import 'package:html_unescape/html_unescape.dart';
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../widget/loading_container.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        final item = snapshot.data;

        final children = <Widget>[
          ListTile(
            title: buildText(item),
            subtitle: item.by == "" ? Text("Deleted") : Text(item.by),
            contentPadding: EdgeInsets.only(
              right: 16.0,
              left: (depth + 1) * 16.0,
            ),
          ),
          Divider(),
        ];

        item.kids.forEach((kidId) {
          children.add(Comment(
            itemId: kidId, 
            itemMap: itemMap,
            depth: depth + 1,
          ));
        });

        return Column(
          children: children,
        );
      },
    );
  }

  Widget buildText(ItemModel item) {
    var unescape = new HtmlUnescape();
    var text = unescape.convert(item.text)
      .replaceAll("<p>", "\n\n")
      .replaceAll("<pre>", "")
      .replaceAll("</pre>", "")
      .replaceAll("<code>", "")
      .replaceAll("</code>", "")
      .replaceAll("<i>", "")
      .replaceAll("</i>", "");
    return Text(text);
  }
}