import 'package:flutter/material.dart';
import '../bloc/stories_provider.dart';
import '../widget/news_list_tile.dart';
import '../widget/refresh.dart';

class NewsList extends StatelessWidget {  
  Widget build(BuildContext context) {
    final storiesBloc = StoriesProvider.of(context);

    storiesBloc.fetchTopIds();

    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(storiesBloc),
    );
  }

  Widget buildList(StoriesBloc storiesBloc) {
    return StreamBuilder(
      stream: storiesBloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        // ListView will only build widgets when they are visible
        return Refresh(
          child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, int index) {
              storiesBloc.fetchItem(snapshot.data[index]);

              return NewsListTile(itemId: snapshot.data[index]);
            },
          ),
        );
      },
    );
  }
}