import 'package:flutter/material.dart';
import '../bloc/stories_provider.dart';

class Refresh extends StatelessWidget {
  final Widget child;

  Refresh({this.child});

  Widget build(BuildContext context) {
    final StoriesBloc storiesBloc = StoriesProvider.of(context);


    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await storiesBloc.clearCache();
        await storiesBloc.fetchTopIds();
      },
    );
  }
}