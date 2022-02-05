import 'package:Joadle/user_settings.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'common.dart';
import 'my_keyboard.dart';


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

    /** CHECK SETTINGS */
    if (colorBlind){
      myGreen = Colors.orange;
      myYellow = Colors.blue;
      greenEmoji = "🟧";
      yellowEmoji = "🟦";
    } else {
      myGreen = Colors.green;
      myYellow = Color(0xfff3d500);
      greenEmoji = "🟩";
      yellowEmoji = "🟨";
    }

    if (nightMode){
      myBlack = Colors.white;
      myWhite = Color(0xff2d2d2d);
      mySemiBlack = Colors.white;
      whiteEmoji = "⬛";
      keyColor = Color(0xff131313);
    } else {
      myBlack = Colors.black;
      myWhite = Colors.white;
      mySemiBlack = Colors.black54;
      whiteEmoji = "⬜";
      keyColor = Color(0xffefefef);
    }

    return Scaffold(
      backgroundColor: myWhite,
      appBar: MainAppBar(context, true),
      body: Column (children: [
        cellsField(),
        Expanded(child: Text(""),),
        generate_keyboard(context),
      ]),
    );
  }
}