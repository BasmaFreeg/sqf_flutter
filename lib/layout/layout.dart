import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqf_flutter/archive/archive.dart';
import 'package:sqf_flutter/done_Tasks/done_tasks.dart';
import 'package:sqf_flutter/new_tasks/new_tsks.dart';
import 'package:sqf_flutter/shared/Cubit/cubit.dart';
import 'package:sqf_flutter/shared/Cubit/states.dart';
import 'package:sqflite/sqflite.dart';

import '../shared/components/constants.dart';

late Database
    database; // late : hyt3maloh create b3deen lma n7tagoh msh dlwa2ti

class layout extends StatelessWidget {
// steps for sqflite:
  //1-create database
  //2-create tables
  //3-open database
  //4-insert into database
  //5-get from database
  //6-update database
  //7-delete database
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool isButtomSheet = false;
  IconData fabIcon = Icons.edit;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   createDatabase();
  // } // bttnfz 2bl el build

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TodoCubit()..createDatabase(),
      //TodoCubit()..createDatabase() : de m3naha eny khadt object mn el TodoCubit
      // 3n tareek eny b3ml ..
      child: BlocConsumer<TodoCubit, TodoStates>(
        listener: (BuildContext context, TodoStates State) {},
        builder: (BuildContext context, TodoStates State) {
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(TodoCubit.get(context)
                  .Titles[TodoCubit.get(context).currentIndex]),
            ),
            body: ConditionalBuilder(
              condition: true,
              builder: (context) => TodoCubit.get(context)
                  .Screens[TodoCubit.get(context).currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (isButtomSheet) {
                  if (formKey.currentState!.validate()) {
                    // insertToDatabase(titleController.text, dateController.text,
                    //         timeController.text)
                    //     .then((value) {
                    //   Navigator.pop(context); // by3ml back beeha
                    //   isButtomSheet = false;
                    // setState(() {
                    //   fabIcon = Icons.edit;
                    // });
                    // });
                  }
                } else {
                  scaffoldKey.currentState
                      ?.showBottomSheet(
                        (context) => Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: titleController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'title must not be empty';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Title Task',
                                    prefixIcon: Icon(
                                      Icons.title,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                TextFormField(
                                  controller: timeController,
                                  keyboardType: TextInputType.datetime,
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text =
                                          value!.format(context).toString();
                                      print(value.format(context));
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'time must not be empty';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Task Time',
                                    prefixIcon: Icon(
                                      Icons.watch_later_outlined,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                TextFormField(
                                  controller: dateController,
                                  keyboardType: TextInputType.datetime,
                                  onTap: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate:
                                                DateTime.parse('2022-05-03'))
                                        .then((value) {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Date must not be empty';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Date Time',
                                    prefixIcon: Icon(
                                      Icons.calendar_today,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        elevation: 20.0,
                      )
                      .closed
                      .then(
                          (value) // closed de 3shan lma anzel el bottom sheet be 2eedy el icon tet8yer
                          {
                    // msh m7tageen navigator.pop hena 3shan howa hy2fel el bottom sheet w y8yer el icon bs msh hy3mel back
                    isButtomSheet = false;
                    // setState(() {
                    //   fabIcon = Icons.edit;
                    // });
                  });
                  isButtomSheet = true;
                  // setState(() {
                  //   fabIcon = Icons.add;
                  // });
                }
              },
              child: Icon(fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  label: 'New Tasks',
                  icon: Icon(Icons.menu),
                ),
                BottomNavigationBarItem(
                  label: 'Done Tasks',
                  icon: Icon(Icons.check_circle_outline),
                ),
                BottomNavigationBarItem(
                  label: 'Archive',
                  icon: Icon(Icons.archive),
                )
              ],
              currentIndex: TodoCubit.get(context).currentIndex,
              onTap: (index) {
                TodoCubit.get(context).ChangeIndex(index);
                // setState(() {
                //   currentIndex = index;
                // });
              },
            ),
          );
        },
      ),
    );
  }
}
