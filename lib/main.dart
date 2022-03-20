/**
 * APP DESIGNED AND CODED BY:
 * Joaquin Solla Vazquez
 * App repository: https://github.com/joaquinsolla/Encasillado
 * */

import 'package:Encasillado/pages/help.dart';
import 'package:Encasillado/pages/infinite_words_end.dart';
import 'package:Encasillado/pages/score_explanation.dart';
import 'package:Encasillado/pages/settings.dart';
import 'package:Encasillado/pages/streak_explanation.dart';
import 'package:Encasillado/pages/update_news.dart';
import 'package:Encasillado/pages/home.dart';
import 'package:Encasillado/pages/wotd_end.dart';
import 'package:flutter/material.dart';
import 'databases.dart';
import 'common/miscellaneous.dart';
import 'common/methods.dart';


//TODO: RUN APP WITH ADITIONAL ARGS: --no-sound-null-safety
void main() {

  /** DATABASE SELECTOR
   * 0 - gameDB
   * 1 - testDB0
   * 2 - testDB1
   * 3 - testDB2 * */
  selectedDatabase = databasesList[0];

  // WORD GENERATION
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
      '/streak_explanation': (context) => StreakExplanation(),
      '/update_news': (context) => UpdateNews(),
      '/wotd_end': (context) => WotdEnd(),
    },
  ));

}
