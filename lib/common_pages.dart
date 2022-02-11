import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'common_imagepaths.dart';
import 'common_variables.dart';
import 'common_widgets.dart';
import 'common_methods.dart';
import 'common_colors.dart';
import 'common_urls.dart';
import 'main_view.dart';


class word_of_the_day_finished_page extends StatelessWidget {
  const word_of_the_day_finished_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    build_stats();

    String gameImage;
    String gameText;
    String today = DateTime.now().day.toString() +
        "/" +
        DateTime.now().month.toString() +
        "/" +
        DateTime.now().year.toString().substring(2,4);

    if (wonGame) {
      infoStats = "Palabra del " +
          today +
          "\nIntentos: " +
          (currentRow + 1).toString() +
          "/6";
      gameImage = victory_image;
      gameText = "VICTORIA";
    } else {
      infoStats = "Palabra del " + today + "\nIntentos: X/6";
      gameImage = defeat_image;
      gameText = "DERROTA";
    }

    return Scaffold(
        backgroundColor: myWhite,
        appBar: myAppBarWithoutButtons(context),
        body: Container(
          margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
          alignment: Alignment.topCenter,
          child: ListView(
            addAutomaticKeepAlives: true,
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
                  "La palabra oculta de hoy: " + wordOfTheDayString,
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
                      url_launcher(wordOfTheDayDefinitionURL);
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
              SizedBox(
                height: 30,
              ),
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

class palabras_infinitas_finished_page extends StatelessWidget {
  const palabras_infinitas_finished_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    build_stats();

    String gameImage;
    String gameText;
    if (wonGame) {
      infoStats = standardWordString +
          " - Intentos: " +
          (currentRow + 1).toString() +
          "/6";
      gameImage = victory_image;
      gameText = "VICTORIA";
    } else {
      infoStats = standardWordString + " - Intentos: X/6";
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
            addAutomaticKeepAlives: true,
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
                      url_launcher(standardDefinitionURL);
                    },
                    style: TextButton.styleFrom(
                      primary: myWhite,
                      backgroundColor: appColor,
                    ),
                    child: Text("Definición de " + standardWordString)),
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
                      generate_standard_word();
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
              SizedBox(
                height: 30,
              ),
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
    infoStats = standardWordString +
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
            addAutomaticKeepAlives: true,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          primary: myWhite,
                          backgroundColor: appColor,
                        ),
                        child: Text("VAMOS ALLÁ")),
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
            child: ListView(
              addAutomaticKeepAlives: true,
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
                SizedBox(
                  height: deviceHeight * 0.15,
                ),
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
                    Container(
                      height: 40,
                      child: Row(
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
                    ),
                    Divider(
                      color: myGrey,
                    ),
                    Container(
                      height: 40,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                mail_to(myDevEmail);
                              },
                              style: TextButton.styleFrom(
                                primary: myGrey,
                              ),
                              child: Text(
                                "Contacto",
                                style: TextStyle(fontSize: 12.5),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            TextButton(
                              onPressed: () {
                                url_launcher(privacyPolicyURL);
                              },
                              style: TextButton.styleFrom(
                                primary: myGrey,
                              ),
                              child: Text(
                                "Política de privacidad",
                                style: TextStyle(fontSize: 12.5),
                              ),
                            ),
                          ]),
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

class updates_page extends StatelessWidget {
  const updates_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: myWhite,
        appBar: myAppBarWithoutButtons(context),
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
                "Versión 2.0.0 Beta:",
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
                "Nuevo menú y modos de juego",
                style: TextStyle(
                  fontSize: 16,
                  color: myBlack,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                "En esta versión de prueba se ha introducido un nuevo menú y el modo de juego 'La palabra del día'\n"
                    "El modo 'Contrarreloj' todavía está en desarrollo.\n",
                style: TextStyle(
                  fontSize: 15,
                  color: myBlack,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "En proceso:",
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
                "Actualmente se está trabajando para incorporar las siguientes funcionalidades al juego:\n",
                style: TextStyle(
                  fontSize: 16,
                  color: myBlack,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                "Más vías para compartir tus partidas",
                style: TextStyle(
                  fontSize: 16,
                  color: myBlack,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                "Se están preparando funcionalidades para compartir el resultado de tu partida vía Instagram Stories o Twitter.\n",
                style: TextStyle(
                  fontSize: 15,
                  color: myBlack,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                "Modos de juego",
                style: TextStyle(
                  fontSize: 16,
                  color: myBlack,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                "Se está estudiando la posibilidad de incorporar diferentes modos de juego.\n",
                style: TextStyle(
                  fontSize: 15,
                  color: myBlack,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10,
              ),
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




class word_of_the_day_explanation_page extends StatelessWidget {
  const word_of_the_day_explanation_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: myWhite,
        appBar: myAppBarWithoutButtons(context),
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
                "¡La palabra del día!",
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
                "Cada día una nueva palabra oculta.\n"
                    "¡La misma palabra para todos los jugadores!\n\n"
                    "Comparte tu resultado y compite con tus amigos por ver quién es el mejor cada día.",
                style: TextStyle(
                  fontSize: 15,
                  color: myBlack,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10,
              ),
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
