import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqf_flutter/archive/archive.dart';
import 'package:sqf_flutter/done_Tasks/done_tasks.dart';
import 'package:sqf_flutter/new_tasks/new_tsks.dart';
import 'package:sqflite/sqflite.dart';

import '../shared/components/constants.dart';

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
      body: ConditionalBuilder(
        condition: tasks.length>0,
        builder: (context)=> Screens[currentIndex],
        fallback: (context)=>Center(
            child:CircularProgressIndicator() ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isButtomSheet) {
            if (formKey.currentState!.validate()) {
              insertToDatabase(
                   titleController.text,
                  dateController.text,
                  timeController.text).then((value)
              {
                Navigator.pop(context); // by3ml back beeha
                isButtomSheet = false;
                setState(() {
                  fabIcon = Icons.edit;
              });

              });
            }
          } else {
            scaffoldKey.currentState?.showBottomSheet(
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
            ).closed.then((value) // closed de 3shan lma anzel el bottom sheet be 2eedy el icon tet8yer
            {
              // msh m7tageen navigator.pop hena 3shan howa hy2fel el bottom sheet w y8yer el icon bs msh hy3mel back
              isButtomSheet = false;
              setState(() {
                fabIcon = Icons.edit;
              });
            });
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
        'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT, status TEXT)');
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
    getDataFromDatabase(database).then((value) // then btdeni el return bta3 el function
    {
      tasks = value;
      print(tasks);
    });
  });
}

Future insertToDatabase(
    @required String title,
@required String date,
@required String time,
    ) async {
 return await database.transaction((txn) async {
    txn
        .rawInsert(
            'INSERT INTO tasks(title, time, date, status) VALUES("$title", "$time", "$date", "jhj")')
        .then((value) {
      print('$value  inserted succesfully');
    }).catchError((error) {
      print('error when inserting ${error.toString()}');
    });
  });
}
Future <List<Map>> getDataFromDatabase(database) async
{
 return await database.rawQuery('SELECT * FROM tasks');

}
