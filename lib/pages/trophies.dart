import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:Encasillado/common/imagepaths.dart';
import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/widgets.dart';
import 'package:Encasillado/common/colors.dart';
import 'package:Encasillado/ad_helper.dart';

class Trophies extends StatefulWidget {
  @override
  _TrophiesState createState() => _TrophiesState();
}

class _TrophiesState extends State<Trophies> {

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

    /** TROPHIES PROGRESS */
    String allTrophiesProg = '0';
    String atFirstProg = '0';
    String atSecondProg = '0';
    String streak25Prog = '0';
    String streak10Prog = '0';
    String streak5Prog = '0';
    String points15kProg = '0';
    String points10kProg = '0';
    String points5kProg = '0';
    String firstPlayProg = '0';

    /** CALCULATE TROPHIES PROGRESS */


    return Scaffold(
        appBar: myAppBarWithoutButtonsWithBackArrow(context),
        backgroundColor: appWhite,
        body: Container(
          margin: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Expanded(child: ListView(
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
                      Row(
                        children: [
                          Text(
                            "$diamondTrophies×",
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
                            child: Image.asset(diamondTrophy, scale: 17.5,),
                          ),
                        ],
                      ),
                      SizedBox(width: 7.5,),
                      Row(
                        children: [
                          Text(
                            "$goldTrophies×",
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
                            child: Image.asset(goldTrophy, scale: 17.5,),
                          ),
                        ],
                      ),
                      SizedBox(width: 7.5,),
                      Row(
                        children: [
                          Text(
                            "$silverTrophies×",
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
                            child: Image.asset(silverTrophy, scale: 17.5,),
                          ),
                        ],
                      ),
                      SizedBox(width: 7.5,),
                      Row(
                        children: [
                          Text(
                            "$bronzeTrophies×",
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
                            child: Image.asset(bronzeTrophy, scale: 17.5,),
                          ),
                        ],
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
                  trophiesRow('Todos los trofeos', 'Progreso: $allTrophiesProg%', diamondTrophy, allTrophiesTr),

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
                  trophiesRow('Acierta a la primera', 'Progreso: $atFirstProg%', goldTrophy, atFirstTr),
                  trophiesRow('15.000 puntos', 'Mejor: $points15kProg', goldTrophy, points15kTr),
                  trophiesRow('Racha de 25', 'Mejor: $streak25Prog', goldTrophy, streak25Tr),

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
                  trophiesRow('Acierta en 2 intentos', 'Progreso: $atSecondProg%', silverTrophy, atSecondTr),
                  trophiesRow('10.000 puntos', 'Mejor: $points10kProg', silverTrophy, points10kTr),
                  trophiesRow('Racha de 10', 'Mejor: $streak10Prog', silverTrophy, streak10Tr),

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
                  trophiesRow('Tu primera partida', 'Progreso: $firstPlayProg%', bronzeTrophy, firstPlayTr),
                  trophiesRow('5.000 puntos', 'Mejor: $points5kProg', bronzeTrophy, points5kTr),
                  trophiesRow('Racha de 5', 'Mejor: $streak5Prog', bronzeTrophy, streak5Tr),

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
              ),),
              //if (_isBannerAdReady) SizedBox(height: 5,),
              //if (_isBannerAdReady) smallText('ADVERTISING'),
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
  }
}