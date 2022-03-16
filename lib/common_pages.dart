import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'common/imagepaths.dart';
import 'common/miscellaneous.dart';
import 'common/widgets.dart';
import 'common/methods.dart';
import 'common/colors.dart';
import 'common/urls.dart';
import 'main_view.dart';

class wotd_finished_page extends StatelessWidget {
  const wotd_finished_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    build_stats_wotd();

    String gameImage;
    String gameText;
    String today = DateTime.now().day.toString() +
        "/" +
        DateTime.now().month.toString() +
        "/" +
        DateTime.now().year.toString().substring(2, 4);

    if (wonGameWotd) {
      infoStatsWotd = "Encasillado del " +
          today +
          "\nIntentos: " +
          (currentRowWotd + 1).toString() +
          "/6";
      gameImage = victoryImg;
      gameText = "VICTORIA";
    } else {
      infoStatsWotd = "Encasillado del " + today + "\nIntentos: X/6";
      gameImage = defeatImg;
      gameText = "DERROTA";
    }

    return Scaffold(
        backgroundColor: appWhite,
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
              Text(
                gameText,
                style: TextStyle(
                  fontSize: 30,
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
              SizedBox(
                height: 100,
                child: Image.asset(gameImage),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Estadísticas:",
                  style: TextStyle(
                    fontSize: 17,
                    color: appBlack,
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
                infoStatsWotd,
                style: TextStyle(
                  fontSize: 16,
                  color: appBlack,
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
                emojiStatsWotd + "\nTiempo: " + game_duration_to_string_wotd(),
                style: TextStyle(
                  fontSize: 16,
                  color: appBlack,
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
                  "La palabra oculta de hoy: " + wotdString,
                  style: TextStyle(
                    fontSize: 17,
                    color: appBlack,
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
                      url_launcher(wotdDefinitionURL);
                    },
                    style: TextButton.styleFrom(
                      primary: appWhite,
                      backgroundColor: appMainColor,
                    ),
                    child: Text("Definición de " + wotdString)),
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
                    color: appBlack,
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
                      copy_to_clipboard(context, infoStatsWotd, emojiStatsWotd,
                          game_duration_to_string_wotd());
                    },
                    elevation: 1,
                    child: Image.asset(
                      clipboardImg,
                      scale: 22.5,
                    ),
                    fillColor: appGrey,
                    shape: CircleBorder(),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      whatsapp_share(infoStatsWotd, emojiStatsWotd,
                          game_duration_to_string_wotd());
                    },
                    elevation: 1,
                    child: Image.asset(
                      whatsappImg,
                      scale: 60,
                    ),
                    fillColor: wppColor,
                    shape: CircleBorder(),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      twitter_share(infoStatsWotd, emojiStatsWotd,
                          game_duration_to_string_wotd());
                    },
                    elevation: 1,
                    child: Image.asset(
                      twitterImg,
                      scale: 47,
                    ),
                    fillColor: twitterColor,
                    shape: CircleBorder(),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RawMaterialButton(
                    onPressed: () {
                      telegram_share(infoStatsWotd, emojiStatsWotd,
                          game_duration_to_string_wotd());
                    },
                    elevation: 1,
                    child: Image.asset(
                      telegramImg,
                      scale: 50,
                    ),
                    fillColor: telegramColor,
                    shape: CircleBorder(),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      others_share(infoStatsWotd, emojiStatsWotd,
                          game_duration_to_string_wotd());
                    },
                    elevation: 1,
                    child: Image.asset(
                      otherShareImg,
                      scale: 45,
                    ),
                    fillColor: othersColor,
                    shape: CircleBorder(),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
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

class infinite_finished_page extends StatelessWidget {
  const infinite_finished_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    build_stats_infinite();

    String gameImage;
    String gameText;
    if (wonGameInfinite) {
      infoStatsInfinite = infiniteString +
          " - Intentos: " +
          (currentRowInfinite + 1).toString() +
          "/6";
      gameImage = victoryImg;
      gameText = "VICTORIA";
    } else {
      infoStatsInfinite = infiniteString + " - Intentos: X/6";
      gameImage = defeatImg;
      gameText = "DERROTA";
    }

    String restartImage;
    if (darkMode) {
      restartImage = restartImgDarkmode;
    } else {
      restartImage = restartImgLightmode;
    }

    return Scaffold(
        backgroundColor: appWhite,
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
              Text(
                gameText,
                style: TextStyle(
                  fontSize: 30,
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
              SizedBox(
                height: 100,
                child: Image.asset(gameImage),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Estadísticas:",
                  style: TextStyle(
                    fontSize: 17,
                    color: appBlack,
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
                infoStatsInfinite,
                style: TextStyle(
                  fontSize: 16,
                  color: appBlack,
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
                emojiStatsInfinite +
                    "\nTiempo: " +
                    game_duration_to_string_infinite(),
                style: TextStyle(
                  fontSize: 16,
                  color: appBlack,
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
                    color: appBlack,
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
                      url_launcher(infiniteDefinitionURL);
                    },
                    style: TextButton.styleFrom(
                      primary: appWhite,
                      backgroundColor: appMainColor,
                    ),
                    child: Text("Definición de " + infiniteString)),
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
                    color: appBlack,
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
                      restart_infinite_game_variables();
                      generate_infinite_word();
                      startDateInfinite = DateTime.now();
                      Navigator.pop(context);
                      runApp(EncasilladoApp());
                    },
                    style: TextButton.styleFrom(
                      primary: appWhite,
                      backgroundColor: appMainColor,
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
                    color: appBlack,
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
                      copy_to_clipboard(
                          context,
                          infoStatsInfinite,
                          emojiStatsInfinite,
                          game_duration_to_string_infinite());
                    },
                    elevation: 1,
                    child: Image.asset(
                      clipboardImg,
                      scale: 22.5,
                    ),
                    fillColor: appGrey,
                    shape: CircleBorder(),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      whatsapp_share(infoStatsInfinite, emojiStatsInfinite,
                          game_duration_to_string_infinite());
                    },
                    elevation: 1,
                    child: Image.asset(
                      whatsappImg,
                      scale: 60,
                    ),
                    fillColor: wppColor,
                    shape: CircleBorder(),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      twitter_share(infoStatsInfinite, emojiStatsInfinite,
                          game_duration_to_string_infinite());
                    },
                    elevation: 1,
                    child: Image.asset(
                      twitterImg,
                      scale: 47,
                    ),
                    fillColor: twitterColor,
                    shape: CircleBorder(),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RawMaterialButton(
                    onPressed: () {
                      telegram_share(infoStatsInfinite, emojiStatsInfinite,
                          game_duration_to_string_infinite());
                    },
                    elevation: 1,
                    child: Image.asset(
                      telegramImg,
                      scale: 50,
                    ),
                    fillColor: telegramColor,
                    shape: CircleBorder(),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      others_share(infoStatsInfinite, emojiStatsInfinite,
                          game_duration_to_string_infinite());
                    },
                    elevation: 1,
                    child: Image.asset(
                      otherShareImg,
                      scale: 45,
                    ),
                    fillColor: othersColor,
                    shape: CircleBorder(),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
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

class explanation_page extends StatelessWidget {
  const explanation_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String ex_green;
    String ex_yellow;
    String ex_grey;
    if (colorBlind) {
      ex_green = exampleGreenColorblindImg;
      ex_yellow = exampleYellowColorblindImg;
      ex_grey = exampleGreyColorblindImg;
    } else {
      ex_green = exampleGreenImg;
      ex_yellow = exampleYellowImg;
      ex_grey = exampleGreyImg;
    }

    return Scaffold(
        backgroundColor: appWhite,
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
                "Tienes 6 intentos para adivinar la palabra oculta, que está compuesta por 5 letras.\n\n"
                "Las palabras que pruebes deben estar en el diccionario.\n\n"
                "Cada vez que pruebes una palabra las casillas cambiarán de color para indicar tu progreso:\n",
                style: TextStyle(
                  fontSize: 16,
                  color: appBlack,
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
                  color: appBlack,
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
                  color: appBlack,
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
                  color: appBlack,
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
                          primary: appWhite,
                          backgroundColor: appMainColor,
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
    late String myGithubImage;
    if (darkMode) {
      myGithubImage = githubImgDarkmode;
    } else {
      myGithubImage = githubImgLightmode;
    }

    return Scaffold(
        backgroundColor: appWhite,
        appBar: myAppBarWithoutButtons(context),
        body: Container(
            margin: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
            alignment: Alignment.topCenter,
            child: ListView(
              addAutomaticKeepAlives: true,
              children: [
                headerText('Ajustes'),
                SizedBox(
                  height: 15,
                ),
                settingsRow(
                  'Filtro para daltonismo:',
                  Switch(
                  value: colorBlind,
                  onChanged: (value) {
                    colorBlind = (!colorBlind);
                    runApp(EncasilladoApp());
                    Navigator.pop(context);
                  },
                ),),
                settingsRow(
                  'Modo oscuro:',
                  Switch(
                    value: darkMode,
                    onChanged: (value) {
                      darkMode = (!darkMode);
                      runApp(EncasilladoApp());
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  color: appGrey,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    smallText(
                        '\nSoy Joaquín, estudiante de ingeniería informática. '
                        'Espero que disfrutes mi app tanto como yo he disfrutado hacerla.'
                        '\n\nPuedes encontrarme en:\n'),
                    socialsButton(
                        myInstagramUrl, instagramImg, 19.5, 'Instagram'),
                    SizedBox(
                      height: 5,
                    ),
                    socialsButton(myGitHubUrl, myGithubImage, 13.5, 'GitHub'),
                    SizedBox(
                      height: 5,
                    ),
                    socialsButton(
                        myWebsiteUrl, myWebsiteImg, 13.5, 'Mi página web'),
                    SizedBox(
                      height: 5,
                    ),
                    socialsButton(
                        myPlayStoreDevUrl, playStoreImg, 32.5, 'Play Store'),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: appGrey,
                    ),
                    smallText('\nApp basada en el juego original '),
                    Container(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 60,
                            child: TextButton(
                              onPressed: () {
                                url_launcher(wordleUrl);
                              },
                              style: TextButton.styleFrom(
                                primary: appGrey,
                              ),
                              child: Text("Wordle"),
                            ),
                          ),
                          smallText("de"),
                          SizedBox(
                            width: 100,
                            child: TextButton(
                              onPressed: () {
                                url_launcher(joshWardleUrl);
                              },
                              style: TextButton.styleFrom(
                                primary: appGrey,
                              ),
                              child: Text("Josh Wardle"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: appGrey,
                    ),
                    smallText(
                        '\nPuedes contactarme para reportar errores o comunicar sugerencias:'),
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
                                primary: appGrey,
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
                                url_launcher(privacyPolicyUrl);
                              },
                              style: TextButton.styleFrom(
                                primary: appGrey,
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

class points_page extends StatelessWidget {
  const points_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appWhite,
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

class streak_page extends StatelessWidget {
  const streak_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String myStreakGif;
    if (darkMode) {
      myStreakGif = streakGifDarkmode;
    } else {
      myStreakGif = streakGifLightmode;
    }

    return Scaffold(
        backgroundColor: appWhite,
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

class update_version_page extends StatelessWidget {
  const update_version_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appWhite,
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
