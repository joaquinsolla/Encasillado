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
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            "0×",
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
                            "0×",
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
                            "0×",
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
                            "0×",
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