// import helper library
import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import 'models/image_model.dart';
import 'widgets/image_list.dart';

class App extends StatefulWidget {
  createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int counter = 0;
  List<ImageModel> images = [];

  void fetchImage() async {
    counter++;
    var response = await get("https://jsonplaceholder.typicode.com/photos/${counter}");
    var imageModel = new ImageModel.fromJson(json.decode(response.body));
    setState(() {
      images.add(imageModel);
    });    
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Let's see some images !"),        
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: fetchImage,
          child: Icon(Icons.add),
        ),
        body: ImageList(images),
      ),
    );
  }
}

