import 'package:Encasillado/common/methods.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/widgets.dart';
import 'package:Encasillado/common/colors.dart';

class Markers extends StatefulWidget {
  @override
  _MarkersState createState() => _MarkersState();
}

class _MarkersState extends State<Markers> {

  @override
  void initState() {}

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
    double headerHeight = 165;

    if (userId==null){
      setState(() {
        headerHeight = 115;
      });
    } else {
      setState(() {
        headerHeight = 165;
      });
    }

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
    final Stream<QuerySnapshot> scoreRecordStream = users.limit(20).orderBy(
        'scoreRecord', descending: true)
        .orderBy('name', descending: false)
        .snapshots();
    final Stream<QuerySnapshot> streakRecordStream = users.limit(20).orderBy(
        'streakRecord', descending: true)
        .orderBy('name', descending: false)
        .snapshots();
    final Stream<QuerySnapshot> trophiesStream = users.limit(20).orderBy(
        'trophies', descending: true)
        .orderBy('name', descending: false)
        .snapshots();

    return Scaffold(
      appBar: myAppBarWithoutButtonsWithBackArrow(context),
      backgroundColor: appWhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (markersPage == 0) Container(
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
          if (markersPage == 0) Container(height: headerHeight, child: Column(
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

                          if (userId != null && bdAlreadySynchronized ==
                              true) settingsRowAdvanced('Sincronizar mis datos',
                              'Actualiza la base de datos', TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    primary: appWhite,
                                    backgroundColor: appMainColor,
                                  ),
                                  child: Icon(
                                    Icons.check_rounded, color: appWhite,))),
                          if (userId != null && bdAlreadySynchronized ==
                              false) settingsRowAdvanced(
                              'Sincronizar mis datos',
                              'Actualiza la base de datos', TextButton(
                              onPressed: () {
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
                              },
                              style: TextButton.styleFrom(
                                primary: appWhite,
                                backgroundColor: appMainColor,
                              ),
                              child: Icon(
                                Icons.restart_alt_rounded, color: appWhite,))),
                          SizedBox(height: 10),

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
                        ]))
              ]),),
          if (markersPage == 0) Expanded(
            child: ScrollConfiguration(
                behavior: listViewBehaviour(),
                child: Scrollbar(
                    isAlwaysShown: true,
                    child: ListView(
                        addAutomaticKeepAlives: true,
                        children: [
                          Container(
                              margin: const EdgeInsets.fromLTRB(
                                  30.0, 0, 30.0, 0.0),
                              alignment: Alignment.topCenter,
                              child: Column(
                                  children: [
                                    StreamBuilder<QuerySnapshot>(
                                      stream: scoreRecordStream,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<
                                              QuerySnapshot> snapshot) {
                                        if (snapshot.hasError) {
                                          return myErrorAnimation();
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return myLoadingAnimation();
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
                                                    height: deviceHeight *
                                                        0.045,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .start,
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            topNumber
                                                                .toString(),
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
          if (markersPage == 0) Container(
              margin: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0.0),
              alignment: Alignment.topCenter,
              child: Column(
                  children: [

                    Divider(
                      color: appGrey,
                    ),
                    Container(
                        height: deviceHeight * 0.05,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Tú',
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
                                '$userName',
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
                                '$scoreRecord',
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
                    Divider(
                      color: appGrey,
                    ),
                    SizedBox(height: 10,),
                  ])
          ),

          if (markersPage == 1) Container(
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
          if (markersPage == 1) Container(height: headerHeight, child: Column(
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

                          if (userId != null && bdAlreadySynchronized ==
                              true) settingsRowAdvanced('Sincronizar mis datos',
                              'Actualiza la base de datos', TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    primary: appWhite,
                                    backgroundColor: appMainColor,
                                  ),
                                  child: Icon(
                                    Icons.check_rounded, color: appWhite,))),
                          if (userId != null && bdAlreadySynchronized ==
                              false) settingsRowAdvanced(
                              'Sincronizar mis datos',
                              'Actualiza la base de datos', TextButton(
                              onPressed: () {
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
                              },
                              style: TextButton.styleFrom(
                                primary: appWhite,
                                backgroundColor: appMainColor,
                              ),
                              child: Icon(
                                Icons.restart_alt_rounded, color: appWhite,))),
                          SizedBox(height: 10),

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
                        ]))
              ]),),
          if (markersPage == 1) Expanded(
            child: ScrollConfiguration(
                behavior: listViewBehaviour(),
                child: Scrollbar(
                    isAlwaysShown: true,
                    child: ListView(
                        addAutomaticKeepAlives: true,
                        children: [
                          Container(
                              margin: const EdgeInsets.fromLTRB(
                                  30.0, 0, 30.0, 0.0),
                              alignment: Alignment.topCenter,
                              child: Column(
                                  children: [
                                    StreamBuilder<QuerySnapshot>(
                                      stream: streakRecordStream,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<
                                              QuerySnapshot> snapshot) {
                                        if (snapshot.hasError) {
                                          return myErrorAnimation();
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return myLoadingAnimation();
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
                                                    height: deviceHeight *
                                                        0.045,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .start,
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            topNumber
                                                                .toString(),
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
          if (markersPage == 1) Container(
              margin: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0.0),
              alignment: Alignment.topCenter,
              child: Column(
                  children: [

                    Divider(
                      color: appGrey,
                    ),
                    Container(
                        height: deviceHeight * 0.05,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Tú',
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
                                '$userName',
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
                                '$streakRecord',
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
                    Divider(
                      color: appGrey,
                    ),
                    SizedBox(height: 10,),
                  ])
          ),

          if (markersPage == 2) Container(
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
          if (markersPage == 2) Container(height: headerHeight, child: Column(
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

                          if (userId != null && bdAlreadySynchronized ==
                              true) settingsRowAdvanced('Sincronizar mis datos',
                              'Actualiza la base de datos', TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    primary: appWhite,
                                    backgroundColor: appMainColor,
                                  ),
                                  child: Icon(
                                    Icons.check_rounded, color: appWhite,))),
                          if (userId != null && bdAlreadySynchronized ==
                              false) settingsRowAdvanced(
                              'Sincronizar mis datos',
                              'Actualiza la base de datos', TextButton(
                              onPressed: () {
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
                              },
                              style: TextButton.styleFrom(
                                primary: appWhite,
                                backgroundColor: appMainColor,
                              ),
                              child: Icon(
                                Icons.restart_alt_rounded, color: appWhite,))),
                          SizedBox(height: 10),

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
                                      'Trofeos',
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
                        ]))
              ]),),
          if (markersPage == 2) Expanded(
            child: ScrollConfiguration(
                behavior: listViewBehaviour(),
                child: Scrollbar(
                    isAlwaysShown: true,
                    child: ListView(
                        addAutomaticKeepAlives: true,
                        children: [
                          Container(
                              margin: const EdgeInsets.fromLTRB(
                                  30.0, 0, 30.0, 0.0),
                              alignment: Alignment.topCenter,
                              child: Column(
                                  children: [
                                    StreamBuilder<QuerySnapshot>(
                                      stream: trophiesStream,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<
                                              QuerySnapshot> snapshot) {
                                        if (snapshot.hasError) {
                                          return myErrorAnimation();
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return myLoadingAnimation();
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
                                                    height: deviceHeight *
                                                        0.045,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .start,
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            topNumber
                                                                .toString(),
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
                                                                .toString() +
                                                                '/$trophies',
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
          if (markersPage == 2) Container(
              margin: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0.0),
              alignment: Alignment.topCenter,
              child: Column(
                  children: [

                    Divider(
                      color: appGrey,
                    ),
                    Container(
                        height: deviceHeight * 0.05,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Tú',
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
                                '$userName',
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
                                '$userTrophies/$trophies',
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
                    Divider(
                      color: appGrey,
                    ),
                    SizedBox(height: 10,),
                  ])
          ),
        ],
      ),
    );
  }
}
