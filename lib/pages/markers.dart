import 'package:Encasillado/common/methods.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    int topNumber = 0;

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

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final Stream<QuerySnapshot> scoreRecordStream = users.limit(10).orderBy(
        'scoreRecord', descending: true)
        .orderBy('name', descending: false)
        .snapshots();
    final Stream<QuerySnapshot> streakRecordStream = users.limit(10).orderBy(
        'streakRecord', descending: true)
        .orderBy('name', descending: false)
        .snapshots();
    final Stream<QuerySnapshot> trophiesStream = users.limit(10).orderBy(
        'trophies', descending: true)
        .orderBy('name', descending: false)
        .snapshots();

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
              child: ScrollConfiguration(
                  behavior: listViewBehaviour(),
                  child: myScrollbar(ListView(
                      addAutomaticKeepAlives: true,
                      children: [
                        Container(
                            margin: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0.0),
                            alignment: Alignment.topCenter,
                            child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  headerText('Mejores puntuaciones'),
                                  SizedBox(
                                    height: 20,
                                  ),

                                  if (userId != null) settingsRowAdvanced('Sincronizar mis datos', 'Actualiza la base de datos', TextButton(
                                          onPressed: () {
                                            if (bdAlreadySynchronized) {
                                              Flushbar(
                                                message: "La base de datos ya se ha sincronizado",
                                                duration: Duration(seconds: 3),
                                                backgroundColor: Colors.red,
                                                flushbarPosition: FlushbarPosition.TOP,
                                              ).show(context);
                                            } else {
                                              setState(() {
                                                bdAlreadySynchronized = true;
                                              });
                                              updateFBScoreRecord();
                                              updateFBStreakRecord();
                                              updateFBTrophies();
                                              Flushbar(
                                                message: "Base de datos sincronizada",
                                                duration: Duration(seconds: 3),
                                                backgroundColor: Colors.orange,
                                                flushbarPosition: FlushbarPosition.TOP,
                                              ).show(context);
                                            }
                                          },
                                          style: TextButton.styleFrom(
                                            primary: appWhite,
                                            backgroundColor: appMainColor,
                                          ),
                                          child: Icon(Icons.restart_alt_rounded, color: appWhite,))),
                                  if (userId != null) SizedBox(height: 10,),

                                  Container(
                                      height: deviceHeight * 0.045,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                            'Top',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: appBlack,
                                              fontWeight: FontWeight
                                                  .bold,
                                              decoration: TextDecoration
                                                  .none,
                                              fontFamily: 'RaleWay',
                                            ),),),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                            'Jugador',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: appBlack,
                                              fontWeight: FontWeight
                                                  .bold,
                                              decoration: TextDecoration
                                                  .none,
                                              fontFamily: 'RaleWay',
                                            ),),),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                            'Puntuación',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: appBlack,
                                              fontWeight: FontWeight
                                                  .bold,
                                              decoration: TextDecoration
                                                  .none,
                                              fontFamily: 'RaleWay',
                                            ),),),
                                        ],
                                      )),
                                  StreamBuilder<QuerySnapshot>(
                                    stream: scoreRecordStream,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError) {
                                        return Text('Something went wrong');
                                      }
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Text("Loading");
                                      }

                                      return Column(
                                        children: snapshot.data!.docs.map((
                                            DocumentSnapshot document) {
                                          topNumber++;
                                          Map<String, dynamic> data = document
                                              .data()! as Map<
                                              String,
                                              dynamic>;
                                          return
                                            Column(children: [
                                              Divider(
                                                color: appGrey,
                                              ),
                                              Container(
                                                  height: deviceHeight * 0.045,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          topNumber.toString(),
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            color: appBlack,
                                                            fontWeight: FontWeight
                                                                .w500,
                                                            decoration: TextDecoration
                                                                .none,
                                                            fontFamily: 'RaleWay',
                                                          ),),),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                        data['name'],
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: appBlack,
                                                          fontWeight: FontWeight
                                                              .normal,
                                                          decoration: TextDecoration
                                                              .none,
                                                          fontFamily: 'RaleWay',
                                                        ),),),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                        (data['scoreRecord'])
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: appBlack,
                                                          fontWeight: FontWeight
                                                              .normal,
                                                          decoration: TextDecoration
                                                              .none,
                                                          fontFamily: 'RaleWay',
                                                        ),),),
                                                    ],
                                                  ))
                                            ],);

                                        }).toList(),
                                      );
                                    },
                                  ),

                                ])
                        )
                      ])
                  )
              ),


            ),
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
              child: ScrollConfiguration(
                  behavior: listViewBehaviour(),
                  child: myScrollbar(ListView(
                      addAutomaticKeepAlives: true,
                      children: [
                        Container(
                            margin: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0.0),
                            alignment: Alignment.topCenter,
                            child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  headerText('Mejores rachas'),
                                  SizedBox(
                                    height: 20,
                                  ),

                                  if (userId != null) settingsRowAdvanced('Sincronizar mis datos', 'Actualiza la base de datos', TextButton(
                                      onPressed: () {
                                        if (bdAlreadySynchronized) {
                                          Flushbar(
                                            message: "La base de datos ya se ha sincronizado",
                                            duration: Duration(seconds: 3),
                                            backgroundColor: Colors.red,
                                            flushbarPosition: FlushbarPosition.TOP,
                                          ).show(context);
                                        } else {
                                          setState(() {
                                            bdAlreadySynchronized = true;
                                          });
                                          updateFBScoreRecord();
                                          updateFBStreakRecord();
                                          updateFBTrophies();
                                          Flushbar(
                                            message: "Base de datos sincronizada",
                                            duration: Duration(seconds: 3),
                                            backgroundColor: Colors.orange,
                                            flushbarPosition: FlushbarPosition.TOP,
                                          ).show(context);
                                        }
                                      },
                                      style: TextButton.styleFrom(
                                        primary: appWhite,
                                        backgroundColor: appMainColor,
                                      ),
                                      child: Icon(Icons.restart_alt_rounded, color: appWhite,))),
                                  if (userId != null) SizedBox(height: 10,),

                                  Container(
                                      height: deviceHeight * 0.045,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'Top',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: appBlack,
                                                fontWeight: FontWeight
                                                    .bold,
                                                decoration: TextDecoration
                                                    .none,
                                                fontFamily: 'RaleWay',
                                              ),),),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              'Jugador',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: appBlack,
                                                fontWeight: FontWeight
                                                    .bold,
                                                decoration: TextDecoration
                                                    .none,
                                                fontFamily: 'RaleWay',
                                              ),),),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'Racha',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: appBlack,
                                                fontWeight: FontWeight
                                                    .bold,
                                                decoration: TextDecoration
                                                    .none,
                                                fontFamily: 'RaleWay',
                                              ),),),
                                        ],
                                      )),
                                  StreamBuilder<QuerySnapshot>(
                                    stream: streakRecordStream,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError) {
                                        return Text('Something went wrong');
                                      }
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Text("Loading");
                                      }

                                      return Column(
                                        children: snapshot.data!.docs.map((
                                            DocumentSnapshot document) {
                                          topNumber++;
                                          Map<String, dynamic> data = document
                                              .data()! as Map<
                                              String,
                                              dynamic>;
                                          return
                                            Column(children: [
                                              Divider(
                                                color: appGrey,
                                              ),
                                              Container(
                                                  height: deviceHeight * 0.045,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          topNumber.toString(),
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            color: appBlack,
                                                            fontWeight: FontWeight
                                                                .w500,
                                                            decoration: TextDecoration
                                                                .none,
                                                            fontFamily: 'RaleWay',
                                                          ),),),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          data['name'],
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            color: appBlack,
                                                            fontWeight: FontWeight
                                                                .normal,
                                                            decoration: TextDecoration
                                                                .none,
                                                            fontFamily: 'RaleWay',
                                                          ),),),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          (data['streakRecord'])
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            color: appBlack,
                                                            fontWeight: FontWeight
                                                                .normal,
                                                            decoration: TextDecoration
                                                                .none,
                                                            fontFamily: 'RaleWay',
                                                          ),),),
                                                    ],
                                                  ))
                                            ],);

                                        }).toList(),
                                      );
                                    },
                                  ),

                                ])
                        )
                      ])
                  )
              ),


            ),
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
      );
    else
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
              child: ScrollConfiguration(
                  behavior: listViewBehaviour(),
                  child: myScrollbar(ListView(
                      addAutomaticKeepAlives: true,
                      children: [
                        Container(
                            margin: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0.0),
                            alignment: Alignment.topCenter,
                            child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  headerText('Top trofeos'),
                                  SizedBox(
                                    height: 20,
                                  ),

                                  if (userId != null) settingsRowAdvanced('Sincronizar mis datos', 'Actualiza la base de datos', TextButton(
                                      onPressed: () {
                                        if (bdAlreadySynchronized) {
                                          Flushbar(
                                            message: "La base de datos ya se ha sincronizado",
                                            duration: Duration(seconds: 3),
                                            backgroundColor: Colors.red,
                                            flushbarPosition: FlushbarPosition.TOP,
                                          ).show(context);
                                        } else {
                                          setState(() {
                                            bdAlreadySynchronized = true;
                                          });
                                          updateFBScoreRecord();
                                          updateFBStreakRecord();
                                          updateFBTrophies();
                                          Flushbar(
                                            message: "Base de datos sincronizada",
                                            duration: Duration(seconds: 3),
                                            backgroundColor: Colors.orange,
                                            flushbarPosition: FlushbarPosition.TOP,
                                          ).show(context);
                                        }
                                      },
                                      style: TextButton.styleFrom(
                                        primary: appWhite,
                                        backgroundColor: appMainColor,
                                      ),
                                      child: Icon(Icons.restart_alt_rounded, color: appWhite,))),
                                  if (userId != null) SizedBox(height: 10,),

                                  Container(
                                      height: deviceHeight * 0.045,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'Top',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: appBlack,
                                                fontWeight: FontWeight
                                                    .bold,
                                                decoration: TextDecoration
                                                    .none,
                                                fontFamily: 'RaleWay',
                                              ),),),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              'Jugador',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: appBlack,
                                                fontWeight: FontWeight
                                                    .bold,
                                                decoration: TextDecoration
                                                    .none,
                                                fontFamily: 'RaleWay',
                                              ),),),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'Nº trofeos',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: appBlack,
                                                fontWeight: FontWeight
                                                    .bold,
                                                decoration: TextDecoration
                                                    .none,
                                                fontFamily: 'RaleWay',
                                              ),),),
                                        ],
                                      )),
                                  StreamBuilder<QuerySnapshot>(
                                    stream: trophiesStream,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError) {
                                        return Text('Something went wrong');
                                      }
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Text("Loading");
                                      }

                                      return Column(
                                        children: snapshot.data!.docs.map((
                                            DocumentSnapshot document) {
                                          topNumber++;
                                          Map<String, dynamic> data = document
                                              .data()! as Map<
                                              String,
                                              dynamic>;
                                          return
                                            Column(children: [
                                              Divider(
                                                color: appGrey,
                                              ),
                                              Container(
                                                  height: deviceHeight * 0.045,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          topNumber.toString(),
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            color: appBlack,
                                                            fontWeight: FontWeight
                                                                .w500,
                                                            decoration: TextDecoration
                                                                .none,
                                                            fontFamily: 'RaleWay',
                                                          ),),),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          data['name'],
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            color: appBlack,
                                                            fontWeight: FontWeight
                                                                .normal,
                                                            decoration: TextDecoration
                                                                .none,
                                                            fontFamily: 'RaleWay',
                                                          ),),),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          (data['trophies'])
                                                              .toString() + '/$trophies',
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            color: appBlack,
                                                            fontWeight: FontWeight
                                                                .normal,
                                                            decoration: TextDecoration
                                                                .none,
                                                            fontFamily: 'RaleWay',
                                                          ),),),
                                                    ],
                                                  ))
                                            ],);

                                        }).toList(),
                                      );
                                    },
                                  ),

                                ])
                        )
                      ])
                  )
              ),


            ),
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
      );
  }
}
