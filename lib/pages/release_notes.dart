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
            if(terminalPrinting) print("[ERR] Failed to load a banner ad on "
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

    Text mainText(String content){
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
    
    Text secondaryText(String content){
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
                  SizedBox(height: 10,),
                  Text(
                    "Palabras registradas: " + (selectedDatabase.length).toString(),
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
                  mainText('Sugerir palabras'),
                  secondaryText("La pantalla principal cuenta ahora con el botón 'Sugerir', a través de "
                      "este podrás sugerir nuevas palabras para que se añadan al juego.\n"),
                  SizedBox(
                    height: 7.5,
                  ),
                  mainText('Notificaciones'),
                  secondaryText('Ahora recibirás una notificación cada vez que la Palabra del Día '
                      'cambie, puedes desactivar esto en ajustes.\n'),
                  SizedBox(
                    height: 7.5,
                  ),
                  mainText('Introducción al juego'),
                  secondaryText("Cuando se abre la aplicación por primera vez se muestra un tour para aprender "
                      "lo básico de la aplicación. Puedes volver a ver este tour en 'Ajustes' en el apartado de 'Cómo jugar'.\n"),
                  SizedBox(
                    height: 7.5,
                  ),
                  mainText('Intento extra'),
                  secondaryText('Se ha añadido la opción de repetir el último intento '
                      '(en caso de fallarlo) a cambio de ver un anuncio.\n'),
                  SizedBox(
                    height: 7.5,
                  ),
                  mainText('Lista de palabras actualizada'),
                  secondaryText('Se han añadido nuevas palabras al repertorio del juego.\n'),
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
