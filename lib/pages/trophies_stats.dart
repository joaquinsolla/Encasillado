import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:Encasillado/common/imagepaths.dart';
import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/widgets.dart';
import 'package:Encasillado/common/colors.dart';
import 'package:Encasillado/ad_helper.dart';
import 'package:Encasillado/charts/infinite_series.dart';
import 'package:Encasillado/charts/wotd_series.dart';
import 'package:Encasillado/charts/infinite_chart.dart';
import 'package:Encasillado/charts/wotd_chart.dart';


class TrophiesStats extends StatefulWidget {
  @override
  _TrophiesStatsState createState() => _TrophiesStatsState();
}

class _TrophiesStatsState extends State<TrophiesStats> {

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
            if (terminalPrinting) print("[ERR] Failed to load a banner ad on "
                "'trophies_stats.dart': ${err.message}");
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

    String allTag = allTagImgLightmode;
    String infiniteTag = infiniteTagImgLightmode;
    String wotdTag = wotdTagImgLightmode;
    Color trophiesButtonColor = appThirdColor;
    Color statsButtonColor = appMainColor;
    TextDecoration trophiesDecoration = TextDecoration.underline;
    TextDecoration statsDecoration = TextDecoration.none;

    if (trophiesStatsPage == 0) {
      trophiesButtonColor = appThirdColor;
      statsButtonColor = appMainColor;
      trophiesDecoration = TextDecoration.underline;
      statsDecoration = TextDecoration.none;
    }
    else {
      trophiesButtonColor = appMainColor;
      statsButtonColor = appThirdColor;
      trophiesDecoration = TextDecoration.none;
      statsDecoration = TextDecoration.underline;
    }

    if (darkMode) {
      allTag = allTagImgDarkmode;
      infiniteTag = infiniteTagImgDarkmode;
      wotdTag = wotdTagImgDarkmode;
    } else {
      allTag = allTagImgLightmode;
      infiniteTag = infiniteTagImgLightmode;
      wotdTag = wotdTagImgLightmode;
    }

    int wotdHits = totalWotdGames - defeatsAtWotd;
    String wotdPercentage = '0';
    if (wotdHits > 0) {
      wotdPercentage = ((wotdHits / totalWotdGames) * 100).toStringAsFixed(1);
    }

    int infiniteHits = totalInfiniteGames - defeatsAtInfinite;
    String infinitePercentage = '0';
    String infiniteScoreRate = '-';
    if (infiniteHits > 0) {
      infinitePercentage =
          ((infiniteHits / totalInfiniteGames) * 100).toStringAsFixed(1);
    }
    if (totalInfiniteGames > 0) infiniteScoreRate =
        (infiniteScore / totalInfiniteGames).toStringAsFixed(0) + " pts/partida";

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

