import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqf_flutter/layout/layout.dart';
import 'package:sqf_flutter/new_tasks/new_tsks.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp() );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,

      home: layout(),
    );

  }
}
