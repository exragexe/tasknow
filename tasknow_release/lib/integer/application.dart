import 'package:flutter/material.dart';
import 'package:tasknow_release/screens/createscreen.dart';
import 'package:tasknow_release/screens/home.dart';
import 'package:tasknow_release/screens/loading.dart';
import 'package:tasknow_release/screens/settings.dart';


class Application extends StatelessWidget {
 const Application({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
      routes: {
        '/home': (context) => Home(tasks: const [],),
        '/load':(context)=>  const Loading(),
        '/settings':(context)=>  const Settings(),
        '/createscreens':(context)=>  const CreateScreen(),
      },
      initialRoute: '/load',
      debugShowCheckedModeBanner: false,
    );
  }
}