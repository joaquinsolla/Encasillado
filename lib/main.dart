/**
 * APP DESIGNED AND CODED BY:
 * Joaquin Solla Vazquez
 * App repository: https://github.com/joaquinsolla/Encasillado
 * */

import 'package:Encasillado/pages/trophies.dart';
import 'package:flutter/material.dart';

import 'package:Encasillado/databases.dart';
import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/methods.dart';
import 'package:Encasillado/pages/help.dart';
import 'package:Encasillado/pages/infinite_words_end.dart';
import 'package:Encasillado/pages/score_explanation.dart';
import 'package:Encasillado/pages/settings.dart';
import 'package:Encasillado/pages/release_notes.dart';
import 'package:Encasillado/pages/home.dart';
import 'package:Encasillado/pages/wotd_end.dart';
import 'package:Encasillado/pages/user_stats.dart';


//TODO: RUN APP WITH ADITIONAL ARGS: --no-sound-null-safety
void main() {

  /** DATABASE SELECTOR
   * 0 - gameDB
   * 1 - testDB * */
  selectedDatabase = databasesList[0];

  /** TERMINAL DEBUGGING */
  terminalPrinting = false;

  infinite_generate_word();
  wotd_generate_word();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Encasillado",
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
      '/help': (context) => Help(),
      '/infinite_words_end': (context) => InfiniteWordsEnd(),
      '/score_explanation': (context) => ScoreExplanation(),
      '/settings': (context) => Settings(),
      '/release_notes': (context) => ReleaseNotes(),
      '/trophies': (context) => Trophies(),
      '/user_stats': (context) => UserStats(),
      '/wotd_end': (context) => WotdEnd(),
    },
  ));

}
