/**
 * APP DESIGNED AND CODED BY:
 * Joaquin Solla Vazquez
 * App repository: https://github.com/joaquinsolla/Encasillado
 * */

import 'package:flutter/material.dart';

import 'databases.dart';
import 'common/miscellaneous.dart';
import 'common/methods.dart';
import 'main_view.dart';


//TODO: RUN APP WITH ADITIONAL ARGS: --no-sound-null-safety
void main() {

  /** DATABASE SELECTOR
   * 0 - testDB0
   * 1 - testDB1
   * 2 - testDB2
   * 3 - gameDB * */
  selectedDatabase = databasesList[3];

  generate_infinite_word();
  generate_wotd();

  runApp(EncasilladoApp());
}
