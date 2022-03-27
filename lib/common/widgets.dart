import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:twitter_intent/twitter_intent.dart';
import 'package:flushbar/flushbar.dart';

import 'package:Encasillado/common/imagepaths.dart';
import 'package:Encasillado/common/methods.dart';
import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/colors.dart';

AppBar myAppBarWithButtonsWithoutBackArrow(BuildContext context) {
  double imageScale;
  if (deviceWidth < 340)
    imageScale = 11;
  else
    imageScale = 8;

  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: appMainColor,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          bannerImg,
          scale: imageScale,
        ),
        Expanded(child: Text("")),
        Container(
          width: 40,
          child: RawMaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, '/trophies');
            },
            elevation: 0,
            child: Image.asset(trophiesImg, scale: 35,),
            fillColor: appSecondColor,
            shape: CircleBorder(),
          ),
        ),
        SizedBox(width: 2.5,),
        Container(
          width: 40,
          child: RawMaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, '/user_stats');
            },
            elevation: 0,
            child: Image.asset(userStatsImg, scale: 35,),
            fillColor: appSecondColor,
            shape: CircleBorder(),
          ),
        ),
        SizedBox(
          width: 2.5,
        ),
        Container(
          width: 40,
          child: RawMaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            elevation: 0,
            child: Image.asset(settingsImg, scale: 67.5,),
            fillColor: appSecondColor,
            shape: CircleBorder(),
          ),
        ),
      ],
    ),
  );
}

AppBar myAppBarWithoutButtonsWithBackArrow(BuildContext context) {
  double imageScale;
  if (deviceWidth < 340)
    imageScale = 11;
  else
    imageScale = 8;

  return AppBar(
    backgroundColor: appMainColor,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          bannerImg,
          scale: imageScale,
        ),
      ],
    ),
  );
}

AppBar myAppBarWithoutButtonsAndBackArrow(BuildContext context) {
  double imageScale;
  if (deviceWidth < 340)
    imageScale = 11;
  else
    imageScale = 8;

  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: appMainColor,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          bannerImg,
          scale: imageScale,
        ),
      ],
    ),
  );
}

Row settingsRow(String text, Widget widget) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: appBlack,
          fontWeight: FontWeight.w700,
          decoration: TextDecoration.none,
          fontFamily: 'RaleWay',
        ),
      ),
      const Expanded(child: Text("")),
      widget,
    ],
  );
}

Row settingsRowAdvanced(String mainText, String secondText,Widget widget) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mainText,
            style: TextStyle(
              fontSize: 16,
              color: appBlack,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.none,
              fontFamily: 'RaleWay',
            ),
          ),
          Text(
            secondText,
            style: TextStyle(
              fontSize: 12,
              color: appGrey,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none,
              fontFamily: 'RaleWay',
            ),
          ),
        ],),
      const Expanded(child: Text("")),
      widget,
    ],
  );
}

TextButton socialsButton(String url, String image, double scale, String text) {
  return TextButton(
    onPressed: () {
      url_launcher(url);
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          image,
          scale: scale,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: appGrey,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.none,
            fontFamily: 'RaleWay',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Text smallText(String content){
  return Text(content,
    style: TextStyle(
      fontSize: 12,
      color: appGrey,
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.none,
      fontFamily: 'RaleWay',
    ),
    textAlign: TextAlign.center,
  );
}

Text headerText(String content){
  return Text(
    content,
    style: TextStyle(
      fontSize: 30,
      color: appBlack,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.none,
      fontFamily: 'RaleWay',
    ),
    textAlign: TextAlign.center,
  );
}

Container gameBannerTwoButtons(BuildContext context, String content, Widget button1, Widget button2) {

  return Container(
    height: 35,
    margin: EdgeInsets.fromLTRB(7.5, 7.5, 7.5, 3.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 15,
        ),
        Text(
          content,
          style: TextStyle(
            fontSize: 17,
            color: appBlack,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
            fontFamily: 'RaleWay',
          ),
        ),
        Expanded(child: Text("")),
        button1,
        SizedBox(
          width: 5.0,
        ),
        button2,
      ],
    ),
  );
}

Container gameBannerOneButton(BuildContext context, String content, Widget button1) {

  return Container(
    height: 35,
    margin: EdgeInsets.fromLTRB(7.5, 7.5, 7.5, 3.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 15,
        ),
        Text(
          content,
          style: TextStyle(
            fontSize: 17,
            color: appBlack,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
            fontFamily: 'RaleWay',
          ),
        ),
        Expanded(child: Text("")),
        button1,
        SizedBox(
          width: 5.0,
        ),
      ],
    ),
  );
}

TextButton releaseNotesButton(BuildContext context) {
  return TextButton(
    onPressed: () {
      Navigator.pushNamed(context, '/release_notes');
    },
    style: TextButton.styleFrom(
      primary: appBlack,
      backgroundColor: keyColor,
    ),
    child: Text(
      appVersion,
      style: TextStyle(color: appBlack),
    ),
  );
}

TextButton twitterBotButton(BuildContext context) {
  String img;
  if (darkMode) img = twitterBotImgDarkmode;
  else img = twitterBotImgLightmode;

  final botLink = FollowUserIntent(username: 'encasillado_bot');

  return TextButton(
    onPressed: () {
      url_launcher('$botLink');
    },
    style: TextButton.styleFrom(
      primary: appBlack,
      backgroundColor: keyColor,
    ),
    child: Image.asset(img, scale: 58,),
  );
}

TextButton scoreButton(BuildContext context) {

  String myStreakGif;
  if (darkMode) {
    myStreakGif = streakGifDarkmode;
  } else {
    myStreakGif = streakGifLightmode;
  }

  String streakCount = "×" + streak.toString();

  return TextButton(
    onPressed: () {
      Navigator.pushNamed(context, '/score_explanation');
    },
    style: TextButton.styleFrom(
      primary: appBlack,
      backgroundColor: keyColor,
    ),
    child: Row(
      children: [
        Text(
          " Puntos: " + infiniteScore.toString() + "  ",
          style: TextStyle(
            fontSize: 15,
            color: appBlack,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.none,
            fontFamily: 'RaleWay',
          ),
        ),
        Image.asset(
          myStreakGif,
        ),
        Text(
          streakCount,
          style: TextStyle(
            fontSize: 15,
            color: appBlack,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.none,
            fontFamily: 'RaleWay',
          ),
        ),
      ],
    ),



  );
}

void wordDoesNotExistFlushbar(BuildContext context) {
  Flushbar(
    message: "La palabra no existe",
    duration: Duration(seconds: 3),
    backgroundColor: Colors.redAccent,
    flushbarPosition: FlushbarPosition.TOP,
  ).show(context);
}
