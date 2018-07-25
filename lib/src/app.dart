// import helper library
import 'package:flutter/material.dart';

// create a class which is our widget
// it extends 'StatelessWidget' base class
class App extends StatelessWidget {
  // Must define a 'build' method
  // that returns the widgets which will be shown
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Let's see some images !"),        
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('hi there');
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

