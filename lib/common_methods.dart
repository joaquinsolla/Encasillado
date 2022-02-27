import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mailto/mailto.dart';
import 'dart:math';

import 'package:flushbar/flushbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

import 'keyboard_infinite.dart';
import 'common_variables.dart';
import 'common_widgets.dart';
import 'common_colors.dart';
import 'common_urls.dart';

void generate_infinite_word() {
  var rng = Random();
  String selectedWord = selectedDatabase[rng.nextInt(selectedDatabase.length)];

  infiniteString = selectedWord;

  for (var i = 0; i < 5; i++) {
    infiniteArray[i] = selectedWord.substring(i, i + 1);
    infiniteDefinitionURL += selectedWord.substring(i, i + 1);
  }

  print("INFINITE: " + infiniteString);
}

void generate_wotd() {
  int dbLength = selectedDatabase.length;
  int todayIndex = ((3.14159265359 *
              DateTime.now().day *
              DateTime.now().month *
              DateTime.now().year *
              1000) %
          dbLength)
      .round();

  String selectedWord = selectedDatabase[todayIndex - 1];

  wotdString = selectedWord;

  for (var i = 0; i < 5; i++) {
    wotdArray[i] = selectedWord.substring(i, i + 1);
    wotdDefinitionURL += selectedWord.substring(i, i + 1);
  }

  //print("WOTD: " + wotdString);
}

void check_device(BuildContext context) {
  deviceWidth = MediaQuery.of(context).size.width;
  deviceHeight = MediaQuery.of(context).size.height -
      56; //Do not consider AppBar heigth (56px)
  keyHeight = (deviceHeight) * 0.083;
}

void check_settings() {
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

  if (darkMode) {
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
}

void url_launcher(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class start_new_game extends StatelessWidget {
  const start_new_game({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBarWithButtons(context),
      body: Column(children: [
        cellsFieldInfinite(),
        Expanded(
          child: Text(""),
        ),
        infinite_generate_keyboard(context),
      ]),
    );
  }
}

void build_stats_infinite() {
  bool lineUsed = false;
  emojiStatsInfinite = "";
  for (var i = 0; i < colorsArrayInfinite.length; i += 5) {
    lineUsed = false;
    for (var j = i; j < i + 5; j++) {
      if (colorsArrayInfinite[j] == "V") {
        emojiStatsInfinite += greenEmoji;
        lineUsed = true;
      }
      if (colorsArrayInfinite[j] == "A") {
        emojiStatsInfinite += yellowEmoji;
        lineUsed = true;
      }
      if (colorsArrayInfinite[j] == "G") {
        emojiStatsInfinite += whiteEmoji;
        lineUsed = true;
      }
    }
    if (lineUsed) emojiStatsInfinite += "\n";
  }
  int seconds = playSecondsInfinite.inSeconds;
  if (alreadyPointsCalculatedInfinite == false) {
    if (wonGameInfinite) {
      if (seconds < 900) {
        if (currentRowInfinite == 0) pointsInfinite += 50000;
        else {
          pointsInfinite += ((900 - seconds) *
              (6 - currentRowInfinite) *
              ((streak + 1) * 0.1 + 1))
              .toInt();
        }
        if (pointsInfinite > 9999999) pointsInfinite = 9999999;
      }
    } else {
      pointsInfinite -= 1000;
    }
    alreadyPointsCalculatedInfinite = true;
  }
}

void build_stats_wotd() {
  bool lineUsed = false;
  emojiStatsWotd = "";
  for (var i = 0; i < colorsArrayWotd.length; i += 5) {
    lineUsed = false;
    for (var j = i; j < i + 5; j++) {
      if (colorsArrayWotd[j] == "V") {
        emojiStatsWotd += greenEmoji;
        lineUsed = true;
      }
      if (colorsArrayWotd[j] == "A") {
        emojiStatsWotd += yellowEmoji;
        lineUsed = true;
      }
      if (colorsArrayWotd[j] == "G") {
        emojiStatsWotd += whiteEmoji;
        lineUsed = true;
      }
    }
    if (lineUsed) emojiStatsWotd += "\n";
  }
}

mail_to(String email) async {
  final mailtoLink = Mailto(
    to: [email],
    cc: [''],
    subject: 'Contacto vía Encasillado',
    body: '',
  );
  await launch('$mailtoLink');
}

void copy_to_clipboard(
    BuildContext context, String stats, String emojis, String gameDuration) {
  String text = stats +
      "\n" +
      emojis +
      "Tiempo: " +
      gameDuration +
      "\n\n" +
      encasilladoPlayStoreURL;
  Clipboard.setData(ClipboardData(text: text));
  //may cause problems with null sound safety
  Flushbar(
    message: "Copiado al portapapeles",
    duration: Duration(milliseconds: 2500),
    backgroundColor: myGrey,
    flushbarPosition: FlushbarPosition.BOTTOM,
  ).show(context);
}

Future<void> whatsapp_share(
    String stats, String emojis, String gameDuration) async {
  String text = stats +
      "\n" +
      emojis +
      "Tiempo: " +
      gameDuration +
      "\n\n" +
      encasilladoPlayStoreURL;
  await WhatsappShare.share(
    text: text,
    linkUrl: '',
    phone: '911234567890',
  );
}

String game_duration_to_string_infinite() {
  int hours;
  int minutes;
  int seconds;

  hours = playSecondsInfinite.inHours;
  minutes = playSecondsInfinite.inMinutes - hours * 60;
  seconds = playSecondsInfinite.inSeconds - hours * 60 * 60 - minutes * 60;

  String h = hours.toString().padLeft(2, '0');
  String m = minutes.toString().padLeft(2, '0');
  String s = seconds.toString().padLeft(2, '0');

  return (h + ":" + m + ":" + s);
}

String game_duration_to_string_wotd() {
  int hours;
  int minutes;
  int seconds;

  hours = playSecondsWotd.inHours;
  minutes = playSecondsWotd.inMinutes - hours * 60;
  seconds = playSecondsWotd.inSeconds - hours * 60 * 60 - minutes * 60;

  String h = hours.toString().padLeft(2, '0');
  String m = minutes.toString().padLeft(2, '0');
  String s = seconds.toString().padLeft(2, '0');

  return (h + ":" + m + ":" + s);
}

void restart_infinite_game_variables() {
  currentCellInfinite = 0;
  currentRowInfinite = 0;
  canWriteInfinite = true;
  finishedInfinite = false;

  infiniteArray = ["", "", "", "", ""];
  infiniteString = "";
  infiniteDefinitionURL = "https://dle.rae.es/";

  wonGameInfinite = false;
  infoStatsInfinite = "";
  emojiStatsInfinite = "";
  startDateInfinite = DateTime.parse("2000-01-01 00:00:00.000000");
  endDateInfinite = DateTime.parse("2000-01-01 00:00:00.000000");
  playSecondsInfinite = endDateInfinite.difference(startDateInfinite);
  alreadyTimeMeasuredInfinite = false;
  alreadyPointsCalculatedInfinite = false;

  greenKeysInfinite = [];
  yellowKeysInfinite = [];
  greyKeysInfinite = [];

  inputMatrixInfinite = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
  ];

  colorsArrayInfinite = [
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B"
  ];
}
