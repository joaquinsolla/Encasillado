import 'dart:math';

import 'common.dart';


void generateWord (){
  var rng = Random();
  String selectedWord = selectedDatabase[rng.nextInt(selectedDatabase.length)];

  for (var i = 0; i < 5; i++) {
    wordOfTheDay[i] = selectedWord.substring(i, i+1);
    definitionURL += selectedWord.substring(i, i+1);
  }
}

