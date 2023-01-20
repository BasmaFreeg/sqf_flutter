import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqf_flutter/archive/archive.dart';
import 'package:sqf_flutter/done_Tasks/done_tasks.dart';
import 'package:sqf_flutter/new_tasks/new_tsks.dart';
import 'package:sqflite/sqflite.dart';

class layout extends StatefulWidget {
  @override
  State<layout> createState() => _layoutState();
}

late Database
    database; // late : hyt3maloh create b3deen lma n7tagoh msh dlwa2ti

class _layoutState extends State<layout> {
  int currentIndex = 0;
  List<Widget> Screens = [
    new_tasks(),
    done_tasks(),
    archive(),
  ];
  List<String> Titles = ['New Tasks', 'Done Tasks', 'Archive'];
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

  @override
  void initState() {
    super.initState();
    createDatabase();
  } // bttnfz 2bl el build

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(Titles[currentIndex]),
      ),
      body: Screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isButtomSheet) {
            if(formKey.currentState!.validate())
              {
                Navigator.pop(context);
                isButtomSheet = false;
                setState(() {
                  fabIcon = Icons.edit;
                });
              }

          } else {
            scaffoldKey.currentState?.showBottomSheet(
              (context) => Container(
                color: Colors.grey[100],
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
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: timeController,
                        keyboardType: TextInputType.datetime,
                        onTap: () {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then((value) {
                            timeController.text = value!.format(context).toString();
                            print(value!.format(context));
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
                          // labelText: 'Task Time',
                          prefixIcon: Icon(
                            Icons.watch_later_outlined,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: dateController,
                        keyboardType: TextInputType.datetime,
                        onTap: () {
                          showDatePicker(
                              context: context, 
                              initialDate: DateTime.now(), 
                              firstDate: DateTime.now(),
                              lastDate: DateTime.parse('2022-05-03'))
                              .then((value) {
                            dateController.text = DateFormat.yMMMd().format(value!);
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
                          // labelText: 'Date Time',
                          prefixIcon: Icon(
                            Icons.calendar_today,
                          ),
                        ),
                      ),
                    
                    ],
                  ),
                ),
              ),
            );
            isButtomSheet = true;
            setState(() {
              fabIcon = Icons.add;
            });
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
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

void createDatabase() async {
  database = await openDatabase('todoAppp.db', // path = database name
      version:
          1, // b3mel update lma a8ir haga fe el structure bta3 el database a add table mathlen
      onCreate: (database, version)
          // object men el db elly 7slha create ==> database
          // elly foo2 ==> version
          async {
    await database.execute(
        'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)');
    try {
      print('created ');
    } catch (error) {
      print('error ${error.toString()}');
    }
    // .catchError((error){
    //   print('error when creating table ${error.toString()}');
    // });
    // print({result});
  }, onOpen: (database) {
    print('database opened');
  });
}

void insertToDatabase() async {
  await database.transaction((txn) {
    return txn
        .rawInsert(
            'INSERT INTO tasks(title, date, time, status) VALUES("jgjgj", "bbb", "hh", "jhj")')
        .then((value) {
      print('$value  inserted succesfully');
    }).catchError((error) {
      print('error when inserting ${error.toString()}');
    });
  });
}
