import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:inkaz/home_layouts/home_layouts.dart';
import 'package:inkaz/shared/BlocObserve.dart';
import 'package:inkaz/test.dart';
import 'package:sqflite/sqflite.dart';
import 'GetStarted/get_started.dart';


void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:getStarted(),
    );
  }
}

