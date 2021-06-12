import 'package:flutter/material.dart';
import 'package:projecto_mybd/util/dbhelper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DbHelper helper = DbHelper();
    helper.testDB();

    return Container();
  }
}
