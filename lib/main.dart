import 'package:flutter/material.dart';
import 'package:my_wordle/word_database.dart';

import 'common.dart';
import 'word_generator.dart';
import 'init_view.dart';


void main() {
  /** RUN APP WITH ADITIONAL ARGS:
   *  --no-sound-null-safety */

  /** DATABASE SELECTOR */
  // testDB
  // bigDB
  wordsList = testDB;

  generateWord();
  runApp(MyApp());
}