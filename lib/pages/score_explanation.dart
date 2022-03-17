import 'package:flutter/material.dart';
import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/widgets.dart';
import 'package:Encasillado/common/colors.dart';

class ScoreExplanation extends StatefulWidget {
  @override
  _ScoreExplanationState createState() => _ScoreExplanationState();
}

class _ScoreExplanationState extends State<ScoreExplanation> {
  @override
  Widget build(BuildContext context) {
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
              "Tu puntuación actual: " + pointsInfinite.toString(),
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
              "Puntuación = (900 - tiempo) x (7 - intentos) x (1 + racha x 0.1)\n\n"
                  "¡Acertar al primer intento te dará 50.000 puntos!\n",
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
              "Tiempo de partida",
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
              "Si la partida dura menos de 15 minutos, puntuarás. Cada partida comienza con 900 puntos "
                  "y por cada segundo que pasa se resta 1 punto.\n",
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
              "Intentos",
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
              "En cada partida se dispone de hasta 6 intentos. Si aciertas a la primera ganarás 50.000 puntos. "
                  "En el resto de los casos los puntos obtenidos según el tiempo se multiplicarán por 7 menos el número "
                  "de intentos realizados.\n",
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
              "Racha",
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
              "Si tienes una racha de partidas ganadas, tu puntuación por partida"
                  " será multiplicada por una pequeña bonificación.\n",
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
              "Penalizaciones",
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
              "Acertar una palabra en más de 15 minutos no suma ni resta puntos.\n"
                  "No acertar una palabra resta 1000 puntos.\n",
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
              "\nGracias por jugar a Encasillado\n\nEncasillado versión $appVersion",
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