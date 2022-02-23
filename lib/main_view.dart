import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

import 'common_variables.dart';
import 'common_colors.dart';
import 'in_game_keyboard.dart';
import 'common_methods.dart';
import 'common_widgets.dart';

class EncasilladoApp extends StatelessWidget {
  const EncasilladoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: "Encasillado",
      debugShowCheckedModeBanner: false,
      home: MainView(),
    );
  }
}

class MainView extends StatefulWidget {
  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends State<MainView> {
  void top_navbar_tapped(int index) {
    if (currentPage != index) {
      if (index == 0 && wotdDone)
        show_wotd_done_dialog(context);
      else {
        restart_game_variables();
        generate_standard_word();

        setState(() {
          currentPage = index;
        });

        startDate = DateTime.now();
        runApp(EncasilladoApp());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (appStarted == false) {
      var brightness = MediaQuery.of(context).platformBrightness;
      darkMode = brightness == Brightness.dark;
    }

    Color wotdButtonColor = appMainColor;
    Color infiniteButtonColor = appThirdColor;
    TextStyle wotdStyle = TextStyle(color: Colors.white, fontSize: 12, decoration: TextDecoration.underline, decorationStyle: TextDecorationStyle.wavy,);
    TextStyle infiniteStyle = TextStyle(color: Colors.white, fontSize: 12,);

    if (currentPage == 0) {
      wotdButtonColor = appThirdColor;
      infiniteButtonColor = appMainColor;
      wotdStyle = TextStyle(color: Colors.white, fontSize: 12, decoration: TextDecoration.underline, decorationStyle: TextDecorationStyle.wavy,);
      infiniteStyle = TextStyle(color: Colors.white, fontSize: 12,);
    }
    if (currentPage == 1) {
      wotdButtonColor = appMainColor;
      infiniteButtonColor = appThirdColor;
      wotdStyle = TextStyle(color: Colors.white, fontSize: 12,);
      infiniteStyle = TextStyle(color: Colors.white, fontSize: 12, decoration: TextDecoration.underline, decorationStyle: TextDecorationStyle.wavy,);
    }

    check_device(context);
    check_settings();

    appStarted = true;

    return Scaffold(
      backgroundColor: myWhite,
      appBar: myAppBarWithButtons(context),
      body: Column(children: [
        Container(
          height: deviceHeight*0.072,
          color: appSecondColor,
          padding: EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: TextButton(
                    onPressed: () {
                      top_navbar_tapped(0);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: wotdButtonColor,
                    ),
                    child: Text(
                      "¡La palabra del día!",
                      style: wotdStyle,
                    )),
              ),
              Expanded(
                child: TextButton(
                    onPressed: () {
                      top_navbar_tapped(1);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: infiniteButtonColor,
                    ),
                    child: Text(
                      "Palabras infinitas",
                      style: infiniteStyle,
                    )),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
        game_banner(context),
        cellsField(),
        Expanded(
          child: Text(""),
        ),
        generate_keyboard(context),
        SizedBox(height: 2.5,),
      ]),
    );
  }
}
