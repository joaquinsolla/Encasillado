import 'package:flutter/material.dart';

import 'word_database.dart';
import 'common.dart';
import 'word_generator.dart';
import 'init_view.dart';

void main() {
  /** RUN APP WITH ADITIONAL ARGS:
   *  --no-sound-null-safety */

  /** DATABASE SELECTOR */
  selectedDatabase = bigDB;
  //selectedDatabase = testDB0;
  //selectedDatabase = testDB1;


  startDate = DateTime.now();

  generateWord();
  runApp(MyApp());
}
