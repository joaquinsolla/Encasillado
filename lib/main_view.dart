import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'common_variables.dart';
import 'common_colors.dart';
import 'in_game_keyboard.dart';
import 'common_methods.dart';
import 'common_widgets.dart';

class EncasilladoApp extends StatelessWidget {
  const EncasilladoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  void bottom_tapped(int index) {
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
        if (currentPage == 0 && wordOfTheDayDialogShown == false)
          show_wotd_explanation_dialog(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (appStarted == false) {
      var brightness = MediaQuery.of(context).platformBrightness;
      darkMode = brightness == Brightness.dark;
    }

    Color wotdButtonColor = appColor;
    Color infiniteButtonColor = appDarkestColor;
    if (currentPage == 0) {
      wotdButtonColor = appDarkestColor;
      infiniteButtonColor = appColor;
    }
    if (currentPage == 1) {
      wotdButtonColor = appColor;
      infiniteButtonColor = appDarkestColor;
    }

    check_device(context);
    check_settings();

    appStarted = true;

    return Scaffold(
      backgroundColor: myWhite,
      appBar: myAppBarWithButtons(context),
      body: Column(children: [
        Container(
          height: 50,
          color: appDarkerColor,
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
                      bottom_tapped(0);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: wotdButtonColor,
                    ),
                    child: Text(
                      "¡La palabra del día!",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    )),
              ),
              Expanded(
                child: TextButton(
                    onPressed: () {
                      bottom_tapped(1);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: infiniteButtonColor,
                    ),
                    child: Text(
                      "Palabras infinitas",
                      style: TextStyle(color: Colors.white, fontSize: 12),
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
