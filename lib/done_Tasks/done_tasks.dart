import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class done_tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(
          Icons.add,
        ),
      ),
      body: Center(child: Text('done Tasks')),
    );
  }
}
