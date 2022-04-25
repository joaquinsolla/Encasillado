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
  final wordController = TextEditingController();
  bool? anonymous = false;

  @override
  void dispose() {
    wordController.dispose();
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
      body: ListView(addAutomaticKeepAlives: true, children: [
            Container(
                margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Sugerir nuevas palabras",
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
                      "Sugiere palabras que falten en el juego.\n"
                      "Todas las palabras deben ser de 5 letras.\n"
                      "Las palabras deben existir en el diccionario de la lengua "
                      "española.\n"
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
                    TextField(
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      maxLength: 5,
                      style: TextStyle(color: appBlack),
                      controller: wordController,
                      decoration: InputDecoration(
                        counterStyle: TextStyle(color: appBlack),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: appBlack, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: appMainColor, width: 1),
                        ),
                        labelText: 'Palabra de 5 letras',
                        labelStyle: TextStyle(color: appMainColor),
                        hintText: 'Sugiere una palabra...',
                        hintStyle: TextStyle(color: appBlack),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                if ((wordController.text).length == 5) {
                                  bool alreadySent = false;
                                  for (var i = 0;
                                      i < suggestedWords.length;
                                      i++) {
                                    if (wordController.text ==
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
                                    sendSuggestedWord(wordController.text,
                                        anonymous!, context);
                                  }
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  wordController.text = '';
                                } else
                                  Flushbar(
                                    message: "La palabra debe ser de 5 letras",
                                    duration: Duration(seconds: 3),
                                    backgroundColor: Colors.redAccent,
                                    flushbarPosition: FlushbarPosition.TOP,
                                  ).show(context);
                              },
                              style: TextButton.styleFrom(
                                primary: appWhite,
                                backgroundColor: appMainColor,
                              ),
                              child: Text("ENVIAR PALABRA")),
                        ],
                      ),
                    ),
                  ],
                )),
          ]));
  }
}