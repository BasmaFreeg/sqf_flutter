import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqf_flutter/shared/Cubit/states.dart';
import 'package:sqflite/sqflite.dart';

import '../../archive/archive.dart';
import '../../done_Tasks/done_tasks.dart';
import '../../new_tasks/new_tsks.dart';
import '../components/constants.dart';

class TodoCubit extends Cubit<TodoStates> {
  TodoCubit() : super(TodoIntialState());
  static TodoCubit get(context) => BlocProvider.of(context);

  late Database
      database; // late : hyt3maloh create b3deen lma n7tagoh msh dlwa2ti
  int currentIndex = 0;

  List<Widget> Screens = [
    new_tasks(),
    done_tasks(),
    archive(),
  ];
  List<String> Titles = ['New Tasks', 'Done Tasks', 'Archive'];
  void ChangeIndex(int index) {
    currentIndex = index;
    emit(TodoChangeNavBar());
  }

  void createDatabase() {
    openDatabase('todoAppp.db', // path = database name
        version:
            1, // b3mel update lma a8ir haga fe el structure bta3 el database a add table mathlen
        onCreate: (database, version)
            // object men el db elly 7slha create ==> database
            // elly foo2 ==> version
            async {
      database.execute(
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
      getDataFromDatabase(database)
          .then((value) // then btdeni el return bta3 el function
              {
        tasks = value;
        print(tasks);
        emit(TodoGetDatabase());
      });
    }).then((value) {
      database = value;
      emit(TodoCreateDatabase());
    });
  }

  Future insertToDatabase(
    @required String title,
    @required String date,
    @required String time,
  ) async {
    return await database.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO tasks(title, time, date, status) VALUES("$title", "$time", "$date", "jhj")');
      //     .then((value) {
      //   print('$value  inserted succesfully');
      // }).catchError((error) {
      //   print('error when inserting ${error.toString()}');
      // });
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    return await database.rawQuery('SELECT * FROM tasks');
  }
}
