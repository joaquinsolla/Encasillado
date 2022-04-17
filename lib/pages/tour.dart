import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:Encasillado/common/imagepaths.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Tour extends StatefulWidget {
  @override
  _TourState createState() => _TourState();
}

class _TourState extends State<Tour> {

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return IntroductionPage();
  }

  IntroductionScreen IntroductionPage() {
    return IntroductionScreen(
      showNextButton: true,
      showBackButton: true,
      pages: [
        PageViewModel(
          title: "¡Bienvenido a Encasillado!",
          body:
          "Vamos a dar un pequeño tour para aprender lo básico del juego. ¿Listo?",
          image: Image.asset(introIcon),
        ),
        PageViewModel(
          title: "¿Cómo jugar?",
          body:
          "Hay una palabra oculta, tienes 6 intentos para acertarla. Cada vez que pruebas "
              "una palabra sus letras cambiarán de color para indicar tu progreso: \n"
              "\nVerde: La palabra contiene esa letra en esa posición."
              "\nAmarillo: La palabra contiene esa letra pero no en esa posición."
              "\nGris: La palabra no contiene esa letra.",

          image: Image.asset(introExplanation1),
        ),
        PageViewModel(
          title: "El teclado",
          body:
          "Para probar una palabra debes pulsar la tecla 'PROBAR'. Las teclas del "
              "teclado también cambian de color al probar palabras.\n\n"
              "No son válidos los verbos conjugados ni los plurales. Las palabras "
              "con tilde se escriben sin ella.",
          image: Image.asset(introExplanation2),
        ),
        PageViewModel(
          title: "Dos modos de juego",
          body:
          "La Palabra del Día: Una palabra cada día. ¡La misma para todos los jugadores!\n\n"
              "Palabras Infinitas: Podrás jugar todas las palabras que quieras, además, "
              "tienes puntos y rachas para desafiarte a ti mismo y a tus amigos.",
          image: Image.asset(introExplanation3),
        ),
        PageViewModel(
          title: "Trofeos",
          body:
          "El juego tiene un apartado en el que puedes consultar tus trofeos. A "
              "medida que completes los desafíos indicados ganarás nuevos trofeos. "
              "¡Si los consigues todos obtendrás el trofeo de diamante!",
          image: Image.asset(introExplanation4),
        ),
      ],
      back: const Text('Anterior', style: TextStyle(color: Colors.grey),),
      next: const Text('Siguiente'),
      done: const Text('¡Vamos allá!', style: TextStyle(fontWeight: FontWeight.bold),),
      onDone: () {
        Navigator.pop(context);
      },
    );
  }

}