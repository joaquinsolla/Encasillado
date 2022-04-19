import 'dart:async';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mailto/mailto.dart';
import 'package:social_share/social_share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

void sendSuggestedWord(String word, BuildContext context) async {
  final now = DateTime.now();
  String nowString = now.toString();

  if (terminalPrinting) print('[SYS] Trying to send $word to online databasey');

  int timeout = 5;

  try{
  var response = await http.post(
    Uri.parse('https://api.jsonbin.io/v3/b'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'X-Master-Key': '\$2b\$10\$e5klPqwHbbDvgDVd3jPqDe7sWxWNcPiHKn15wQHojsv9pZzySdgjy',
    },
    body: jsonEncode(<String, String>{
      '$nowString': word,
    }),
  ).timeout(Duration(seconds: timeout));;

    if (response.statusCode == 200) {
      if (terminalPrinting) print('[SYS] $word sent (200)');
      suggestedWords.add(word);
      Flushbar(
        message: "Palabra enviada. ¡Gracias por colaborar!",
        duration: Duration(seconds: 3),
        backgroundColor: Colors.orange,
        flushbarPosition: FlushbarPosition.TOP,
      ).show(context);

    } else {
      var statusCode = response.statusCode;
      if (terminalPrinting) print("[ERR] couldn't send $word ($statusCode)");
      Flushbar(
        message: "Ha ocurrido un error, inténtalo de nuevo",
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        flushbarPosition: FlushbarPosition.TOP,
      ).show(context);
    }

  } on SocketException catch (e){
    if (terminalPrinting) print("[ERR] couldn't send $word ($e)");
    Flushbar(
      message: "Revisa tu conexión a Internet e inténtalo de nuevo",
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red,
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);

  } on TimeoutException catch (e) {
    if (terminalPrinting) print("[ERR] couldn't send $word ($e)");
    Flushbar(
      message: "Revisa tu conexión a Internet e inténtalo de nuevo",
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red,
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);

  } on Error catch (e){
    if (terminalPrinting) print("[ERR] couldn't send $word ($e)");
    Flushbar(
      message: "Ha ocurrido un error, inténtalo de nuevo",
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red,
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
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