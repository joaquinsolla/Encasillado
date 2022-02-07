import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mailto/mailto.dart';
import 'dart:math';

import 'package:flushbar/flushbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_share/whatsapp_share.dart';


import 'in_game_keyboard.dart';
import 'common_variables.dart';
import 'common_widgets.dart';
import 'common_colors.dart';
import 'common_urls.dart';


void generate_new_word (){
  var rng = Random();
  String selectedWord = selectedDatabase[rng.nextInt(selectedDatabase.length)];

  wordOfTheDayString = selectedWord;

  for (var i = 0; i < 5; i++) {
    wordOfTheDayArray[i] = selectedWord.substring(i, i+1);
    definitionURL += selectedWord.substring(i, i+1);
  }
}

void check_device_size(BuildContext context){
  deviceWidth = MediaQuery.of(context).size.width;
  deviceHeight = MediaQuery.of(context).size.height;
}

void check_settings(){
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
        cellsField(),
        Expanded(
          child: Text(""),
        ),
        generate_keyboard(context),
      ]),
    );
  }
}

void build_stats() {
  bool lineUsed = false;
  emojiStats = "";
  for (var i = 0; i < colorsArray.length; i += 5) {
    lineUsed = false;
    for (var j = i; j < i + 5; j++) {
      if (colorsArray[j] == "V") {
        emojiStats += greenEmoji;
        lineUsed = true;
      }
      if (colorsArray[j] == "A") {
        emojiStats += yellowEmoji;
        lineUsed = true;
      }
      if (colorsArray[j] == "G") {
        emojiStats += whiteEmoji;
        lineUsed = true;
      }
    }
    if (lineUsed) emojiStats += "\n";
  }
}

mail_to(String email) async {
  final mailtoLink = Mailto(
    to: [email],
    cc: [''],
    subject: 'Contacto vía Joadle',
    body: '',
  );
  await launch('$mailtoLink');
}

void copy_to_clipboard(BuildContext context) {
  String text = infoStats +
      "\n" +
      emojiStats +
      "Tiempo: " +
      game_duration_to_string() +
      "\n\nJoadle by joa\n" + joadlePlayStoreURL;
  Clipboard.setData(ClipboardData(text: text));
  //may cause problems with null sound safety
  Flushbar(
    message: "Copiado al portapapeles",
    duration: Duration(milliseconds: 2500),
    backgroundColor: myGrey,
    flushbarPosition: FlushbarPosition.BOTTOM,
  ).show(context);
}

Future<void> whatsapp_share() async {
  String text = infoStats +
      "\n" +
      emojiStats +
      "Tiempo: " +
      game_duration_to_string() +
      "\n\nJoadle by joa\n" + joadlePlayStoreURL;
  await WhatsappShare.share(
    text: text,
    linkUrl: '',
    phone: '911234567890',
  );
}

String game_duration_to_string() {
  int hours;
  int minutes;
  int seconds;

  hours = playSeconds.inHours;
  minutes = playSeconds.inMinutes - hours * 60;
  seconds = playSeconds.inSeconds - hours * 60 * 60 - minutes * 60;

  String h = hours.toString().padLeft(2, '0');
  String m = minutes.toString().padLeft(2, '0');
  String s = seconds.toString().padLeft(2, '0');

  return (h + ":" + m + ":" + s);
}

void restart_game_variables() {

  currentCell = 0;
  currentRow = 0;
  canWrite = true;
  finished = false;

  wordOfTheDayArray = ["", "", "", "", ""];
  wordOfTheDayString = "";
  definitionURL = "https://dle.rae.es/";

  wonGame = false;
  infoStats = "";
  emojiStats = "";
  startDate = DateTime.parse("2000-01-01 00:00:00.000000");
  endDate = DateTime.parse("2000-01-01 00:00:00.000000");
  playSeconds = endDate.difference(startDate);

  greenKeys = [];
  yellowKeys = [];
  greyKeys = [];

  inputMatrix = [
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

  colorsArray = [
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