import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqf_flutter/archive/archive.dart';
import 'package:sqf_flutter/done_Tasks/done_tasks.dart';
import 'package:sqf_flutter/new_tasks/new_tsks.dart';
import 'package:sqflite/sqflite.dart';
class layout extends StatefulWidget {

  @override
  State<layout> createState() => _layoutState();
}

class _layoutState extends State<layout> {
  int currentIndex =0;
  List<Widget> Screens =[
    new_tasks(),
    done_tasks(),
    archive(),
  ];
  List<String> Titles =[
    'New Tasks',
    'Done Tasks',
    'Archive'
  ];
// steps for sqflite:
  //1-create database
  //2-create tables
  //3-open database
  //4-insert into database
  //5-get from database
  //6-update database
  //7-delete database
@override
  void initState() {

    super.initState();
    createDatabase();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Titles[currentIndex]
        ),
      ),
      body: Screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        child: Icon(Icons.add),
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
        onTap: (index){
          setState(() {
            currentIndex =index;
          });
        },
      ),
    );
  }
}
void createDatabase()async{
 var database = await openDatabase(
   'todo.db', // path = database name
   version: 1, // b3mel update lma a8ir haga fe el structure bta3 el database a add table mathlen
   onCreate: (database,version)async
   // object men el db elly 7slha create ==> database
     // elly foo2 ==> version
      {
        database.execute('CREAT TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT, )').then((value) {
          print('table created');
        }).catchError((error){
          print('error when creating table ${error.toString()}');
        });
      },
      onOpen: (database){
     print('database opened');
 }
 );
}