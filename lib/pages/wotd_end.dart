import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/widgets.dart';
import 'package:Encasillado/common/colors.dart';
import 'package:Encasillado/ad_helper.dart';
import 'package:Encasillado/common/imagepaths.dart';
import 'package:Encasillado/common/methods.dart';
import 'package:Encasillado/common/urls.dart';

class WotdEnd extends StatefulWidget {
  @override
  _WotdEndState createState() => _WotdEndState();
}

class _WotdEndState extends State<WotdEnd> {
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
            if (terminalPrinting)
              print("[ERR] Failed to load a banner ad on "
                  "'wotd_end.dart': ${err.message}");
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

    wotd_emoji_stats_builder();

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
      appBar: myAppBarWithoutButtonsWithBackArrow(context),
      backgroundColor: appWhite,
      body: Column(children: [
        Expanded(
          child: ListView(
            addAutomaticKeepAlives: true,
            children: [
              Container(
                  margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
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
                        emojiStatsWotd +
                            "\nTiempo: " +
                            wotd_game_duration_string(),
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
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                              copy_to_clipboard(context, infoStatsWotd,
                                  emojiStatsWotd, wotd_game_duration_string());
                            },
                            elevation: 1,
                            child: Icon(
                              Icons.copy_rounded,
                              color: Colors.white,
                            ),
                            fillColor: appGrey,
                            shape: CircleBorder(),
                          ),
                          RawMaterialButton(
                            onPressed: () {
                              share_whatsapp(infoStatsWotd, emojiStatsWotd,
                                  wotd_game_duration_string());
                            },
                            elevation: 1,
                            child: Icon(Icons.whatsapp_rounded,
                                color: Colors.white),
                            fillColor: wppColor,
                            shape: CircleBorder(),
                          ),
                          RawMaterialButton(
                            onPressed: () {
                              share_twitter(infoStatsWotd, emojiStatsWotd,
                                  wotd_game_duration_string());
                            },
                            elevation: 1,
                            child: Image.asset(
                              twitterImg,
                              scale: 52,
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
                              share_telegram(infoStatsWotd, emojiStatsWotd,
                                  wotd_game_duration_string());
                            },
                            elevation: 1,
                            child: Icon(
                              Icons.telegram_rounded,
                              color: Colors.white,
                              size: 27.5,
                            ),
                            fillColor: telegramColor,
                            shape: CircleBorder(),
                          ),
                          RawMaterialButton(
                            onPressed: () {
                              share_others(infoStatsWotd, emojiStatsWotd,
                                  wotd_game_duration_string());
                            },
                            elevation: 1,
                            child: Icon(
                              Icons.more_horiz_rounded,
                              color: Colors.white,
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
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
            ],
          ),
        ),
        if (_isBannerAdReady)
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: _bannerAd.size.width.toDouble(),
              height: _bannerAd.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd),
            ),
          ),
      ]),
    );
  }

  // STATS MANAGEMENT

  void wotd_emoji_stats_builder() {
    bool lineUsed = false;
    emojiStatsWotd = "";
    for (var i = 0; i < colorsArrayWotd.length; i += 5) {
      lineUsed = false;
      for (var j = i; j < i + 5; j++) {
        if (colorsArrayWotd[j] == "V") {
          emojiStatsWotd += greenEmoji;
          lineUsed = true;
        }
        if (colorsArrayWotd[j] == "A") {
          emojiStatsWotd += yellowEmoji;
          lineUsed = true;
        }
        if (colorsArrayWotd[j] == "G") {
          emojiStatsWotd += whiteEmoji;
          lineUsed = true;
        }
      }
      if (lineUsed) emojiStatsWotd += "\n";
    }
  }

  String wotd_game_duration_string() {
    int hours;
    int minutes;
    int seconds;

    hours = playSecondsWotd.inHours;
    minutes = playSecondsWotd.inMinutes - hours * 60;
    seconds = playSecondsWotd.inSeconds - hours * 60 * 60 - minutes * 60;

    String h = hours.toString().padLeft(2, '0');
    String m = minutes.toString().padLeft(2, '0');
    String s = seconds.toString().padLeft(2, '0');

    return (h + ":" + m + ":" + s);
  }
}
