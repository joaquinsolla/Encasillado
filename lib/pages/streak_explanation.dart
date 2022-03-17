import 'package:Encasillado/common/imagepaths.dart';
import 'package:flutter/material.dart';
import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/widgets.dart';
import 'package:Encasillado/common/colors.dart';

class StreakExplanation extends StatefulWidget {
  @override
  _StreakExplanationState createState() => _StreakExplanationState();
}

class _StreakExplanationState extends State<StreakExplanation> {
  @override
  Widget build(BuildContext context) {

    String myStreakGif;
    if (darkMode) {
      myStreakGif = streakGifDarkmode;
    } else {
      myStreakGif = streakGifLightmode;
    }

    return Scaffold(
      appBar: myAppBarWithoutButtons(context),
      backgroundColor: appWhite,
      body: Container(
        margin: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
        alignment: Alignment.topCenter,
        child: ListView(
          addAutomaticKeepAlives: true,
          children: [
            SizedBox(
              height: 5,
            ),
            Text(
              "Rachas",
              style: TextStyle(
                fontSize: 25,
                color: appBlack,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                fontFamily: 'RaleWay',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "¿Cómo funciona?",
              style: TextStyle(
                fontSize: 16,
                color: appBlack,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                fontFamily: 'RaleWay',
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              "El juego comienza con racha de 0 aciertos. Cada vez que aciertes una palabra tu racha aumentará "
                  "en 1, pero si no aciertas, volverá a 0.\n",
              style: TextStyle(
                fontSize: 15,
                color: appBlack,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
                fontFamily: 'RaleWay',
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Bonificación",
              style: TextStyle(
                fontSize: 16,
                color: appBlack,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                fontFamily: 'RaleWay',
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              "Las rachas actúan de bonificación para obtener más puntos de cada acierto.\n"
                  "La puntuación extra por racha se calcula de la forma:\n\n"
                  "Extra = Puntuación x (racha x 0.1)\n\n"
                  "¿Hasta cuánto podrás llegar?\n",
              style: TextStyle(
                fontSize: 15,
                color: appBlack,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
                fontFamily: 'RaleWay',
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tu racha actual:  ",
                  style: TextStyle(
                    fontSize: 20,
                    color: appBlack,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontFamily: 'RaleWay',
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(3.0, 2.0, 3.0, 2.0),
                  decoration: BoxDecoration(
                    color: keyColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Text(
                        " x" + streak.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          color: appBlack,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          fontFamily: 'RaleWay',
                        ),
                      ),
                      Image.asset(
                        myStreakGif,
                        scale: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        primary: appWhite,
                        backgroundColor: appMainColor,
                      ),
                      child: Text("VALE")),
                ],
              ),
            ),
            Text(
              "\nGracias por jugar a Encasillado\n\nEncasillado versión $currentVersion",
              style: TextStyle(
                fontSize: 12,
                color: appGrey,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
                fontFamily: 'RaleWay',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ));
  }
}