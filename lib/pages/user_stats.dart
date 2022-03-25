import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:math';

import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/widgets.dart';
import 'package:Encasillado/common/colors.dart';
import 'package:Encasillado/ad_helper.dart';

class UserStats extends StatefulWidget {
  @override
  _UserStatsState createState() => _UserStatsState();
}

class _UserStatsState extends State<UserStats> {
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

    int wotdHits = totalWotdGames-defeatsAtWotd;
    String wotdPercentage = '0';
    String wotdProm = '-';
    if (wotdHits > 0) {
      wotdPercentage = ((wotdHits/totalWotdGames)*100).toStringAsFixed(1);
      wotdProm = [winsAtFirstWotd,winsAtSecondWotd,winsAtThirdWotd,winsAtFourthWotd,winsAtFifthWotd,winsAtSixthWotd].reduce(max).toString();
    }

    int infiniteHits = totalInfiniteGames-defeatsAtInfinite;
    String infinitePercentage = '0';
    String infiniteProm = '-';
    String infiniteScoreRate = '-';
    if (infiniteHits > 0) {
      infinitePercentage = ((infiniteHits/totalInfiniteGames)*100).toStringAsFixed(1);
      infiniteProm = [winsAtFirstInfinite,winsAtSecondInfinite,winsAtThirdInfinite,winsAtFourthInfinite,winsAtFifthInfinite,winsAtSixthInfinite].reduce(max).toString();
    }
    if(totalInfiniteGames > 0) infiniteScoreRate = (infiniteScore/totalInfiniteGames).toStringAsFixed(0);

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
                    "Tus estadísticas",
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
                    "La palabra del día",
                    style: TextStyle(
                      fontSize: 16,
                      color: appBlack,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                      fontFamily: 'RaleWay',
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 2.5,),
                  Text(
                        "Partidas totales: $totalWotdGames           Prct. victoria: $wotdPercentage%\n"
                            "Victorias: $wotdHits                        Intento promedio: $wotdProm\n"
                            "Derrotas: $defeatsAtWotd",
                        style: TextStyle(
                          fontSize: 15,
                          color: appBlack,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                          fontFamily: 'RaleWay',
                        ),
                        textAlign: TextAlign.left,
                      ),

                  //TODO: Insert wotd diagram

                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Palabras infinitas",
                    style: TextStyle(
                      fontSize: 16,
                      color: appBlack,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                      fontFamily: 'RaleWay',
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 2.5,),
                  Text(
                    "Partidas totales: $totalInfiniteGames           Prct. victoria: $infinitePercentage%\n"
                        "Victorias: $infiniteHits                        Intento promedio: $infiniteProm\n"
                        "Derrotas: $defeatsAtInfinite                        Tasa puntos: $infiniteScoreRate pts/p",
                    style: TextStyle(
                      fontSize: 15,
                      color: appBlack,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                      fontFamily: 'RaleWay',
                    ),
                    textAlign: TextAlign.left,
                  ),

                  //TODO: Insert infinite diagram

                  Text(
                    "\n*Prct.: Porcentaje\n* pts/p: Puntos por partida",
                    style: TextStyle(
                      fontSize: 12,
                      color: appGrey,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                      fontFamily: 'RaleWay',
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 5,),
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
