import 'dart:math';

import 'common.dart';


void generateWord (){
  var rng = Random();
  String selectedWord = selectedDatabase[rng.nextInt(selectedDatabase.length)];

  wordOfTheDayString = selectedWord;

  for (var i = 0; i < 5; i++) {
    wordOfTheDayArray[i] = selectedWord.substring(i, i+1);
    definitionURL += selectedWord.substring(i, i+1);
  }
}

