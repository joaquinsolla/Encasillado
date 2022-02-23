import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flushbar/flushbar.dart';

import 'common_imagepaths.dart';
import 'common_pages.dart';
import 'common_variables.dart';
import 'common_colors.dart';
import 'main_view.dart';


AppBar myAppBarWithButtons(BuildContext context) {
  double imageScale;
  if (deviceWidth < 340)
    imageScale = 11;
  else
    imageScale = 8;

  return AppBar(
    backgroundColor: appMainColor,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          banner_logo,
          scale: imageScale,
        ),
        Expanded(child: Text("")),
        Expanded(
          child: RawMaterialButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const explanation_page()));
            },
            elevation: 0,
            child: Image.asset(help_icon),
            fillColor: appSecondColor,
            shape: CircleBorder(),
          ),
        ),
        SizedBox(width: 5,),
        Expanded(
          child: RawMaterialButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const settings_page()));
            },
            elevation: 0,
            child: Image.asset(settings_icon),
            fillColor: appSecondColor,
            shape: CircleBorder(),
          ),
        ),
      ],
    ),
  );
}

AppBar myAppBarWithoutButtons(BuildContext context) {
  double imageScale;
  if (deviceWidth < 340)
    imageScale = 11;
  else
    imageScale = 8;

  return AppBar(
    backgroundColor: appMainColor,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          banner_logo,
          scale: imageScale,
        ),
      ],
    ),
  );
}

//TODO: OK
AnimatedContainer letterCell(String char, String col) {
  //COLOR SELECTION
  Color? cellColor = myWhite;
  if (col == "V") cellColor = myGreen;
  if (col == "A") cellColor = myYellow;
  if (col == "G") cellColor = myGrey;

  return AnimatedContainer(
    duration: Duration(milliseconds: 750),
    curve: Curves.easeInOutCirc,
    width: ((deviceHeight * 0.5) / 6 - 13.0),
    height: ((deviceHeight * 0.5) / 6 - 13.0),
    margin: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 6.0),
    padding: const EdgeInsets.all(0.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: cellColor,
      border: Border.all(color: mySemiBlack, width: 0.0),
    ),
    child: Text(
      char,
      style:
          TextStyle(fontSize: ((deviceHeight * 0.5) / 6 - 25), color: myBlack),
    ),
  );
}

//TODO: OK
Row letterRowInfinite(int _from) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      letterCell(inputMatrixInfinite[_from], colorsArrayInfinite[_from]),
      letterCell(inputMatrixInfinite[_from + 1], colorsArrayInfinite[_from + 1]),
      letterCell(inputMatrixInfinite[_from + 2], colorsArrayInfinite[_from + 2]),
      letterCell(inputMatrixInfinite[_from + 3], colorsArrayInfinite[_from + 3]),
      letterCell(inputMatrixInfinite[_from + 4], colorsArrayInfinite[_from + 4]),
    ],
  );
}

Row letterRowWotd(int _from) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      letterCell(inputMatrixWotd[_from], colorsArrayWotd[_from]),
      letterCell(inputMatrixWotd[_from + 1], colorsArrayWotd[_from + 1]),
      letterCell(inputMatrixWotd[_from + 2], colorsArrayWotd[_from + 2]),
      letterCell(inputMatrixWotd[_from + 3], colorsArrayWotd[_from + 3]),
      letterCell(inputMatrixWotd[_from + 4], colorsArrayWotd[_from + 4]),
    ],
  );
}

//TODO: OK
Column cellsFieldInfinite() {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 10.0,
        ),
        letterRowInfinite(0),
        letterRowInfinite(5),
        letterRowInfinite(10),
        letterRowInfinite(15),
        letterRowInfinite(20),
        letterRowInfinite(25),
      ]);
}

Column cellsFieldWotd() {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 10.0,
        ),
        letterRowWotd(0),
        letterRowWotd(5),
        letterRowWotd(10),
        letterRowWotd(15),
        letterRowWotd(20),
        letterRowWotd(25),
      ]);
}

Container game_banner(BuildContext context) {
  String streakGif;
  if (darkMode) {
    streakGif = streak_gif_darkmode;
  } else {
    streakGif = streak_gif;
  }

  String streakCount = " x" + streak.toString();
  String gameString = "Palabras infinitas";
  if (currentPage == 0) gameString = "¡La palabra del día!";
  if (currentPage == 1) gameString = "Palabras infinitas";
  if (currentPage == 2) gameString = "Modo contrarreloj";

  return Container(
    height: deviceHeight * 0.078 - 15.0,
    margin: EdgeInsets.fromLTRB(7.5, 5.0, 7.5, 0.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 15,
        ),
        Text(
          gameString,
          style: TextStyle(
            fontSize: 17,
            color: myBlack,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
            fontFamily: 'RaleWay',
          ),
        ),
        Expanded(child: Text("")),
        if (currentPage == 1)
          Container(
            padding: const EdgeInsets.fromLTRB(3.0, 2.0, 3.0, 2.0),
            decoration: BoxDecoration(
              color: keyColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Image.asset(
                  streakGif,
                  scale: 15,
                ),
                Text(
                  streakCount,
                  style: TextStyle(
                    fontSize: 15,
                    color: myBlack,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none,
                    fontFamily: 'RaleWay',
                  ),
                ),
              ],
            ),
          ),
        SizedBox(
          width: 5.0,
        ),
        current_version_button(context),
      ],
    ),
  );
}

TextButton current_version_button(BuildContext context) {
  return TextButton(
    onPressed: () {
      runApp(EncasilladoApp());
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const update_version_page()));
    },
    style: TextButton.styleFrom(
      primary: myBlack,
      backgroundColor: keyColor,
    ),
    child: Text(
      currentVersion,
      style: TextStyle(color: myBlack),
    ),
  );
}

void word_doesnt_exist_snackbar(BuildContext context) {
  //may cause problems with null sound safety
  Flushbar(
    message: "La palabra no existe",
    duration: Duration(seconds: 3),
    backgroundColor: Colors.redAccent,
    flushbarPosition: FlushbarPosition.TOP,
  ).show(context);
}

//TODO: REMOVE
Widget wotd_done_dialog(BuildContext context) {
  return AlertDialog(
    backgroundColor: myWhite,
    title: Text(
      '¡Ya has descubierto la palabra de hoy!',
      style: TextStyle(color: myBlack),
    ),
    content: Text(
      "Ya has completado el juego de hoy, pero mañana habrá otra palabra esperándote.\n\n"
      "Una palabra nueva a las 00:00",
      style: TextStyle(color: myBlack),
    ),
    actions: <Widget>[
      TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            primary: myWhite,
            backgroundColor: appMainColor,
          ),
          child: Text("VALE")),
    ],
  );
}