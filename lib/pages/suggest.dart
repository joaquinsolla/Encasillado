import 'package:Encasillado/common/methods.dart';
import 'package:Encasillado/common/miscellaneous.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:Encasillado/common/widgets.dart';
import 'package:Encasillado/common/colors.dart';

class Suggest extends StatefulWidget {
  @override
  _SuggestState createState() => _SuggestState();
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class _SuggestState extends State<Suggest> {
  final addController = TextEditingController();
  final removeController = TextEditingController();
  bool? anonymous = false;

  @override
  void dispose() {
    addController.dispose();
    removeController.dispose();
    super.dispose();
  }

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
        appBar: myAppBarWithoutButtonsWithBackArrow(context),
        backgroundColor: appWhite,
        body: ScrollConfiguration(
            behavior: listViewBehaviour(),
            child:
                myScrollbar(ListView(addAutomaticKeepAlives: true, children: [
              Container(
                  margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Sugerir palabras",
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
                        "Palabras registradas: " +
                            (selectedDatabase.length).toString(),
                        style: TextStyle(
                          fontSize: 15,
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
                        "Sugiere palabras que se deban añadir o eliminar del juego.\n"
                        "Todas las palabras deben ser de 5 letras y sin tildes.\n"
                        "Las palabras deben existir en el diccionario de la RAE y deben "
                            "pertenecer al castellano.\n"
                        "Recuerda que no se aceptan verbos conjugados ni plurales.\n"
                        "Sí se admiten femeninos y nombres propios.",
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
                        height: 15,
                      ),
                      Theme(
                        data: ThemeData(unselectedWidgetColor: appBlack),
                        child: CheckboxListTile(
                          title: Wrap(
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(
                                Icons.security_rounded,
                                color: appBlack,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Enviar de forma anónima",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: appBlack,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'RaleWay',
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          value: anonymous,
                          onChanged: (newValue) {
                            setState(() {
                              anonymous = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: appMainColor,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.check_rounded, color: appBlack,),
                          Text(
                            " Añadir palabras",
                            style: TextStyle(
                              fontSize: 15,
                              color: appBlack,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                              fontFamily: 'RaleWay',
                            ),
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(flex: 3,
                          child: TextField(
                            inputFormatters: [
                              UpperCaseTextFormatter(),
                            ],
                            maxLength: 5,
                            style: TextStyle(color: appBlack),
                            controller: addController,
                            decoration: InputDecoration(
                              counter: Offstage(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: appBlack, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: appMainColor, width: 1),
                              ),

                              hintText: 'Añadir...',
                              hintStyle: TextStyle(color: appBlack),
                            ),
                          ),),
                          SizedBox(width: 10,),
                          Expanded(flex: 1,
                            child: TextButton(
                              onPressed: () {
                                if ((addController.text).length == 5) {
                                  bool alreadySent = false;
                                  for (var i = 0;
                                  i < suggestedWords.length;
                                  i++) {
                                    if (addController.text ==
                                        suggestedWords[i]) alreadySent = true;
                                  }

                                  if (alreadySent) {
                                    Flushbar(
                                      message: "Ya has sugerido esta palabra",
                                      duration: Duration(seconds: 3),
                                      backgroundColor: Colors.red,
                                      flushbarPosition: FlushbarPosition.TOP,
                                    ).show(context);
                                  } else {
                                    bool alreadyExists = false;
                                    for (var i = 0; i < selectedDatabase.length; i++) {
                                      if (selectedDatabase[i] == addController.text){
                                        alreadyExists = true;
                                        break;
                                      }
                                    }

                                    if (alreadyExists){
                                      Flushbar(
                                        message:
                                        "Esta palabra ya figura en el juego",
                                        duration: Duration(seconds: 3),
                                        backgroundColor: Colors.redAccent,
                                        flushbarPosition: FlushbarPosition.TOP,
                                      ).show(context);
                                    }
                                    else sendSuggestedAdd(addController.text, anonymous!, context);
                                  }
                                  FocusManager.instance.primaryFocus
                                      ?.unfocus();
                                  addController.text = '';
                                }
                                else Flushbar(
                                  message:
                                  "La palabra debe ser de 5 letras",
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Colors.redAccent,
                                  flushbarPosition: FlushbarPosition.TOP,
                                ).show(context);
                              },
                              style: TextButton.styleFrom(
                                primary: appWhite,
                                backgroundColor: appMainColor,
                              ),
                              child: Text("ENVIAR"))),
                        ],
                      ),

                      SizedBox(
                        height: 30,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.close_rounded, color: appBlack,),
                          Text(
                            " Eliminar palabras",
                            style: TextStyle(
                              fontSize: 15,
                              color: appBlack,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                              fontFamily: 'RaleWay',
                            ),
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(flex: 3,
                            child: TextField(
                              inputFormatters: [
                                UpperCaseTextFormatter(),
                              ],
                              maxLength: 5,
                              style: TextStyle(color: appBlack),
                              controller: removeController,
                              decoration: InputDecoration(
                                counter: Offstage(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: appBlack, width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.redAccent, width: 1),
                                ),

                                hintText: 'Eliminar...',
                                hintStyle: TextStyle(color: appBlack),
                              ),
                            ),),
                          SizedBox(width: 10,),
                          Expanded(flex: 1,
                              child: TextButton(
                                  onPressed: () {
                                    if ((removeController.text).length == 5) {
                                      bool alreadySent = false;
                                      for (var i = 0;
                                      i < suggestedWords.length;
                                      i++) {
                                        if (removeController.text ==
                                            suggestedWords[i]) alreadySent = true;
                                      }

                                      if (alreadySent) {
                                        Flushbar(
                                          message: "Ya has sugerido esta palabra",
                                          duration: Duration(seconds: 3),
                                          backgroundColor: Colors.red,
                                          flushbarPosition: FlushbarPosition.TOP,
                                        ).show(context);
                                      } else {
                                        bool doesntExist = true;
                                        for (var i = 0; i < selectedDatabase.length; i++) {
                                          if (selectedDatabase[i] == removeController.text){
                                            doesntExist = false;
                                            break;
                                          }
                                        }

                                        if (doesntExist){
                                          Flushbar(
                                            message:
                                            "Esta palabra no está en el juego",
                                            duration: Duration(seconds: 3),
                                            backgroundColor: Colors.redAccent,
                                            flushbarPosition: FlushbarPosition.TOP,
                                          ).show(context);
                                        }
                                        else sendSuggestedRemove(removeController.text, anonymous!, context);
                                      }
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      removeController.text = '';
                                    }
                                    else Flushbar(
                                      message:
                                      "La palabra debe ser de 5 letras",
                                      duration: Duration(seconds: 3),
                                      backgroundColor: Colors.redAccent,
                                      flushbarPosition: FlushbarPosition.TOP,
                                    ).show(context);
                                  },
                                  style: TextButton.styleFrom(
                                    primary: appWhite,
                                    backgroundColor: Colors.redAccent,
                                  ),
                                  child: Text("ENVIAR"))),
                        ],
                      ),

                    ],
                  )),
            ]))));
  }
}
