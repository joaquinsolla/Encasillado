import 'package:flutter/material.dart';

import 'common.dart';
import 'my_keyboard.dart';
import 'word_database.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title : "My Wordle",
      debugShowCheckedModeBanner: false,
      home : Inicio(),
    );
  }
}

class Inicio extends StatefulWidget {
  Inicio({Key? key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

// Screen
class _InicioState extends State<Inicio> {

  @override
  Widget build(BuildContext context) {
    devWidth = MediaQuery.of(context).size.width;
    devHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: MainAppBar(),
      body: Column (children: [
        cellsField(),
        Expanded(child: Text(""),),
        generate_keyboard(),
      ]),
    );
  }
}