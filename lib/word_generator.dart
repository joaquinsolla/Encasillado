import 'dart:math';

import 'my_database.dart';

void generateWord (){
  var rng = Random();

  wordOfTheDay = fiveLettersList[rng.nextInt(fiveLettersList.length -1)];
}

