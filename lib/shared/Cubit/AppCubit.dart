
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inkaz/Archive%20Tasks/archiveTasks.dart';
import 'package:inkaz/Done%20Tasks/DoneTasks.dart';
import 'package:inkaz/new%20Tasks/New_tasks.dart';
import 'package:inkaz/shared/Cubit/AppStates.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit():super(AppInitialStates());
   static AppCubit get(context)=>BlocProvider.of(context);
  int currentIndex = 0;
  late Database database;
  List<Map>? newTasks = [];
  List<Map>? doneTasks = [];
  List<Map>? archiveTasks = [];

  List<String> textAppBar = [
    'New Task',
    'Done Task',
    'Archive',
  ];
  List<Widget> screen = [
    NewTasks(),
    Donw_Tasks(),
    arciveTasks(),
  ];
  List<IconData> Icon = [
    Icons.add_task_outlined,
    Icons.done_all,
    Icons.archive_outlined,
  ];
  void changeNavBar(index)
  {
    currentIndex = index;
    emit(AppChangeNavBar());
  }
  bool isBottomSheetShown = false;
  IconData? fabIcon = Icons.edit;
  void ChangeBootpmSheet(
  {
  required bool IsShow,
    required IconData icon,
})
  {
    isBottomSheetShown = IsShow;
    fabIcon = icon;
    emit(AppChangeBottomSheet());
  }
  void createDatabase() async {
    database = await openDatabase('todo.db', version: 1,
        onCreate: (database, version) {
          print('Database Created');
          database
              .execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY ,title TEXT,time TEXT,date TEXT,status TEXT)')
              .then((value) {
            print('Table Created');
          }).catchError((error) {
            print('error is ${error.toString()}');
          });
        }, onOpen: (database) {
          GetDataFromDatabase(database);
          print('database open');
        }).then((value) 
    {
      database = value;
      emit(AppCreateDatabase());
      return database;
    });
  }

  void GetDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];
    emit(AppGetLoadingDatabase());
    database!.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element)
      {
        if(element['status']=='new')
          newTasks!.add(element);
        else if(element['status']=='done')
          doneTasks!.add(element);
        else archiveTasks!.add(element);

      });
      emit(AppGetDatabase());
    });
  }

   Future insertToDatabase(
       String? title,
      String? time,
      String? date,
  ) async {
    await database.transaction((txn) {
      return txn
          .rawInsert(
          'INSERT INTO tasks (title,time,date,status) VALUES("${title}" , "${time}" , "${date}" , "new") ')
          .then((value) {
        print('${value} inserted');
        emit(AppInsertDatabase());
        GetDataFromDatabase(database);
      }).catchError((error) {
        print('error while insert ${error.toString()}');
      });
    });
  }
void UpdateItem(
  {
  required String status,
    required int id,
})
{
  database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ? ',
    ['$status' , id],
  ).then((value)
  {
    GetDataFromDatabase(database);
    emit(AppUpdateDatabase());
  });

}
  void DeleteItem(
      {
        required int id,
      })
  {
    database.rawDelete('DELETE FROM tasks WHERE id = ? ',
      [id],
    ).then((value)
    {
      GetDataFromDatabase(database);
      emit(AppDeleteDatabase());
    });
}}