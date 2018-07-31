import 'package:flutter/material.dart';
import 'comments_bloc.dart';
export 'comments_bloc.dart';

class CommentsProvider extends InheritedWidget {
  final commentsBloc = CommentsBloc();

  CommentsProvider({Key key, Widget child})
    : super(key: key, child: child);

  static CommentsBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(CommentsProvider) 
      as CommentsProvider).commentsBloc;
  }

  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}