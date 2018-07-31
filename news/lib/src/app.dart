import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'screens/news_detail.dart';
import 'bloc/stories_provider.dart';
import 'bloc/comments_provider.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'News',
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route<dynamic> routes(RouteSettings settings) {
    if (settings.name == "/") {
      return MaterialPageRoute(
        builder: (context) {
          return NewsList();
        }
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          final itemId = int.parse(settings.name.replaceFirst("/", ""));

          final commentsBloc = CommentsProvider.of(context);
          commentsBloc.fetchItemWithComments(itemId);

          return NewsDetail(itemId: itemId);
        }
      );
    }
  }
}