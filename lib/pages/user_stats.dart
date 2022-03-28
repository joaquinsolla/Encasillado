import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/widgets.dart';
import 'package:Encasillado/common/colors.dart';
import 'package:Encasillado/ad_helper.dart';
import 'package:Encasillado/charts/infinite_chart.dart';
import 'package:Encasillado/charts/infinite_series.dart';
import 'package:Encasillado/charts/wotd_chart.dart';
import 'package:Encasillado/charts/wotd_series.dart';

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
    //String wotdProm = '-';
    if (wotdHits > 0) {
      wotdPercentage = ((wotdHits/totalWotdGames)*100).toStringAsFixed(1);
      //wotdProm = [winsAtFirstWotd,winsAtSecondWotd,winsAtThirdWotd,winsAtFourthWotd,winsAtFifthWotd,winsAtSixthWotd].reduce(max).toString();
    }

    int infiniteHits = totalInfiniteGames-defeatsAtInfinite;
    String infinitePercentage = '0';
    // String infiniteProm = '-';
    String infiniteScoreRate = '-';
    if (infiniteHits > 0) {
      infinitePercentage = ((infiniteHits/totalInfiniteGames)*100).toStringAsFixed(1);
      //infiniteProm = [winsAtFirstInfinite,winsAtSecondInfinite,winsAtThirdInfinite,winsAtFourthInfinite,winsAtFifthInfinite,winsAtSixthInfinite].reduce(max).toString();
    }
    if(totalInfiniteGames > 0) infiniteScoreRate = (infiniteScore/totalInfiniteGames).toStringAsFixed(0) + " pts/partida";

    // GENERATE CHART DATA
    final List<WotdSeries> wotdData = [
      WotdSeries(
        attempt: "1",
        times: winsAtFirstWotd,
        barColor: charts.ColorUtil.fromDartColor(Colors.green),
      ),
      WotdSeries(
        attempt: "2",
        times: winsAtSecondWotd,
        barColor: charts.ColorUtil.fromDartColor(Colors.lightGreenAccent),
      ),
      WotdSeries(
        attempt: "3",
        times: winsAtThirdWotd,
        barColor: charts.ColorUtil.fromDartColor(Colors.yellowAccent),
      ),
      WotdSeries(
        attempt: "4",
        times: winsAtFourthWotd,
        barColor: charts.ColorUtil.fromDartColor(Colors.orangeAccent),
      ),
      WotdSeries(
        attempt: "5",
        times: winsAtFifthWotd,
        barColor: charts.ColorUtil.fromDartColor(Colors.orange),
      ),
      WotdSeries(
        attempt: "6",
        times: winsAtSixthWotd,
        barColor: charts.ColorUtil.fromDartColor(Colors.deepOrange),
      ),
      WotdSeries(
        attempt: "X",
        times: defeatsAtWotd,
        barColor: charts.ColorUtil.fromDartColor(Colors.red),
      ),
    ];

    final List<InfiniteSeries> infiniteData = [
      InfiniteSeries(
        attempt: "1",
        times: winsAtFirstInfinite,
        barColor: charts.ColorUtil.fromDartColor(Colors.green),
      ),
      InfiniteSeries(
        attempt: "2",
        times: winsAtSecondInfinite,
        barColor: charts.ColorUtil.fromDartColor(Colors.lightGreenAccent),
      ),
      InfiniteSeries(
        attempt: "3",
        times: winsAtThirdInfinite,
        barColor: charts.ColorUtil.fromDartColor(Colors.yellowAccent),
      ),
      InfiniteSeries(
        attempt: "4",
        times: winsAtFourthInfinite,
        barColor: charts.ColorUtil.fromDartColor(Colors.orangeAccent),
      ),
      InfiniteSeries(
        attempt: "5",
        times: winsAtFifthInfinite,
        barColor: charts.ColorUtil.fromDartColor(Colors.orange),
      ),
      InfiniteSeries(
        attempt: "6",
        times: winsAtSixthInfinite,
        barColor: charts.ColorUtil.fromDartColor(Colors.deepOrange),
      ),
      InfiniteSeries(
        attempt: "X",
        times: defeatsAtInfinite,
        barColor: charts.ColorUtil.fromDartColor(Colors.red),
      ),
    ];

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
                  Text("Partidas totales: $totalWotdGames ($wotdPercentage%)\n"
                            "Victorias: $wotdHits\n"
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
                  Center(
                      child: WotdChart(
                        wotdData: wotdData,
                      )),
                  SizedBox(
                    height: 10,
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
                  Text("Partidas totales: $totalInfiniteGames ($infinitePercentage%)\n"
                        "Victorias: $infiniteHits\n"
                        "Derrotas: $defeatsAtInfinite\n"
                      "Récord de puntuación: $scoreRecord\n"
                      "Récord de racha: $streakRecord\n"
                      "Tasa de puntos: $infiniteScoreRate",
                    style: TextStyle(
                      fontSize: 15,
                      color: appBlack,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                      fontFamily: 'RaleWay',
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Center(
                      child: InfiniteChart(
                        infiniteData: infiniteData,
                      )),
                  Text(
                    "* pts/partida: Puntos por partida",
                    style: TextStyle(
                      fontSize: 12,
                      color: appGrey,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                      fontFamily: 'RaleWay',
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 7.5,),
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
