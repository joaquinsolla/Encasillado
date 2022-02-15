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
    imageScale = 13;
  else
    imageScale = 9.5;

  return AppBar(
    backgroundColor: appColor,
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
            fillColor: appDarkerColor,
            shape: CircleBorder(),
          ),
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
            child: Image.asset(settings_icon),
            fillColor: appDarkerColor,
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
    imageScale = 13;
  else
    imageScale = 9.5;

  return AppBar(
    backgroundColor: appColor,
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

Row letterRow(int _from) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      letterCell(inputMatrix[_from], colorsArray[_from]),
      letterCell(inputMatrix[_from + 1], colorsArray[_from + 1]),
      letterCell(inputMatrix[_from + 2], colorsArray[_from + 2]),
      letterCell(inputMatrix[_from + 3], colorsArray[_from + 3]),
      letterCell(inputMatrix[_from + 4], colorsArray[_from + 4]),
    ],
  );
}

Column cellsField() {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 10.0,
        ),
        letterRow(0),
        letterRow(5),
        letterRow(10),
        letterRow(15),
        letterRow(20),
        letterRow(25),
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
    height: deviceHeight * 0.07 - 5.0,
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
              borderRadius: BorderRadius.circular(10),
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
        if (updates_pushed == false) updates_button_blinking(),
        if (updates_pushed == true) updates_button_not_blinking(context),
      ],
    ),
  );
}

TextButton updates_button_not_blinking(BuildContext context) {
  String updatesImage;
  if (darkMode) {
    updatesImage = future_updates_image_darkmode;
  } else {
    updatesImage = future_updates_image;
  }

  return TextButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(keyColor),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
    onPressed: () {
      if (updates_pushed == false) updates_pushed = true;
      runApp(EncasilladoApp());
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const updates_page()));
    },
    child: Container(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      decoration: BoxDecoration(
        color: keyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset(
        updatesImage,
        scale: 9,
      ),
    ),
  );
}

class updates_button_blinking extends StatefulWidget {
  @override
  _updates_button_blinkingState createState() =>
      _updates_button_blinkingState();
}

class _updates_button_blinkingState extends State<updates_button_blinking>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: updates_button_not_blinking(context),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
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

Widget wotd_explanation_dialog(BuildContext context) {
  return AlertDialog(
    backgroundColor: myWhite,
    title: Text(
      '¡La palabra del día!',
      style: TextStyle(color: myBlack),
    ),
    content: Text(
      "Cada día hay una nueva palabra oculta.\n\n"
      "¡La misma palabra para todos los jugadores!\n\n"
      "Comparte tu resultado y compite con tus amigos por ver quién es el mejor cada día.",
      style: TextStyle(color: myBlack),
    ),
    actions: <Widget>[
      TextButton(
          onPressed: () {
            wordOfTheDayDialogShown = true;
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            primary: myWhite,
            backgroundColor: appColor,
          ),
          child: Text("VAMOS ALLÁ")),
    ],
  );
}

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
            wordOfTheDayDialogShown = true;
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            primary: myWhite,
            backgroundColor: appColor,
          ),
          child: Text("VALE")),
    ],
  );
}