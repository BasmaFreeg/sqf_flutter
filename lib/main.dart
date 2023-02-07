import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqf_flutter/layout/layout.dart';
import 'package:sqf_flutter/new_tasks/new_tsks.dart';
import 'package:provider/provider.dart';
import 'package:sqf_flutter/shared/Bloc_Observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {},
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: layout(),
      ),
    );
  }
}
