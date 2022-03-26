import 'package:Encasillado/common/imagepaths.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/widgets.dart';
import 'package:Encasillado/common/colors.dart';
import 'package:Encasillado/ad_helper.dart';

class ScoreExplanation extends StatefulWidget {
  @override
  _ScoreExplanationState createState() => _ScoreExplanationState();
}

class _ScoreExplanationState extends State<ScoreExplanation> {
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
            print('Failed to load a banner ad: ${err.message}');
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

    String myStreakGif;
    if (darkMode) {
      myStreakGif = streakGifDarkmode;
    } else {
      myStreakGif = streakGifLightmode;
    }

    return Scaffold(
        appBar: myAppBarWithoutButtonsWithBackArrow(context),
        backgroundColor: appWhite,
        body: Container(
          margin: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
          alignment: Alignment.topCenter,
          child: Column(children: [
            Expanded(
              child: ListView(
                addAutomaticKeepAlives: true,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Puntuación y rachas",
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
                    "Puntuación",
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
                    "Acertar palabras te sumará puntos. Cuanto más rápido seas y "
                        "menos intentos necesites, más puntos obtendrás. Acertar "
                        "al primer intento otorga 10.000 puntos. No acertar en los "
                        "6 intentos resta 300 puntos.\n",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Tu puntuación actual: ",
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
                        child: Text(
                              infiniteScore.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                color: appBlack,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                                fontFamily: 'RaleWay',
                              ),
                            ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Rachas",
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
                    "Las rachas actúan de pequeños multiplicadores para la puntuación. "
                        "Obtendrás una racha acertando palabras consecutivamente. "
                        "Perder una partida supone regresar a una racha de 0.\n",
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
                            Image.asset(
                              myStreakGif,
                              scale: 15,
                            ),
                            Text(
                              " ×" + streak.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                color: appBlack,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                                fontFamily: 'RaleWay',
                              ),
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
            if (_isBannerAdReady)Align(
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
}
