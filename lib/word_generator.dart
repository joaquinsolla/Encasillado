import 'dart:math';

import 'word_database.dart';
import 'common.dart';


void generateWord (){
  var rng = Random();
  wordOfTheDay = wordsList[rng.nextInt(wordsList.length -1)];
}

