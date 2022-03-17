import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mailto/mailto.dart';
import 'package:social_share/social_share.dart';
import 'dart:math';

import 'package:flushbar/flushbar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../keyboard_infinite.dart';
import 'miscellaneous.dart';
import 'widgets.dart';
import 'colors.dart';
import 'urls.dart';

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

  print("WOTD: " + wotdString);
}

void urlLauncher(String url) async {
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

void copy_to_clipboard(BuildContext context, String stats, String emojis, String gameDuration) {
  String text = stats +
      "\n" +
      emojis +
      "Tiempo: " +
      gameDuration +
      "\n\n" +
      encasilladoPlayStoreUrl;
  Clipboard.setData(ClipboardData(text: text));
  //may cause problems with null sound safety
  Flushbar(
    message: "Copiado al portapapeles",
    duration: Duration(milliseconds: 2500),
    backgroundColor: appGrey,
    flushbarPosition: FlushbarPosition.BOTTOM,
  ).show(context);
}

void whatsapp_share(String stats, String emojis, String gameDuration) {
  String text = stats +
      "\n" +
      emojis +
      "Tiempo: " +
      gameDuration +
      "\n\n" +
      encasilladoPlayStoreUrl;

  SocialShare.shareWhatsapp(text);
}

void twitter_share(String stats, String emojis, String gameDuration) {

  //TODO: REVISAR
  String text = stats +
      " \n " +
      emojis +
      "Tiempo: " +
      gameDuration + "\n ";

  SocialShare.shareTwitter(text, hashtags: ["Encasillado"], url:encasilladoPlayStoreUrl);
}

void telegram_share(String stats, String emojis, String gameDuration) {

  String text = stats +
      "\n" +
      emojis +
      "Tiempo: " +
      gameDuration +
      "\n\n" +
      encasilladoPlayStoreUrl;

  SocialShare.shareTelegram(text);

}

void others_share(String stats, String emojis, String gameDuration) {

  String text = stats +
      "\n" +
      emojis +
      "Tiempo: " +
      gameDuration +
      "\n\n" +
      encasilladoPlayStoreUrl;

  SocialShare.shareOptions(text);

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
  timeStartedInfinite = false;
  timeStartedWotd = false;

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
