import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/widgets.dart';
import 'package:Encasillado/common/colors.dart';
import 'package:Encasillado/ad_helper.dart';

class Markers extends StatefulWidget {
  @override
  _MarkersState createState() => _MarkersState();
}

class _MarkersState extends State<Markers> {
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

    Color pointsButtonColor = appThirdColor;
    Color streakButtonColor = appMainColor;
    Color trophiesButtonColor = appMainColor;
    TextDecoration pointsDecoration = TextDecoration.underline;
    TextDecoration streakDecoration = TextDecoration.none;
    TextDecoration trophiesDecoration = TextDecoration.none;

    if (markersPage == 0) {
      pointsButtonColor = appThirdColor;
      streakButtonColor = appMainColor;
      trophiesButtonColor = appMainColor;
      pointsDecoration = TextDecoration.underline;
      streakDecoration = TextDecoration.none;
      trophiesDecoration = TextDecoration.none;
    } else if (markersPage == 1) {
      pointsButtonColor = appMainColor;
      streakButtonColor = appThirdColor;
      trophiesButtonColor = appMainColor;
      pointsDecoration = TextDecoration.none;
      streakDecoration = TextDecoration.underline;
      trophiesDecoration = TextDecoration.none;
    } else {
      pointsButtonColor = appMainColor;
      streakButtonColor = appMainColor;
      trophiesButtonColor = appThirdColor;
      pointsDecoration = TextDecoration.none;
      streakDecoration = TextDecoration.none;
      trophiesDecoration = TextDecoration.underline;
    }

    if (markersPage == 0)
      return Scaffold(
        appBar: myAppBarWithoutButtonsWithBackArrow(context),
        backgroundColor: appWhite,
        body: Column(
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
                          backgroundColor: pointsButtonColor,
                        ),
                        child: Text(
                          "Puntos",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            decoration: pointsDecoration,
                          ),
                        )),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            markersPage = 1;
                          });
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: streakButtonColor,
                        ),
                        child: Text(
                          "Rachas",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            decoration: streakDecoration,
                          ),
                        )),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            markersPage = 2;
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
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                addAutomaticKeepAlives: true,
                children: [
                  Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "PUNTOS",
                            style: TextStyle(
                              fontSize: 25,
                              color: appBlack,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                              fontFamily: 'RaleWay',
                            ),
                            textAlign: TextAlign.center,
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
          ],
        ),
      );
    else if (markersPage == 1)
      return Scaffold(
        appBar: myAppBarWithoutButtonsWithBackArrow(context),
        backgroundColor: appWhite,
        body: Column(
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
                            markersPage = 0;
                          });
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: pointsButtonColor,
                        ),
                        child: Text(
                          "Puntos",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            decoration: pointsDecoration,
                          ),
                        )),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: streakButtonColor,
                        ),
                        child: Text(
                          "Rachas",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            decoration: streakDecoration,
                          ),
                        )),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            markersPage = 2;
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
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                addAutomaticKeepAlives: true,
                children: [
                  Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "RACHAS",
                            style: TextStyle(
                              fontSize: 25,
                              color: appBlack,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                              fontFamily: 'RaleWay',
                            ),
                            textAlign: TextAlign.center,
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
          ],
        ),
      );
    else
      return Scaffold(
        appBar: myAppBarWithoutButtonsWithBackArrow(context),
        backgroundColor: appWhite,
        body: Column(
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
                            markersPage = 0;
                          });
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: pointsButtonColor,
                        ),
                        child: Text(
                          "Puntos",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            decoration: pointsDecoration,
                          ),
                        )),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            markersPage = 1;
                          });
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: streakButtonColor,
                        ),
                        child: Text(
                          "Rachas",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            decoration: streakDecoration,
                          ),
                        )),
                  ),
                  SizedBox(
                    width: 4,
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
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                addAutomaticKeepAlives: true,
                children: [
                  Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "TROFEOS",
                            style: TextStyle(
                              fontSize: 25,
                              color: appBlack,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                              fontFamily: 'RaleWay',
                            ),
                            textAlign: TextAlign.center,
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
          ],
        ),
      );
  }
}
