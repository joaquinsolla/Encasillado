import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mailto/mailto.dart';
import 'package:social_share/social_share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

void sendSuggestedWord(String word, bool anonymous,BuildContext context) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference suggestions = firestore.collection('wordSuggestions');

  DateTime now = DateTime.now();
  String formattedDate = DateFormat('dd-MM-yyyy – kk:mm').format(now);

  if (anonymous == false && userId != null) {
    suggestions
        .add({
      'word': word,
      'user': userName,
      'time': formattedDate
    })
        .then((value) {
      suggestedWords.add(word);
      Flushbar(
        message: "Palabra enviada. ¡Gracias por colaborar!",
        duration: Duration(seconds: 3),
        backgroundColor: Colors.orange,
        flushbarPosition: FlushbarPosition.TOP,
      ).show(context);
      if (terminalPrinting) print("[SYS] Suggestion sent");
    })
        .timeout(Duration(seconds: 5), onTimeout: () {
      Flushbar(
        message: "Revisa tu conexión a Internet e inténtalo de nuevo",
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        flushbarPosition: FlushbarPosition.TOP,
      ).show(context);
      if (terminalPrinting) print("[ERR] Failed to suggest word: Timeout");
    })
        .catchError((error) {
      Flushbar(
        message: "Algo ha fallado, inténtalo más tarde",
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        flushbarPosition: FlushbarPosition.TOP,
      ).show(context);
      if (terminalPrinting) print("[ERR] Failed to suggest word: $error");
    });
  } else {
    suggestions
        .add({
      'word': word,
      'user': null,
      'time': formattedDate
    })
        .then((value) {
      suggestedWords.add(word);
      Flushbar(
        message: "Palabra enviada. ¡Gracias por colaborar!",
        duration: Duration(seconds: 3),
        backgroundColor: Colors.orange,
        flushbarPosition: FlushbarPosition.TOP,
      ).show(context);
      if (terminalPrinting) print("[SYS] Suggestion sent");
    })
        .timeout(Duration(seconds: 5), onTimeout: () {
      Flushbar(
        message: "Revisa tu conexión a Internet e inténtalo de nuevo",
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        flushbarPosition: FlushbarPosition.TOP,
      ).show(context);
      if (terminalPrinting) print("[ERR] Failed to suggest word: Timeout");
    })
        .catchError((error) {
      Flushbar(
        message: "Algo ha fallado, inténtalo más tarde",
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        flushbarPosition: FlushbarPosition.TOP,
      ).show(context);
      if (terminalPrinting) print("[ERR] Failed to suggest word: $error");
    });
  }

}

void check_diamond_trophy(){
  if (totalTrophies == 13) {
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

void updateFBScoreRecord(){
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  users
      .doc(userId)
      .update({'scoreRecord': scoreRecord})
      .then((value) {if (terminalPrinting) print("[SYS] scoreRecord updated: $scoreRecord");})
      .catchError((error) {if (terminalPrinting) print("[ERR] Failed to update scoreRecord");});
}

void updateFBStreakRecord(){
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  users
      .doc(userId)
      .update({'streakRecord': streakRecord})
      .then((value) {if (terminalPrinting) print("[SYS] streakRecord updated: $streakRecord");})
      .catchError((error) {if (terminalPrinting) print("[ERR] Failed to update streakRecord");});
}

void updateFBTrophies(){
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  users
      .doc(userId)
      .update({'trophies': totalTrophies})
      .then((value) {if (terminalPrinting) print("[SYS] trophies updated: $totalTrophies");})
      .catchError((error) {if (terminalPrinting) print("[ERR] Failed to update trophies");});
}