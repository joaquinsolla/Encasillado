import 'package:flutter/material.dart';
import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/widgets.dart';
import 'package:Encasillado/common/colors.dart';

class UpdateNews extends StatefulWidget {
  @override
  _UpdateNewsState createState() => _UpdateNewsState();
}

class _UpdateNewsState extends State<UpdateNews> {
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
              "Versión " + currentVersion + ":",
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
              "¡Presentando al Bot de Twitter!",
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
              "El juego tiene ahora un bot de Twitter oficial que tuitea cuál ha sido"
                  " la palabra del día cada noche.\n",
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
              height: 7.5,
            ),
            Text(
              "Lista de palabras actualizada",
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
              "Se han añadido nuevas palabras al juego.\n",
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
              height: 7.5,
            ),
            Text(
              "Corrección de errores",
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
              "Corregidos varios errores tanto en la interfaz como en "
                  "el funcionamiento del juego.\n",
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
              height: 7.5,
            ),
            Text(
              "En desarrollo:",
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
              height: 10,
            ),
            Text(
              "Actualmente se está trabajando para incorporar las siguientes funcionalidades al juego:\n",
              style: TextStyle(
                fontSize: 16,
                color: appBlack,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
                fontFamily: 'RaleWay',
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              "Lista de palabras en proceso de mejora",
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
              "Continuamente se está aumentando la lista de palabras del juego."
                  " Siempre puedes aportar sugerencias sobre nuevas palabras contactando"
                  " vía email en el apartado de ajustes.\n",
              style: TextStyle(
                fontSize: 15,
                color: appBlack,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
                fontFamily: 'RaleWay',
              ),
              textAlign: TextAlign.left,
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