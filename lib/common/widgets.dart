import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:twitter_intent/twitter_intent.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Encasillado/common/imagepaths.dart';
import 'package:Encasillado/common/methods.dart';
import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/colors.dart';

class listViewBehaviour extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

Scrollbar myScrollbar(ListView listview){
  return Scrollbar(
    isAlwaysShown: false,
    child: listview,
  );
}

AppBar myAppBarWithButtonsWithoutBackArrow(BuildContext context) {

  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: appMainColor,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('Encasillado',
          style: GoogleFonts.paytoneOne(color: Colors.white, fontSize: 24,),
          textAlign: TextAlign.left,
        ),
        Expanded(child: Text("")),
        Container(
          width: 40,
          child: RawMaterialButton(
            onPressed: () {
              check_diamond_trophy();
              Navigator.pushNamed(context, '/trophies_stats');
            },
            elevation: 0,
            child: Image.asset(trophiesStatsImg, scale: 35,),
            fillColor: appSecondColor,
            shape: CircleBorder(),
          ),
        ),
        SizedBox(width: 2.5,),
        Container(
          width: 40,
          child: RawMaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, '/markers');
            },
            elevation: 0,
            child: Image.asset(markersImg, scale: 35,),
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
            child: Icon(Icons.settings, color: Colors.white, size: 32,),
            fillColor: appSecondColor,
            shape: CircleBorder(),
          ),
        ),
      ],
    ),
  );
}

AppBar myAppBarWithoutButtonsWithBackArrow(BuildContext context) {
  return AppBar(
    backgroundColor: appMainColor,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('Encasillado',
          style: GoogleFonts.paytoneOne(color: Colors.white, fontSize: 24,),
          textAlign: TextAlign.left,
        ),
      ],
    ),
  );
}

AppBar myAppBarWithoutButtonsAndBackArrow(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: appMainColor,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('Encasillado',
          style: GoogleFonts.paytoneOne(color: Colors.white, fontSize: 24,),
          textAlign: TextAlign.left,
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

Column trophiesRow(String mainText, String secondText, String trophy, bool variable) {
  if (variable == true) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 7.5,),
        Container(
          padding: const EdgeInsets.all(7.5),
          decoration: BoxDecoration(
            color: keyColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
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
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                      fontFamily: 'RaleWay',
                    ),
                  ),
                  Text(
                    '¡Conseguido!',
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
              Image.asset(trophy, scale: 15),
            ],
          ),
        )
      ],
    );
  } else {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 7.5,),
        Container(
          padding: const EdgeInsets.all(7.5),
          decoration: BoxDecoration(
            color: keyColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
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
                      fontWeight: FontWeight.normal,
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
              Image.asset(noTrophy, scale: 15),
            ],
          ),
        )
      ],
    );
  }
}

Column trophiesRowAdvanced(String tag,String mainText, String secondText, String trophy, bool variable) {
  if (variable == true) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 7.5,),
        Container(
          padding: const EdgeInsets.all(7.5),
          decoration: BoxDecoration(
            color: keyColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(tag, scale: 15,),
                    Text(
                      ' ' + mainText,
                      style: TextStyle(
                        fontSize: 16,
                        color: appBlack,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                        fontFamily: 'RaleWay',
                      ),
                    ),
                  ],),

                  if (mainText!='Introduce la palabra secreta')Text(
                    '¡Conseguido!',
                    style: TextStyle(
                      fontSize: 12,
                      color: appGrey,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                      fontFamily: 'RaleWay',
                    ),
                  ),
                  if (mainText=='Introduce la palabra secreta')Text(
                    'FELIZ',
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
              Image.asset(trophy, scale: 15),
            ],
          ),
        )
      ],
    );
  } else {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 7.5,),
        Container(
          padding: const EdgeInsets.all(7.5),
          decoration: BoxDecoration(
            color: keyColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(tag, scale: 15,),
                      Text(
                        ' ' + mainText,
                        style: TextStyle(
                          fontSize: 16,
                          color: appBlack,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                          fontFamily: 'RaleWay',
                        ),
                      ),
                    ],),
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
              Image.asset(noTrophy, scale: 15),
            ],
          ),
        )
      ],
    );
  }
}

