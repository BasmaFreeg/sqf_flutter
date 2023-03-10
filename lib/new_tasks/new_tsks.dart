import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqf_flutter/shared/components/constants.dart';

import '../shared/components/components.dart';


class new_tasks extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder:(context,index)  => buildTskItem(tasks[index]) ,
        separatorBuilder:(context, index) => Container(
          width: double.infinity,
          height: 1.0,
          color: Colors.grey[300],
        ),
        itemCount: tasks.length);
  }
}
