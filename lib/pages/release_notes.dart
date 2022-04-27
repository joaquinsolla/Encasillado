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
            if (terminalPrinting)
              print("[ERR] Failed to load a banner ad on "
                  "'release_notes.dart': ${err.message}");
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

    Text mainText(String content) {
      return Text(
        content,
        style: TextStyle(
          fontSize: 16,
          color: appBlack,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.none,
          fontFamily: 'RaleWay',
        ),
        textAlign: TextAlign.left,
      );
    }

    Text secondaryText(String content) {
      return Text(
        content,
        style: TextStyle(
          fontSize: 15,
          color: appBlack,
          fontWeight: FontWeight.normal,
          decoration: TextDecoration.none,
          fontFamily: 'RaleWay',
        ),
        textAlign: TextAlign.left,
      );
    }

    return Scaffold(
      appBar: myAppBarWithoutButtonsWithBackArrow(context),
      backgroundColor: appWhite,
      body: Column(children: [
        Expanded(
          child: ScrollConfiguration(
              behavior: listViewBehaviour(),
              child: myScrollbar(ListView(
                addAutomaticKeepAlives: true,
                children: [
                  Container(
                      margin: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Novedades v$appVersion:",
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
                            "Palabras registradas: " +
                                (selectedDatabase.length).toString(),
                            style: TextStyle(
                              fontSize: 15,
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
                          mainText('Nombre de jugador'),
                          secondaryText(
                              "Ahora puedes ponerte un nombre de jugador con el que los demás "
                                  "podrán identificarte.\n"),
                          SizedBox(
                            height: 7.5,
                          ),
                          mainText('Marcadores globales'),
                          secondaryText(
                              "Se han incorporado al juego los marcadores, en los que figurarán los "
                                  "mejores jugadores. Para tener la posibilidad de aparecer en ellos "
                                  "debes ponerte un nombre de jugador.\n"),
                          SizedBox(
                            height: 7.5,
                          ),
                          mainText('Sistema de sugerencias mejorado'),
                          secondaryText(
                              "Pueden sugerirse palabras para añadir y también para eliminar. También "
                                  "se ha abandonado la base de datos antigua para integrar la app con Firebase.\n"),
                          SizedBox(
                            height: 7.5,
                          ),
                          mainText('Interfaz actualizada'),
                          secondaryText(
                              "Cambios estéticos y funcionales en la interfaz que hacen la aplicación más atractiva "
                                  "visualmente y más fácil de usar. También se han movido de sitio botones como el del "
                                  "apartado de estadísticas.\n"),
                          SizedBox(
                            height: 7.5,
                          ),
                          mainText('Sistema de puntuación actualizado'),
                          secondaryText(
                              "Fallar una palabra resta ahora 5.000 puntos frente a los 300 que se restaban anteriormente.\n"),
                          SizedBox(
                            height: 7.5,
                          ),
                          mainText('Mejoras de rendimiento'),
                          secondaryText(
                              "Se han hecho cambios en el funcionamiento interno de la app para que esta sea más rápida y ligera "
                                  "a la hora de usarse.\n"),
                          SizedBox(
                            height: 7.5,
                          ),
                          mainText('Lista de palabras actualizada'),
                          secondaryText(
                              "Gracias a vuestra colaboración, se han recibido 42 sugerencias de palabras nuevas de las cuales 23 han sido "
                                  "añadidas al juego.\n"),
                          SizedBox(
                            height: 7.5,
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
              ))),
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
}
