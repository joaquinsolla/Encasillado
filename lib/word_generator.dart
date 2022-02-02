import 'dart:math';

import 'word_database.dart';
import 'common.dart';


void generateWord (){
  var rng = Random();
  String selectedWord = wordsList[rng.nextInt(wordsList.length)];

  for (var i = 0; i < 5; i++) {
    wordOfTheDay[i] = selectedWord.substring(i, i+1);
  }
}