Column myLoadingAnimation(){
  return Column(
    // Vertically center the widget inside the column
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(height: deviceHeight*0.15,),
      Text(
        'Cargando...',
        style: TextStyle(
          fontSize: 16,
          color: appBlack,
          fontWeight: FontWeight.w700,
          decoration: TextDecoration.none,
          fontFamily: 'RaleWay',
        ),
      ),
      SizedBox(height: 5,),
      LoadingBouncingLine.circle(
        size: 50,
        backgroundColor: appSecondColor,
      ),
    ],
  );
}

Column myErrorAnimation(){
  return Column(
    // Vertically center the widget inside the column
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(height: deviceHeight*0.15,),
      Text(
        'Ha ocurrido un error, inténtalo más tarde.',
        style: TextStyle(
          fontSize: 16,
          color: appBlack,
          fontWeight: FontWeight.w700,
          decoration: TextDecoration.none,
          fontFamily: 'RaleWay',
        ),
      ),
      SizedBox(height: 5,),
      LoadingBouncingLine.circle(
        size: 50,
        backgroundColor: appSecondColor,
      ),
    ],
  );
}

Wrap socialsWrap(List<Widget> buttons){
  return Wrap(
    alignment: WrapAlignment.center,
    children: buttons,
  );
}

TextButton socialsSmallButton(String url, String image, double scale) {
  return TextButton(
    onPressed: () {
      url_launcher(url);
    },
    child: Image.asset(
      image,
      scale: scale,
    ),
  );
}

TextButton socialsBigButton(String url, String image, double scale, String text) {
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

TextButton suggestButton(BuildContext context) {
  return TextButton(
    onPressed: () {
      Navigator.pushNamed(context, '/suggest');
    },
    style: TextButton.styleFrom(
      primary: appBlack,
      backgroundColor: keyColor,
    ),
    child: Text('Sugerir',
      style: GoogleFonts.paytoneOne(color: appBlack, fontSize: 14,),
      textAlign: TextAlign.center,
    ),
  );
}

TextButton twitterBotButton(BuildContext context) {

  final botLink = FollowUserIntent(username: 'encasillado_bot');

  return TextButton(
    onPressed: () {
      url_launcher('$botLink');
    },
    style: TextButton.styleFrom(
      primary: appBlack,
      backgroundColor: keyColor,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(twitterImg, scale: 55,),
        Text(' Bot',
          style: GoogleFonts.paytoneOne(color: appBlack, fontSize: 14,),
          textAlign: TextAlign.center,
        )
      ],
    ),
  );
}

TextButton scoreButton(BuildContext context) {

  String myStreakGif;
  if (darkMode) {
    myStreakGif = streakGifDarkmode;
  } else {
    myStreakGif = streakGifLightmode;
  }

  String streakCount = "x" + streak.toString();

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
        Text("Puntos: " + infiniteScore.toString() + "   ",
          style: GoogleFonts.paytoneOne(color: appBlack, fontSize: 14,),
          textAlign: TextAlign.center,
        ),
        Image.asset(
          myStreakGif,
        ),
        Text(streakCount,
          style: GoogleFonts.paytoneOne(color: appBlack, fontSize: 14,),
          textAlign: TextAlign.center,
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

void loadingAdFlushbar(BuildContext context) {
    Flushbar(
      message: "Cargando anuncio. Inténtalo de nuevo",
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red,
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
}

void trophyFlushbar(BuildContext context, String content) {
  Flushbar(
    message: content,
    duration: Duration(seconds: 5),
    backgroundColor: Colors.green,
    flushbarPosition: FlushbarPosition.TOP,
  ).show(context);
}

void diamondTrophyFlushbar(BuildContext context) {
  Flushbar(
    message: "¡Trofeo de diamante conseguido!",
    duration: Duration(seconds: 5),
    backgroundColor: Colors.purple,
    flushbarPosition: FlushbarPosition.TOP,
  ).show(context);
}

void rewardFlushbar(BuildContext context) {
  Flushbar(
    message: "¡Recompensa obtenida!",
    duration: Duration(seconds: 8),
    backgroundColor: Colors.orange,
    flushbarPosition: FlushbarPosition.TOP,
  ).show(context);
}
