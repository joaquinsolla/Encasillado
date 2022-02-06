import 'package:Joadle/user_settings.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'common.dart';
import 'my_keyboard.dart';

/** ADMOB */
/*
import 'package:Joadle/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
*/

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Wordle",
      debugShowCheckedModeBanner: false,
      home: Inicio(),
    );
  }
}

class Inicio extends StatefulWidget {
  Inicio({Key? key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

// Screen
class _InicioState extends State<Inicio> {

  /** ADMOB */
  /*
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  */

  @override
  Widget build(BuildContext context) {
    devWidth = MediaQuery.of(context).size.width;
    devHeight = MediaQuery.of(context).size.height;

    /** ADMOB */
    /*
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
    */

    /** CHECK SETTINGS */
    if (colorBlind) {
      myGreen = Colors.orange;
      myYellow = Colors.blue;
      greenEmoji = "🟧";
      yellowEmoji = "🟦";
    } else {
      myGreen = Colors.green;
      myYellow = Color(0xfff3d500);
      greenEmoji = "🟩";
      yellowEmoji = "🟨";
    }

    if (nightMode) {
      myBlack = Colors.white;
      myWhite = Color(0xff2d2d2d);
      mySemiBlack = Colors.white;
      whiteEmoji = "⬛";
      keyColor = Color(0xff131313);
    } else {
      myBlack = Colors.black;
      myWhite = Colors.white;
      mySemiBlack = Colors.black54;
      whiteEmoji = "⬜";
      keyColor = Color(0xffefefef);
    }

    return Scaffold(
      backgroundColor: myWhite,
      appBar: MainAppBar(context, true),
      body: Column(children: [
        cellsField(),
        Expanded(
          child: Text(""),
        ),
        generate_keyboard(context),

        /** ADMOB */
        /*
        if (_isBannerAdReady)
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: _bannerAd.size.width.toDouble(),
              height: _bannerAd.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd),
            ),
          ),*/

      ]),
    );
  }
}
