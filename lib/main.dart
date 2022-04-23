/**
 * APP DESIGNED AND CODED BY:
 * Joaquin Solla Vazquez
 * App repository: https://github.com/joaquinsolla/Encasillado
 * */

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'package:Encasillado/databases.dart';
import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/methods.dart';
import 'package:Encasillado/pages/infinite_words_end.dart';
import 'package:Encasillado/pages/score_explanation.dart';
import 'package:Encasillado/pages/settings.dart';
import 'package:Encasillado/pages/release_notes.dart';
import 'package:Encasillado/pages/home.dart';
import 'package:Encasillado/pages/wotd_end.dart';
import 'package:Encasillado/pages/user_stats.dart';
import 'package:Encasillado/pages/tour.dart';
import 'package:Encasillado/pages/trophies.dart';
import 'package:Encasillado/pages/suggest.dart';
import 'package:Encasillado/notificationservice.dart';
import 'package:Encasillado/pages/set_user_name.dart';


//TODO: RUN APP WITH ADITIONAL ARGS: --no-sound-null-safety
Future<void> main() async {

  /** FIREBASE INITIALIZATION */
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /** DATABASE SELECTOR
   * 0 - gameDB
   * 1 - testDB * */
  selectedDatabase = databasesList[0];

  /** TERMINAL DEBUGGING */
  terminalPrinting = true;

  infinite_generate_word();
  wotd_generate_word();

  /** NOTIFICATIONS MANAGEMENT */
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  tz.initializeTimeZones();
  NotificationService().showNotification(1, "Encasillado", "¡Nueva palabra del día disponible!");

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Encasillado",
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
      '/infinite_words_end': (context) => InfiniteWordsEnd(),
      '/score_explanation': (context) => ScoreExplanation(),
      '/settings': (context) => Settings(),
      '/release_notes': (context) => ReleaseNotes(),
      '/set_user_name': (context) => SetUserName(),
      '/suggest': (context) => Suggest(),
      '/tour': (context) => Tour(),
      '/trophies': (context) => Trophies(),
      '/user_stats': (context) => UserStats(),
      '/wotd_end': (context) => WotdEnd(),
    },
  ));

}
