import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mailto/mailto.dart';
import 'package:social_share/social_share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/colors.dart';
import 'package:Encasillado/common/urls.dart';

void infinite_generate_word() {
  var rng = Random();
  String selectedWord = selectedDatabase[rng.nextInt(selectedDatabase.length)];

  infiniteString = selectedWord;

  for (var i = 0; i < 5; i++) {
    infiniteArray[i] = selectedWord.substring(i, i + 1);
    infiniteDefinitionURL += selectedWord.substring(i, i + 1);
  }

  if(terminalPrinting) print("[SYS] Infinite: " + infiniteString);
}

void wotd_generate_word() {
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

  if(terminalPrinting) print("[SYS] Wotd: " + wotdString);
}

void check_diamond_trophy(){
  if (totalTrophies == 12) {
    diamondTrophies = 1;
    allTrophiesTr = true;
  } else {
    diamondTrophies = 0;
    allTrophiesTr = false;
  }
}

void url_launcher(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw "[ERR] Method 'url_launcher' could not launch $url";
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

  Flushbar(
    message: "Copiado al portapapeles",
    duration: Duration(milliseconds: 2500),
    backgroundColor: appGrey,
    flushbarPosition: FlushbarPosition.BOTTOM,
  ).show(context);
}

void share_whatsapp(String stats, String emojis, String gameDuration) {
  String text = stats +
      "\n" +
      emojis +
      "Tiempo: " +
      gameDuration +
      "\n\n" +
      encasilladoPlayStoreUrl;

  SocialShare.shareWhatsapp(text);
}

void share_twitter(String stats, String emojis, String gameDuration) {

  String text = stats +
      " \n " +
      emojis +
      "Tiempo: " +
      gameDuration + "\n ";

  SocialShare.shareTwitter(text, hashtags: ["Encasillado"], url:encasilladoPlayStoreUrl);
}

void share_telegram(String stats, String emojis, String gameDuration) {

  String text = stats +
      "\n" +
      emojis +
      "Tiempo: " +
      gameDuration +
      "\n\n" +
      encasilladoPlayStoreUrl;

  SocialShare.shareTelegram(text);
}

void share_others(String stats, String emojis, String gameDuration) {

  String text = stats +
      "\n" +
      emojis +
      "Tiempo: " +
      gameDuration +
      "\n\n" +
      encasilladoPlayStoreUrl;

  SocialShare.shareOptions(text);
}