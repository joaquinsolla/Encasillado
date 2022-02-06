import 'package:flutter/material.dart';

//TODO: Implement AdMob
//import 'package:Joadle/ad_helper.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'in_game_keyboard.dart';
import 'common_methods.dart';
import 'common_widgets.dart';
import 'common_colors.dart';

class JoadleApp extends StatelessWidget {
  const JoadleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Joadle",
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

class _InicioState extends State<Inicio> {
  //TODO: Implement AdMob
  //late BannerAd _bannerAd;
  //bool _isBannerAdReady = false;

  @override
  Widget build(BuildContext context) {
    //TODO: Implement AdMob
    /*_bannerAd = BannerAd(
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
    _bannerAd.load();*/

    check_device_size(context);
    check_settings();

    return Scaffold(
      backgroundColor: myWhite,
      appBar: myAppBarWithButtons(context),
      body: Column(children: [
        cellsField(),
        Expanded(
          child: Text(""),
        ),
        generate_keyboard(context),

        //TODO: Implement AdMob
        /*if (_isBannerAdReady)
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
