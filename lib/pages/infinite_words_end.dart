import 'package:Encasillado/common/imagepaths.dart';
import 'package:Encasillado/common/methods.dart';
import 'package:Encasillado/common/urls.dart';
import 'package:flutter/material.dart';
import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/widgets.dart';
import 'package:Encasillado/common/colors.dart';

class InfiniteWordsEnd extends StatefulWidget {
  @override
  _InfiniteWordsEndState createState() => _InfiniteWordsEndState();
}

class _InfiniteWordsEndState extends State<InfiniteWordsEnd> {
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
      appBar: myAppBarWithoutButtons(context),
      backgroundColor: appWhite,
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
                    urlLauncher(infiniteDefinitionURL);
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
                    setState(() {
                      startDateInfinite = DateTime.now();
                    });
                    Navigator.popAndPushNamed(context, '/infinite_words');
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