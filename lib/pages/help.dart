import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:Encasillado/common/imagepaths.dart';
import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/widgets.dart';
import 'package:Encasillado/common/colors.dart';
import 'package:Encasillado/ad_helper.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {

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
            if(terminalPrinting) print("[ERR] Failed to load a banner ad on 'help.dart': ${err.message}");
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

    String ex_green;
    String ex_yellow;
    String ex_grey;
    if (colorBlind) {
      ex_green = exampleGreenColorblindImg;
      ex_yellow = exampleYellowColorblindImg;
      ex_grey = exampleGreyColorblindImg;
    } else {
      ex_green = exampleGreenImg;
      ex_yellow = exampleYellowImg;
      ex_grey = exampleGreyImg;
    }

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
                    "Cómo jugar",
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
                  Text(
                    "Tienes 6 intentos para adivinar la palabra oculta, que está compuesta por 5 letras.\n\n"
                        "Las palabras que pruebes deben estar en el diccionario. No se aceptan plurales ni verbos conjugados. "
                        "Las palabras con tilde se escriben sin ella.\n\n"
                        "Cada vez que pruebes una palabra las casillas cambiarán de color para indicar tu progreso:\n",
                    style: TextStyle(
                      fontSize: 16,
                      color: appBlack,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                      fontFamily: 'RaleWay',
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Container(
                    height: 40,
                    child: Image.asset(ex_green),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "La letra A está en la palabra oculta y va en esa posición\n",
                    style: TextStyle(
                      fontSize: 16,
                      color: appBlack,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.none,
                      fontFamily: 'RaleWay',
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 40,
                    child: Image.asset(ex_yellow),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "La letra E está en la palabra oculta pero no va en esa posición\n",
                    style: TextStyle(
                      fontSize: 16,
                      color: appBlack,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.none,
                      fontFamily: 'RaleWay',
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 40,
                    child: Image.asset(ex_grey),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "La letra T no está en la palabra oculta\n",
                    style: TextStyle(
                      fontSize: 16,
                      color: appBlack,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.none,
                      fontFamily: 'RaleWay',
                    ),
                    textAlign: TextAlign.left,
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