import 'dart:math';

import 'package:Encasillado/common/methods.dart';
import 'package:Encasillado/common/miscellaneous.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:Encasillado/common/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetUserName extends StatefulWidget {
  @override
  _SetUserNameState createState() => _SetUserNameState();
}

class _SetUserNameState extends State<SetUserName> {
  final userNameController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    Text mainText(String content) {
      return Text(
        content,
        style: TextStyle(
          fontSize: 16,
          color: appBlack,
          fontWeight: FontWeight.normal,
          decoration: TextDecoration.none,
          fontFamily: 'RaleWay',
        ),
        textAlign: TextAlign.center,
      );
    }

    _save_user() async {
      final prefs = await SharedPreferences.getInstance();
      final key1 = 'username';
      final key2 = 'userid';
      prefs.setString(key1, userName!);
      prefs.setString(key2, userId!);
      if(terminalPrinting) print('[SYS] Saved $userName on username');
      if(terminalPrinting) print('[SYS] Saved $userId on userid');
    }

    return Scaffold(
      backgroundColor: appWhite,
      body: Container(
          margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
          alignment: Alignment.topCenter,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              addAutomaticKeepAlives: true,
              children: [
                Center(
                  child: Icon(
                    Icons.person_pin_circle_rounded,
                    color: appMainColor,
                    size: deviceWidth * 0.5,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    "Nombre de jugador",
                    style: TextStyle(
                      fontSize: 25,
                      color: appBlack,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                      fontFamily: 'RaleWay',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 7.5,
                ),
                Center(
                  child: mainText(
                      "Para figurar en los marcadores del juego debes introducir un nombre de usuario. "
                      "Si lo prefieres, puedes jugar de forma anónima."),
                ),
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: TextField(
                    maxLength: 20,
                    style: TextStyle(color: appBlack),
                    controller: userNameController,
                    decoration: InputDecoration(
                      counterStyle: TextStyle(color: appBlack),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: appBlack, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: appMainColor, width: 1),
                      ),
                      labelText: 'Tu nombre de jugador',
                      labelStyle: TextStyle(color: appMainColor),
                      hintText: '',
                      hintStyle: TextStyle(color: appBlack),
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                      onPressed: () {
                        FirebaseFirestore firestore = FirebaseFirestore.instance;
                        CollectionReference users = firestore.collection('users');
                        DateTime now = DateTime.now();
                        String formattedDate = DateFormat('dd-MM-yyyy – kk:mm:ss').format(now);
                        String newUserId = userNameController.text + formattedDate.substring(0,2) +
                            formattedDate.substring(3,5) + formattedDate.substring(6,10) +
                            formattedDate.substring(13,15) + formattedDate.substring(16,18) +
                            formattedDate.substring(19) + (Random().nextInt(10)).toString();

                        setState(() {
                          userName = userNameController.text;
                          userId = newUserId;
                        });
                        _save_user();

                        users
                            .add({
                          'name': userName,
                          'id': userId,
                          'scoreRecord': scoreRecord,
                          'streakRecord': streakRecord,
                        })
                            .then((value) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Navigator.pushNamed(context, '/home');
                          Flushbar(
                            message: "¡Bienvenido $userName!",
                            duration: Duration(seconds: 3),
                            backgroundColor: Colors.orange,
                            flushbarPosition: FlushbarPosition.TOP,
                          ).show(context);
                        })
                            .timeout(Duration(seconds: 5), onTimeout: () {
                          Flushbar(
                            message: "Revisa tu conexión a Internet e inténtalo de nuevo",
                            duration: Duration(seconds: 3),
                            backgroundColor: Colors.red,
                            flushbarPosition: FlushbarPosition.TOP,
                          ).show(context);
                          if (terminalPrinting) print("[ERR] Failed to save name: Timeout");
                        })
                            .catchError((error) {
                          Flushbar(
                            message: "Algo ha fallado, inténtalo más tarde",
                            duration: Duration(seconds: 3),
                            backgroundColor: Colors.red,
                            flushbarPosition: FlushbarPosition.TOP,
                          ).show(context);
                          if (terminalPrinting) print("[ERR] Failed to save name: $error");
                        });
                      },
                      style: TextButton.styleFrom(
                        primary: appWhite,
                        backgroundColor: appMainColor,
                      ),
                      child: Text(
                        "Guardar nombre",
                        style: TextStyle(fontSize: 16),
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          userName = null;
                          userId = null;
                        });
                        Navigator.pushNamed(context, '/home');
                        Flushbar(
                          message: "Jugando de forma anónima",
                          duration: Duration(seconds: 3),
                          backgroundColor: Colors.black,
                          flushbarPosition: FlushbarPosition.TOP,
                        ).show(context);
                      },
                      style: TextButton.styleFrom(
                        primary: appMainColor,
                        backgroundColor: appWhite,
                      ),
                      child: Text(
                        "Jugar de forma anónima",
                        style: TextStyle(fontSize: 16),
                      )),
                ),
                SizedBox(height: 20,),
                Text(
                  "Si desinstalas la app perderás el progreso del juego.\n"
                      "Puede haber varias personas con el mismo nombre.\n"
                      "No podrás cambiar tu nombre una vez elegido.\n"
                      "Puede tomarse la decisión de eliminar tu nombre de los servidores "
                      "en caso de ser ofensivo o contener lenguaje soez.\n"
                      "No publiques información personal.",
                  style: TextStyle(
                    fontSize: 12,
                    color: appGrey,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none,
                    fontFamily: 'RaleWay',
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )),
    );
  }
}
