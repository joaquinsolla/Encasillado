import 'package:Joadle/common_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'common_variables.dart';
import 'common_colors.dart';
import 'in_game_keyboard.dart';
import 'common_methods.dart';
import 'common_widgets.dart';


class JoadleApp extends StatelessWidget {
  const JoadleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Joadle",
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
    restart_game_variables();
    generate_standard_word();

    /** working on trial time */
    if(index == 2) {
      index = currentPage;
    }
    /** - */

    setState(() {
      currentPage = index;
    });

    startDate = DateTime.now();
    runApp(JoadleApp());
    if (currentPage == 0 && wordOfTheDayDialogShown == false) show_wotd_dialog(context);
  }

  @override
  Widget build(BuildContext context) {

    check_device_size(context);
    check_settings();

    return Scaffold(
      backgroundColor: myWhite,
      appBar: myAppBarWithButtons(context),

      body: Column(children: [
        game_banner(context),
        cellsField(),
        Expanded(child: Text(""),),
        generate_keyboard(context),
        SizedBox(height: 7.5,),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.timer_outlined),
            label: '      Modo\nContrarreloj',
          ),
        ],
        currentIndex: currentPage,
        selectedItemColor: Colors.white,
        onTap: bottom_tapped,
      ),
    );
  }
}