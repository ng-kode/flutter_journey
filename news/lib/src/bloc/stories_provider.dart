import 'package:flutter/material.dart';
import 'stories_bloc.dart';
export 'stories_bloc.dart';

class StoriesProvider extends InheritedWidget {
  final storiesBloc = StoriesBloc();

  StoriesProvider({Key key, Widget child})
    : super(key: key, child: child);

  static StoriesBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(StoriesProvider) 
      as StoriesProvider).storiesBloc;
  }
  
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}