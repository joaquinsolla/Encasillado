import 'package:Encasillado/common/imagepaths.dart';
import 'package:Encasillado/common/methods.dart';
import 'package:Encasillado/common/urls.dart';
import 'package:flutter/material.dart';
import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/widgets.dart';
import 'package:Encasillado/common/colors.dart';

class WotdEnd extends StatefulWidget {
  @override
  _WotdEndState createState() => _WotdEndState();
}

class _WotdEndState extends State<WotdEnd> {

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
                    urlLauncher(wotdDefinitionURL);
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