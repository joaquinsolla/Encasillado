import 'package:flutter/material.dart';

import 'word_databases.dart';
import 'common_variables.dart';
import 'common_methods.dart';
import 'main_view.dart';


//TODO: RUN APP WITH ADITIONAL ARGS: --no-sound-null-safety
void main() {

  /** DATABASE SELECTOR
   * 0 - testDB0
   * 1 - testDB1
   * 2 - testDB2
   * 3 - gameDB * */
  selectedDatabase = databasesList[3];

  startDateInfinite = DateTime.now();
  startDateWotd = DateTime.now();
  generate_infinite_word();
  generate_wotd();

  runApp(EncasilladoApp());
}
