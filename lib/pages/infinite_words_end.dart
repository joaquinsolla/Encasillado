import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:Encasillado/common/imagepaths.dart';
import 'package:Encasillado/common/methods.dart';
import 'package:Encasillado/common/urls.dart';
import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/widgets.dart';
import 'package:Encasillado/common/colors.dart';
import 'package:Encasillado/ad_helper.dart';

class InfiniteWordsEnd extends StatefulWidget {
  @override
  _InfiniteWordsEndState createState() => _InfiniteWordsEndState();
}

class _InfiniteWordsEndState extends State<InfiniteWordsEnd> {
  // ADMOB MANAGEMENT
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  @override
  void initState() {
    if (showAds) {
      _initGoogleMobileAds();
      _bannerAd = BannerAd(
        adUnitId: AdHelper.bannerAdUnitId,
        request: AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          onAdLoaded: (_) {
            setState(() {
              _isBannerAdReady = true;
            });
          },
          onAdFailedToLoad: (ad, err) {
            if(terminalPrinting) print("[ERR] Failed to load a banner ad on "
                "'infinite_words_end.dart': ${err.message}");
            _isBannerAdReady = false;
            ad.dispose();
          },
        ),
      );

      _bannerAd.load();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    infinite_emoji_stats_builder();

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

    return Scaffold(
        appBar: myAppBarWithoutButtonsWithBackArrow(context),
        backgroundColor: appWhite,
        body: Container(
          margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
          alignment: Alignment.topCenter,
          child: Column(children: [
            Expanded(
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
                        infinite_game_duration_string(),
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
                          newInfiniteGame = true;
                          Navigator.pushNamed(context, '/home');
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
                            Icon(Icons.restart_alt_rounded, color: appWhite,),
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
                              infinite_game_duration_string());
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
                          share_whatsapp(infoStatsInfinite, emojiStatsInfinite,
                              infinite_game_duration_string());
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
                          share_twitter(infoStatsInfinite, emojiStatsInfinite,
                              infinite_game_duration_string());
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
                          share_telegram(infoStatsInfinite, emojiStatsInfinite,
                              infinite_game_duration_string());
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
                          share_others(infoStatsInfinite, emojiStatsInfinite,
                              infinite_game_duration_string());
                        },
                        elevation: 1,
                        child: Icon(Icons.more_horiz_rounded, color: Colors.white,),
                        fillColor: othersColor,
                        shape: CircleBorder(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "\nGracias por jugar a Encasillado v$appVersion",
                    style: TextStyle(
                      fontSize: 12,
                      color: appGrey,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                      fontFamily: 'RaleWay',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ),
            //if (_isBannerAdReady)SizedBox(height: 5,),
            //if (_isBannerAdReady) smallText('ADVERTISING'),
            if (_isBannerAdReady) Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: _bannerAd.size.width.toDouble(),
                  height: _bannerAd.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd),
                ),
              ),
          ]),
        ));
  }

  // STATS MANAGEMENT

  void infinite_emoji_stats_builder() {
    bool lineUsed = false;
    emojiStatsInfinite = "";
    for (var i = 0; i < colorsArrayInfinite.length; i += 5) {
      lineUsed = false;
      for (var j = i; j < i + 5; j++) {
        if (colorsArrayInfinite[j] == "V") {
          emojiStatsInfinite += greenEmoji;
          lineUsed = true;
        }
        if (colorsArrayInfinite[j] == "A") {
          emojiStatsInfinite += yellowEmoji;
          lineUsed = true;
        }
        if (colorsArrayInfinite[j] == "G") {
          emojiStatsInfinite += whiteEmoji;
          lineUsed = true;
        }
      }
      if (lineUsed) emojiStatsInfinite += "\n";
    }
  }

  String infinite_game_duration_string() {
    int hours;
    int minutes;
    int seconds;

    hours = playSecondsInfinite.inHours;
    minutes = playSecondsInfinite.inMinutes - hours * 60;
    seconds = playSecondsInfinite.inSeconds - hours * 60 * 60 - minutes * 60;

    String h = hours.toString().padLeft(2, '0');
    String m = minutes.toString().padLeft(2, '0');
    String s = seconds.toString().padLeft(2, '0');

    return (h + ":" + m + ":" + s);
  }

}
