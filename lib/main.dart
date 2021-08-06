import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view/home_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SpaceX Latest Flights',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: HomeView(),
    );
  }
}
