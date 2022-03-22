import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/widgets.dart';
import 'package:Encasillado/common/colors.dart';
import 'package:Encasillado/ad_helper.dart';

class ReleaseNotes extends StatefulWidget {
  @override
  _ReleaseNotesState createState() => _ReleaseNotesState();
}

class _ReleaseNotesState extends State<ReleaseNotes> {
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
          child: Column(children: [
            Expanded(
              child: ListView(
                addAutomaticKeepAlives: true,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Versión " + appVersion + ":",
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
                    "Interfaz mejorada",
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
                    "Se ha optimizado el funcionamiento interno de la app. "
                        "Ahora todo funciona de forma más rápida y fluida. "
                        "También se ha mejorado el diseño adaptativo, para que "
                        "la interfaz se adapte a todos los tamaños de pantalla.\n",
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
                    height: 7.5,
                  ),
                  Text(
                    "Lista de palabras actualizada",
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
                    "Se han añadido nuevas palabras al repertorio del juego.\n",
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
                    height: 7.5,
                  ),
                  Text(
                    "¡Presentando al Bot de Twitter!",
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
                    "El juego tiene ahora un bot de Twitter oficial que tuitea cuál ha sido"
                    " la palabra del día cada noche.\n",
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
                    height: 7.5,
                  ),
                  Text(
                    "Corrección de bugs",
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
                    "Corregidos varios errores tanto en la interfaz como en "
                    "el funcionamiento del juego.\n",
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
                    height: 7.5,
                  ),
                  Text(
                    "En desarrollo:",
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
                    "Actualmente se está trabajando para incorporar las siguientes funcionalidades al juego:\n",
                    style: TextStyle(
                      fontSize: 16,
                      color: appBlack,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                      fontFamily: 'RaleWay',
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "Lista de palabras en proceso de mejora",
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
                    "Continuamente se está aumentando la lista de palabras del juego."
                    " Siempre puedes aportar sugerencias sobre nuevas palabras contactando"
                    " vía email en el apartado de ajustes.\n",
                    style: TextStyle(
                      fontSize: 15,
                      color: appBlack,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                      fontFamily: 'RaleWay',
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 7.5,),
                  Text(
                    "Puntos permanentes",
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
                    "Se está estudiando la posibilidad de mantener los puntos obtenidos en el "
                        "modo 'Palabras Infinitas'.\n",
                    style: TextStyle(
                      fontSize: 15,
                      color: appBlack,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                      fontFamily: 'RaleWay',
                    ),
                    textAlign: TextAlign.left,
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
