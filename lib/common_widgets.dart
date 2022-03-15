import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:twitter_intent/twitter_intent.dart';

import 'package:flushbar/flushbar.dart';

import 'common_imagepaths.dart';
import 'common_methods.dart';
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
            child: Image.asset(help_icon, scale: 35,),
            fillColor: appSecondColor,
            shape: CircleBorder(),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: RawMaterialButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const settings_page()));
            },
            elevation: 0,
            child: Image.asset(settings_icon, scale: 67.5,),
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

Row letterRowInfinite(int _from) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      letterCell(inputMatrixInfinite[_from], colorsArrayInfinite[_from]),
      letterCell(
          inputMatrixInfinite[_from + 1], colorsArrayInfinite[_from + 1]),
      letterCell(
          inputMatrixInfinite[_from + 2], colorsArrayInfinite[_from + 2]),
      letterCell(
          inputMatrixInfinite[_from + 3], colorsArrayInfinite[_from + 3]),
      letterCell(
          inputMatrixInfinite[_from + 4], colorsArrayInfinite[_from + 4]),
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
  String gameString = "Palabras infinitas";
  if (currentPage == 0) gameString = "¡La palabra del día!";
  if (currentPage == 1) gameString = "Palabras infinitas";

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
        if (currentPage == 1) points_button(context),
        SizedBox(
          width: 5.0,
        ),
        if (currentPage == 1)
          SizedBox(
            height: 36,
            child: streak_button(context),
          ),
        if (currentPage == 0) twitter_bot_button(context),
        SizedBox(
          width: 5.0,
        ),
        if (currentPage == 0) current_version_button(context),
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

TextButton twitter_bot_button(BuildContext context) {
  String img;
  if (darkMode) img = twitter_bot_image_darkmode;
  else img = twitter_bot_image;

  final botLink = FollowUserIntent(username: 'encasillado_bot');

  return TextButton(
    onPressed: () {
      url_launcher('$botLink');
    },
    style: TextButton.styleFrom(
      primary: myBlack,
      backgroundColor: keyColor,
    ),
    child: Image.asset(img, scale: 58,),
  );
}

TextButton points_button(BuildContext context) {
  return TextButton(
    onPressed: () {
      runApp(EncasilladoApp());
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const points_page()));
    },
    style: TextButton.styleFrom(
      primary: myBlack,
      backgroundColor: keyColor,
    ),
    child: Text(
      " Puntos: " + pointsInfinite.toString() + " ",
      style: TextStyle(
        fontSize: 15,
        color: myBlack,
        fontWeight: FontWeight.normal,
        decoration: TextDecoration.none,
        fontFamily: 'RaleWay',
      ),
    ),
  );
}

TextButton streak_button(BuildContext context) {
  String streakGif;
  if (darkMode) {
    streakGif = streak_gif_darkmode;
  } else {
    streakGif = streak_gif;
  }

  String streakCount = " x" + streak.toString();

  return TextButton(
    onPressed: () {
      runApp(EncasilladoApp());
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const streak_page()));
    },
    style: TextButton.styleFrom(
      primary: myBlack,
      backgroundColor: keyColor,
    ),
    child: Row(
      children: [
        Image.asset(
          streakGif,
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
