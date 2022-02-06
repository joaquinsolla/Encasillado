import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flushbar/flushbar.dart';

import 'common_imagepaths.dart';
import 'common_variables.dart';
import 'common_methods.dart';
import 'common_colors.dart';
import 'main_view.dart';

AppBar myAppBarWithButtons(BuildContext context) {
  return AppBar(
    backgroundColor: appColor,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          banner_logo,
          scale: 9.5,
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
  return AppBar(
    backgroundColor: appColor,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          banner_logo,
          scale: 9.5,
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
    width: (deviceWidth / 6 - 10.0),
    height: (deviceWidth / 6 - 10.0),
    margin: const EdgeInsets.fromLTRB(2.0, 6.0, 2.0, 6.0),
    padding: const EdgeInsets.all(0.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: cellColor,
      border: Border.all(color: mySemiBlack, width: 0.0),
    ),
    child: Text(
      char,
      style: TextStyle(fontSize: 40.0, color: myBlack),
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

Container streak_counter() {
  String gif;
  if (darkMode) {
    gif = streak_gif_darkmode;
  } else {
    gif = streak_gif;
  }

  String streakCount = " x" + streak.toString();

  return Container(
    margin: EdgeInsets.fromLTRB(0.0,0.0,7.5,7.5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(child: Text("")),
        Container(
          padding: const EdgeInsets.fromLTRB(2.0,2.0,4.0,2.0),
          decoration: BoxDecoration(
            color: keyColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Image.asset(
                gif,
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
        )
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

class game_finished_page extends StatelessWidget {
  const game_finished_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    build_stats();

    String gameImage;
    String gameText;
    if (wonGame) {
      infoStats = wordOfTheDayString +
          " - Intentos: " +
          (currentRow + 1).toString() +
          "/6";
      gameImage = victory_image;
      gameText = "VICTORIA";
    } else {
      infoStats = wordOfTheDayString + " - Intentos: X/6";
      gameImage = defeat_image;
      gameText = "DERROTA";
    }

    String restartImage;
    if (darkMode) {
      restartImage = restart_icon_darkmode;
    } else {
      restartImage = restart_icon;
    }

    return Scaffold(
        backgroundColor: myWhite,
        appBar: myAppBarWithoutButtons(context),
        body: Container(
          margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
          alignment: Alignment.topCenter,
          child: ListView(
            children: [
              SizedBox(
                height: 15.0,
              ),
              SizedBox(
                height: 90,
                child: Image.asset(gameImage),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                gameText,
                style: TextStyle(
                  fontSize: 30,
                  color: myBlack,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Estadísticas:",
                  style: TextStyle(
                    fontSize: 17,
                    color: myBlack,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontFamily: 'RaleWay',
                  ),
                ),
              ),
              SizedBox(
                height: 7.5,
              ),
              Text(
                infoStats,
                style: TextStyle(
                  fontSize: 16,
                  color: myBlack,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                emojiStats + "\nTiempo: " + game_duration_to_string(),
                style: TextStyle(
                  fontSize: 16,
                  color: myBlack,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "¿No sabes el significado de la palabra?",
                  style: TextStyle(
                    fontSize: 17,
                    color: myBlack,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontFamily: 'RaleWay',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TextButton(
                    onPressed: () {
                      url_launcher(definitionURL);
                    },
                    style: TextButton.styleFrom(
                      primary: myWhite,
                      backgroundColor: appColor,
                    ),
                    child: Text("Definición de " + wordOfTheDayString)),
              ]),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Empieza una partida nueva:",
                  style: TextStyle(
                    fontSize: 17,
                    color: myBlack,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontFamily: 'RaleWay',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TextButton(
                    onPressed: () {
                      restart_game_variables();
                      generate_new_word();
                      startDate = DateTime.now();
                      Navigator.pop(context);
                      runApp(JoadleApp());
                    },
                    style: TextButton.styleFrom(
                      primary: myWhite,
                      backgroundColor: appColor,
                    ),
                    child: Row(
                      children: [
                        Text("Nueva partida"),
                        SizedBox(
                          width: 6,
                        ),
                        Image.asset(
                          restartImage,
                          scale: 1.3,
                        ),
                      ],
                    )),
              ]),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "¡Compártelo con tus amigos!",
                  style: TextStyle(
                    fontSize: 17,
                    color: myBlack,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontFamily: 'RaleWay',
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RawMaterialButton(
                    onPressed: () {
                      copy_to_clipboard(context);
                    },
                    elevation: 1,
                    child: Image.asset(clipboard_icon),
                    //Lienzo: 300px , img: 40px
                    fillColor: myGrey,
                    shape: CircleBorder(),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      whatsapp_share();
                    },
                    elevation: 1,
                    child: Image.asset(whatsapp_icon),
                    //Lienzo: 280px , img: 40px
                    fillColor: wppColor,
                    shape: CircleBorder(),
                  ),
                ],
              ),
              Expanded(child: Text("")),
              Text(
                "Gracias por jugar a Joadle\n\nJoadle by joa",
                style: TextStyle(
                  fontSize: 12,
                  color: myGrey,
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

class explanation_page extends StatelessWidget {
  const explanation_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    build_stats();
    infoStats = wordOfTheDayString +
        " - Intentos: " +
        (currentRow + 1).toString() +
        "/6";

    String ex_green;
    String ex_yellow;
    String ex_grey;
    if (colorBlind) {
      ex_green = example_green_colorblind;
      ex_yellow = example_yellow_colorblind;
      ex_grey = example_grey_colorblind;
    } else {
      ex_green = example_green;
      ex_yellow = example_yellow;
      ex_grey = example_grey;
    }

    return Scaffold(
        backgroundColor: myWhite,
        appBar: myAppBarWithoutButtons(context),
        body: Container(
          margin: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
          alignment: Alignment.topCenter,
          child: ListView(
            children: [
              SizedBox(
                height: 5,
              ),
              Text(
                "¿Cómo jugar?",
                style: TextStyle(
                  fontSize: 25,
                  color: myBlack,
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
                "Tienes 6 intentos para adivinar la palabra oculta, que está compuesta por 5 letras.\n\n"
                "Las palabras que pruebes deben estar en el diccionario.\n\n"
                "Cada vez que pruebes una palabra las casillas cambiarán de color para indicar tu progreso:\n",
                style: TextStyle(
                  fontSize: 16,
                  color: myBlack,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.left,
              ),
              Container(
                height: 40,
                child: Image.asset(ex_green),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "La letra A está en la palabra oculta y va en esa posición\n",
                style: TextStyle(
                  fontSize: 16,
                  color: myBlack,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 40,
                child: Image.asset(ex_yellow),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "La letra E está en la palabra oculta pero no va en esa posición\n",
                style: TextStyle(
                  fontSize: 16,
                  color: myBlack,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 40,
                child: Image.asset(ex_grey),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "La letra T no está en la palabra oculta\n",
                style: TextStyle(
                  fontSize: 16,
                  color: myBlack,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.left,
              ),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(child: Text("")),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          primary: myWhite,
                          backgroundColor: appColor,
                        ),
                        child: Text("VAMOS ALLÁ")),
                    Expanded(child: Text("")),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class settings_page extends StatelessWidget {
  const settings_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String githubImage;
    if (darkMode)
      githubImage = github_image_darkmode;
    else
      githubImage = github_image;

    return Scaffold(
        backgroundColor: myWhite,
        appBar: myAppBarWithoutButtons(context),
        body: Container(
            margin: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Text(
                  "Ajustes",
                  style: TextStyle(
                    fontSize: 30,
                    color: myBlack,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontFamily: 'RaleWay',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //DALTONISMO
                    Text(
                      "Filtro para daltonismo:",
                      style: TextStyle(
                        fontSize: 16,
                        color: myBlack,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none,
                        fontFamily: 'RaleWay',
                      ),
                    ),
                    Expanded(child: Text("")),
                    Switch(
                      value: colorBlind,
                      onChanged: (value) {
                        colorBlind = (!colorBlind);
                        runApp(JoadleApp());
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),

                //MODO OSCURO
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //DALTONISMO
                    Text(
                      "Modo oscuro:",
                      style: TextStyle(
                        fontSize: 16,
                        color: myBlack,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none,
                        fontFamily: 'RaleWay',
                      ),
                    ),
                    Expanded(child: Text("")),
                    Switch(
                      value: darkMode,
                      onChanged: (value) {
                        darkMode = (!darkMode);
                        runApp(JoadleApp());
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Expanded(child: Text("")),
                Divider(
                  color: myGrey,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "\nSoy Joaquín, estudiante de ingeniería informática. "
                      "Espero que disfrutes mi app tanto como yo he disfrutado hacerla."
                      "\n\nPuedes encontrarme en:\n",
                      style: TextStyle(
                        fontSize: 12,
                        color: myGrey,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                        fontFamily: 'RaleWay',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    //INSTAGRAM BUTTON
                    TextButton(
                      onPressed: () {
                        url_launcher(myInstagramURL);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            instagram_image,
                            scale: 19.5,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Instagram",
                            style: TextStyle(
                              fontSize: 14,
                              color: myGrey,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.none,
                              fontFamily: 'RaleWay',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 5,
                    ),
                    //GITHUB BUTTON
                    TextButton(
                      onPressed: () {
                        url_launcher(myGitHubURL);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            githubImage,
                            scale: 13.5,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "GitHub",
                            style: TextStyle(
                              fontSize: 14,
                              color: myGrey,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.none,
                              fontFamily: 'RaleWay',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: myGrey,
                    ),
                    Text(
                      "\nAdaptación para Android en español de",
                      style: TextStyle(
                        fontSize: 12,
                        color: myGrey,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                        fontFamily: 'RaleWay',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 60,
                          child: TextButton(
                            onPressed: () {
                              url_launcher(officialWordleURL);
                            },
                            style: TextButton.styleFrom(
                              primary: myGrey,
                            ),
                            child: Text("Wordle"),
                          ),
                        ),
                        Text(
                          "de",
                          style: TextStyle(
                            fontSize: 12,
                            color: myGrey,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                            fontFamily: 'RaleWay',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          width: 100,
                          child: TextButton(
                            onPressed: () {
                              url_launcher(joshWardleURL);
                            },
                            style: TextButton.styleFrom(
                              primary: myGrey,
                            ),
                            child: Text("Josh Wardle"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(
                  height: 20,
                ),
              ],
            )));
  }
}
