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

    check_device(context);
    check_settings();

    appStarted = true;

    return Scaffold(
      backgroundColor: myWhite,
      appBar: myAppBarWithButtons(context),
      body: Column(children: [
        game_banner(context),
        cellsField(),
        Expanded(
          child: Text(""),
        ),
        generate_keyboard(context),
        SizedBox(
          height: 7.5,
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: appColor,
        unselectedItemColor: Colors.black45,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded),
            label: '¡La palabra\n   del día!',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.loop_rounded),
            label: 'Palabras\n infinitas',
          ),
        ],
        currentIndex: currentPage,
        selectedItemColor: Colors.white,
        onTap: bottom_tapped,
      ),
    );
  }
}
