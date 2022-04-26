import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/widgets.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:Encasillado/common/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateUserName extends StatefulWidget {
  @override
  _UpdateUserNameState createState() => _UpdateUserNameState();
}

class _UpdateUserNameState extends State<UpdateUserName> {
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
      final key = 'username';
      prefs.setString(key, userName!);
      if (terminalPrinting) print('[SYS] Saved $userName on username');
    }

    return Scaffold(
      appBar: myAppBarWithoutButtonsAndBackArrow(context),
      backgroundColor: appWhite,
      body: Center(
        child: ScrollConfiguration(
            behavior: listViewBehaviour(),
            child: ListView(
              shrinkWrap: true,
              addAutomaticKeepAlives: true,
              children: [
                Container(
                    margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                    alignment: Alignment.topCenter,
                    child: Column(
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
                            "Actualiza tu nombre de jugador",
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
                              "Puede haber varias personas con el mismo nombre.\n"
                              "Puede tomarse la decisión de eliminar tu nombre de los servidores "
                              "en caso de ser ofensivo o contener lenguaje soez.\n"
                              "No publiques información personal."),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: TextField(
                            maxLength: 15,
                            style: TextStyle(color: appBlack),
                            controller: userNameController,
                            decoration: InputDecoration(
                              counterStyle: TextStyle(color: appBlack),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: appBlack, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: appMainColor, width: 1),
                              ),
                              labelText: 'Tu nombre de jugador',
                              labelStyle: TextStyle(color: appMainColor),
                              hintText: '',
                              hintStyle: TextStyle(color: appBlack),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: TextButton.styleFrom(
                                    primary: appWhite,
                                    backgroundColor: appGrey,
                                  ),
                                  child: Text(
                                    "Cancelar",
                                    style: TextStyle(fontSize: 16),
                                  )),
                              SizedBox(
                                width: 20,
                              ),
                              TextButton(
                                  onPressed: () {
                                    if (userNameController.text.length > 0) {
                                      if (userNameController.text == userName) {
                                        Flushbar(
                                          message: "Ya tienes este nombre",
                                          duration: Duration(seconds: 3),
                                          backgroundColor: Colors.red,
                                          flushbarPosition:
                                              FlushbarPosition.TOP,
                                        ).show(context);
                                      } else {
                                        setState(() {
                                          userName = userNameController.text;
                                        });
                                        _save_user();

                                        CollectionReference users =
                                            FirebaseFirestore.instance
                                                .collection('users');

                                        users.doc(userId).update(
                                            {'name': userName}).then((value) {
                                          if (terminalPrinting)
                                            print(
                                                "[SYS] name updated: $userName");
                                        }).catchError((error) {
                                          if (terminalPrinting)
                                            print(
                                                "[ERR] Failed to update name");
                                        }).then((value) {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          Navigator.pushNamed(
                                              context, '/settings');
                                          Flushbar(
                                            message:
                                                "¡Nombre cambiado a $userName!",
                                            duration: Duration(seconds: 3),
                                            backgroundColor: Colors.orange,
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                          ).show(context);
                                        }).timeout(Duration(seconds: 5),
                                            onTimeout: () {
                                          Flushbar(
                                            message:
                                                "Revisa tu conexión a Internet e inténtalo de nuevo",
                                            duration: Duration(seconds: 3),
                                            backgroundColor: Colors.red,
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                          ).show(context);
                                          if (terminalPrinting)
                                            print(
                                                "[ERR] Failed to save name: Timeout");
                                        }).catchError((error) {
                                          Flushbar(
                                            message:
                                                "Algo ha fallado, inténtalo más tarde",
                                            duration: Duration(seconds: 3),
                                            backgroundColor: Colors.red,
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                          ).show(context);
                                          if (terminalPrinting)
                                            print(
                                                "[ERR] Failed to save name: $error");
                                        });
                                      }
                                    } else {
                                      Flushbar(
                                        message: "Debes introducir un nombre",
                                        duration: Duration(seconds: 3),
                                        backgroundColor: Colors.red,
                                        flushbarPosition: FlushbarPosition.TOP,
                                      ).show(context);
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                    primary: appWhite,
                                    backgroundColor: appMainColor,
                                  ),
                                  child: Text(
                                    "Guardar nombre",
                                    style: TextStyle(fontSize: 16),
                                  )),
                            ]),
                        SizedBox(
                          height: 56,
                        ),
                      ],
                    )),
              ],
            )),
      ),
    );
  }
}