    if (trophiesStatsPage == 0) return Scaffold(
          appBar: myAppBarWithoutButtonsWithBackArrow(context),
          backgroundColor: appWhite,
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 54,
                  color: appSecondColor,
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              backgroundColor: trophiesButtonColor,
                            ),
                            child: Text(
                              "Trofeos",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                decoration: trophiesDecoration,
                              ),
                            )),
                      ),
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                trophiesStatsPage = 1;
                              });
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: statsButtonColor,
                            ),
                            child: Text(
                              "Estadísticas",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                decoration: statsDecoration,
                              ),
                            )),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),),

                Expanded(child: Container(
                  alignment: Alignment.topCenter,
                  margin: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
                  child: ListView(
                    addAutomaticKeepAlives: true,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Tus trofeos",
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(
                                3.0, 3.0, 3.0, 3.0),
                            decoration: BoxDecoration(
                              color: keyColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "$diamondTrophies  ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: appBlack,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'RaleWay',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Image.asset(diamondTrophy, scale: 17.5,),
                              ],
                            ),
                          ),
                          SizedBox(width: 8,),
                          Container(
                            padding: const EdgeInsets.fromLTRB(
                                3.0, 3.0, 3.0, 3.0),
                            decoration: BoxDecoration(
                              color: keyColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "$goldTrophies  ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: appBlack,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'RaleWay',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Image.asset(goldTrophy, scale: 17.5,),
                              ],
                            ),
                          ),
                          SizedBox(width: 8,),
                          Container(
                            padding: const EdgeInsets.fromLTRB(
                                3.0, 3.0, 3.0, 3.0),
                            decoration: BoxDecoration(
                              color: keyColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "$silverTrophies  ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: appBlack,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'RaleWay',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Image.asset(silverTrophy, scale: 17.5,),
                              ],
                            ),
                          ),
                          SizedBox(width: 8,),
                          Container(
                            padding: const EdgeInsets.fromLTRB(
                                3.0, 3.0, 3.0, 3.0),
                            decoration: BoxDecoration(
                              color: keyColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "$bronzeTrophies  ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: appBlack,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'RaleWay',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Image.asset(bronzeTrophy, scale: 17.5,),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
                      // DIAMOND
                      Text(
                        "Diamante",
                        style: TextStyle(
                          fontSize: 20,
                          color: appBlack,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          fontFamily: 'RaleWay',
                        ),
                        textAlign: TextAlign.left,
                      ),
                      trophiesRow(
                          'Todos los trofeos', 'Progreso: $totalTrophies de 13',
                          diamondTrophy, allTrophiesTr),

                      SizedBox(height: 15,),
                      // GOLD
                      Text(
                        "Oro",
                        style: TextStyle(
                          fontSize: 20,
                          color: appBlack,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          fontFamily: 'RaleWay',
                        ),
                        textAlign: TextAlign.left,
                      ),
                      trophiesRowAdvanced(
                          allTag, 'Acierta a la primera', 'Progreso: 0%',
                          goldTrophy, atFirstTr),
                      trophiesRowAdvanced(
                          infiniteTag, '25.000 puntos', 'Mejor: $scoreRecord',
                          goldTrophy, points25kTr),
                      trophiesRowAdvanced(
                          infiniteTag, 'Racha de 25', 'Mejor: $streakRecord',
                          goldTrophy, streak25Tr),
                      trophiesRowAdvanced(wotdTag, 'Juega 30 días seguidos',
                          'Actual: $consecutiveDaysWotd', goldTrophy,
                          days30wotdTr),
                      trophiesRowAdvanced(
                          allTag, 'Introduce la palabra secreta', '?????',
                          goldTrophy, secretWordTr),

                      SizedBox(height: 15,),
                      // SILVER
                      Text(
                        "Plata",
                        style: TextStyle(
                          fontSize: 20,
                          color: appBlack,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          fontFamily: 'RaleWay',
                        ),
                        textAlign: TextAlign.left,
                      ),
                      trophiesRowAdvanced(
                          allTag, 'Acierta en 2 intentos', 'Progreso: 0%',
                          silverTrophy, atSecondTr),
                      trophiesRowAdvanced(
                          infiniteTag, '10.000 puntos', 'Mejor: $scoreRecord',
                          silverTrophy, points10kTr),
                      trophiesRowAdvanced(
                          infiniteTag, 'Racha de 10', 'Mejor: $streakRecord',
                          silverTrophy, streak10Tr),
                      trophiesRowAdvanced(wotdTag, 'Juega 15 días seguidos',
                          'Actual: $consecutiveDaysWotd', silverTrophy,
                          days15wotdTr),

                      SizedBox(height: 15,),
                      // BRONZE
                      Text(
                        "Bronce",
                        style: TextStyle(
                          fontSize: 20,
                          color: appBlack,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          fontFamily: 'RaleWay',
                        ),
                        textAlign: TextAlign.left,
                      ),
                      trophiesRowAdvanced(
                          allTag, 'Tu primera partida', 'Progreso: 0%',
                          bronzeTrophy, firstPlayTr),
                      trophiesRowAdvanced(
                          infiniteTag, '5.000 puntos', 'Mejor: $scoreRecord',
                          bronzeTrophy, points5kTr),
                      trophiesRowAdvanced(
                          infiniteTag, 'Racha de 5', 'Mejor: $streakRecord',
                          bronzeTrophy, streak5Tr),
                      trophiesRowAdvanced(wotdTag, 'Juega 7 días seguidos',
                          'Actual: $consecutiveDaysWotd', bronzeTrophy,
                          days7wotdTr),

                      SizedBox(height: 15,),
                      Row(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(allTagImgGrey, scale: 15),
                          smallText(' Todos los modos de juego.'),
                        ],),
                      Row(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(infiniteTagImgGrey, scale: 15),
                          smallText(' Solo en Palabras Infinitas.'),
                        ],),
                      Row(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(wotdTagImgGrey, scale: 15),
                          smallText(' Solo en La Palabra del Día.'),
                        ],),

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
                ),),

                if (_isBannerAdReady) Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: _bannerAd.size.width.toDouble(),
                    height: _bannerAd.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd),
                  ),
                ),
              ],
            ),


          )
      );
    else return Scaffold(
          appBar: myAppBarWithoutButtonsWithBackArrow(context),
          backgroundColor: appWhite,
          body: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 54,
                    color: appSecondColor,
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  trophiesStatsPage = 0;
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: trophiesButtonColor,
                              ),
                              child: Text(
                                "Trofeos",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  decoration: trophiesDecoration,
                                ),
                              )),
                        ),
                        Expanded(
                          child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                backgroundColor: statsButtonColor,
                              ),
                              child: Text(
                                "Estadísticas",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  decoration: statsDecoration,
                                ),
                              )),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),),

                  Expanded(
                    child: Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
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
                            "Partidas totales: $totalWotdGames ($wotdPercentage%)\n"
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
                          Text(
                            "Partidas totales: $totalInfiniteGames ($infinitePercentage%)\n"
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
                      ),),
                  ),

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