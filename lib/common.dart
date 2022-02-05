import 'package:Joadle/user_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

import 'init_view.dart';
import 'word_generator.dart';
import 'colors.dart';
import 'my_keyboard.dart';

/** VARIABLES */

List<String> selectedDatabase = [];

// Device size
double devHeight = 0;
double devWidth = 0;

// Cell control
int currentCell = 0;
int currentRow = 0;
bool canWrite = true;
bool finished = false;

// Content of each cell
List<String> inputMatrix = [
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  ""
];
List<String> colorsArray = [
  "B",
  "B",
  "B",
  "B",
  "B",
  "B",
  "B",
  "B",
  "B",
  "B",
  "B",
  "B",
  "B",
  "B",
  "B",
  "B",
  "B",
  "B",
  "B",
  "B",
  "B",
  "B",
  "B",
  "B",
  "B",
  "B",
  "B",
  "B",
  "B",
  "B"
];

// Word of the day letter by letter
List<String> wordOfTheDayArray = ["", "", "", "", ""];
String wordOfTheDayString = "";
String definitionURL = "https://dle.rae.es/";

// Stats
String infoStats = "";
String emojiStats = "";
DateTime startDate = DateTime.parse("2000-01-01 00:00:00.000000");
DateTime endDate = DateTime.parse("2000-01-01 00:00:00.000000");
Duration playSeconds = endDate.difference(startDate);

/** METHODS & WIDGETS */

AppBar MainAppBar(BuildContext context, bool buttons) {
  AppBar myAppBar;

  if (buttons) {
    myAppBar = AppBar(
      backgroundColor: Color(0xff009688),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset('app_files/my_logo.png'),
          Expanded(child: Text("")),
          Expanded(
            child: RawMaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const explanation_page()));
              },
              elevation: 0,
              child: Image.asset('app_files/help_icon.png'),
              fillColor: Color(0xff007066),
              shape: CircleBorder(),
            ),
          ),
          Expanded(
            child: RawMaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const settings_page()));
              },
              elevation: 0,
              child: Image.asset('app_files/settings_icon.png'),
              fillColor: Color(0xff007066),
              shape: CircleBorder(),
            ),
          ),
        ],
      ),
    );
  } else {
    myAppBar = AppBar(
      backgroundColor: Color(0xff009688),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset('app_files/my_logo.png'),
        ],
      ),
    );
  }
  return myAppBar;
}

AnimatedContainer letterCell(String char, String col) {
  //COLOR SELECTION
  Color? cellColor = myWhite;
  if (col == "V") cellColor = myGreen;
  if (col == "A") cellColor = myYellow;
  if (col == "G") cellColor = myGrey;

  return AnimatedContainer(
    duration: Duration(milliseconds: 750),
    curve: Curves.easeInOutCirc,
    width: (devWidth / 5 - 10.0),
    height: (devWidth / 5 - 10.0),
    margin: const EdgeInsets.fromLTRB(2.0, 6.0, 2.0, 6.0),
    padding: const EdgeInsets.all(0.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: cellColor,
      border: Border.all(color: mySemiBlack, width: 0.0),
    ),
    child: Text(
      char,
      style: TextStyle(fontSize: 45.0, color: myBlack),
    ),
  );
}

Row letterRow(int _from) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      letterCell(inputMatrix[_from], colorsArray[_from]),
      letterCell(inputMatrix[_from + 1], colorsArray[_from + 1]),
      letterCell(inputMatrix[_from + 2], colorsArray[_from + 2]),
      letterCell(inputMatrix[_from + 3], colorsArray[_from + 3]),
      letterCell(inputMatrix[_from + 4], colorsArray[_from + 4]),
    ],
  );
}

Column cellsField() {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 10.0,
        ),
        letterRow(0),
        letterRow(5),
        letterRow(10),
        letterRow(15),
        letterRow(20),
        letterRow(25),
      ]);
}

void word_doesnt_exist_snackbar(BuildContext context) {
  //may cause problems with null sound safety
  Flushbar(
    message: "La palabra no existe",
    duration: Duration(seconds: 3),
    backgroundColor: Colors.redAccent,
    flushbarPosition: FlushbarPosition.TOP,
  ).show(context);
}

_launchURL() async {
  if (await canLaunch(definitionURL)) {
    await launch(definitionURL);
  } else {
    throw 'Could not launch $definitionURL';
  }
}

_launchMYINSTAGRAM() async {
  if (await canLaunch('https://instagram.com/joako.peke')) {
    await launch('https://instagram.com/joako.peke');
  } else {
    throw 'Could not launch https://instagram.com/joako.peke';
  }
}

_launchMYGITHUB() async {
  if (await canLaunch('https://www.github.com/joaquinsolla')) {
    await launch('https://www.github.com/joaquinsolla');
  } else {
    throw 'Could not launch https://www.github.com/joaquinsolla';
  }
}

_launchWORDLE() async {
  if (await canLaunch('https://www.powerlanguage.co.uk/wordle/')) {
    await launch('https://www.powerlanguage.co.uk/wordle/');
  } else {
    throw 'Could not launch https://www.powerlanguage.co.uk/wordle/';
  }
}

_launchJOSH() async {
  if (await canLaunch('https://www.powerlanguage.co.uk/')) {
    await launch('https://www.powerlanguage.co.uk/');
  } else {
    throw 'Could not launch https://www.powerlanguage.co.uk/';
  }
}

class victory_page extends StatelessWidget {
  const victory_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    update_stats();
    infoStats = wordOfTheDayString +
        " - Intentos: " +
        (currentRow + 1).toString() +
        "/6";

    String restartImage;
    if (nightMode) {
      restartImage = 'app_files/restart_icon_without_circle_BLACK.png';
    } else {
      restartImage = 'app_files/restart_icon_without_circle.png';
    }

    return Scaffold(
        backgroundColor: myWhite,
        appBar: MainAppBar(context, false),
        body: Container(
          margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
          alignment: Alignment.topCenter,
          child: ListView(
            children: [
              SizedBox(
                height: 15.0,
              ),
              SizedBox(
                height: 90,
                child: Image.asset('app_files/trophy.png'),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "VICTORIA",
                style: TextStyle(
                  fontSize: 30,
                  color: myBlack,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Estadísticas:",
                  style: TextStyle(
                    fontSize: 17,
                    color: myBlack,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontFamily: 'RaleWay',
                  ),
                ),
              ),
              SizedBox(
                height: 7.5,
              ),
              Text(
                infoStats,
                style: TextStyle(
                  fontSize: 16,
                  color: myBlack,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                emojiStats + "\nTiempo: " + calculate_play_time(),
                style: TextStyle(
                  fontSize: 16,
                  color: myBlack,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "¿No sabes el significado de la palabra?",
                  style: TextStyle(
                    fontSize: 17,
                    color: myBlack,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontFamily: 'RaleWay',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TextButton(
                    onPressed: _launchURL,
                    style: TextButton.styleFrom(
                      primary: myWhite,
                      backgroundColor: Color(0xff009688),
                    ),
                    child: Text("Definición de " + wordOfTheDayString)),
              ]),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Empieza una partida nueva:",
                  style: TextStyle(
                    fontSize: 17,
                    color: myBlack,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontFamily: 'RaleWay',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TextButton(
                    onPressed: () {
                      restart_variables();
                      generateWord();
                      startDate = DateTime.now();
                      Navigator.pop(context);
                      runApp(MyApp());
                    },
                    style: TextButton.styleFrom(
                      primary: myWhite,
                      backgroundColor: Color(0xff009688),
                    ),
                    child: Row(
                      children: [
                        Text("Nueva partida"),
                        SizedBox(
                          width: 6,
                        ),
                        Image.asset(
                          restartImage,
                          scale: 1.3,
                        ),
                      ],
                    )),
              ]),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "¡Compártelo con tus amigos!",
                  style: TextStyle(
                    fontSize: 17,
                    color: myBlack,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontFamily: 'RaleWay',
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RawMaterialButton(
                    onPressed: () {
                      copy_to_clipboard(context);
                    },
                    elevation: 1,
                    child: Image.asset('app_files/clipboard_logo.png'),
                    //Lienzo: 300px , img: 40px
                    fillColor: myGrey,
                    shape: CircleBorder(),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      wpp_share();
                    },
                    elevation: 1,
                    child: Image.asset('app_files/whatsapp_logo.png'),
                    //Lienzo: 280px , img: 40px
                    fillColor: myGreen,
                    shape: CircleBorder(),
                  ),
                ],
              ),
              Expanded(child: Text("")),
              Text(
                "Gracias por jugar a Joadle\n\nJoadle by joa",
                style: TextStyle(
                  fontSize: 12,
                  color: myGrey,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ));
  }
}

class defeat_page extends StatelessWidget {
  const defeat_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    update_stats();
    infoStats = wordOfTheDayString + " - Intentos: X/6";

    String restartImage;
    if (nightMode) {
      restartImage = 'app_files/restart_icon_without_circle_BLACK.png';
    } else {
      restartImage = 'app_files/restart_icon_without_circle.png';
    }

    return Scaffold(
        backgroundColor: myWhite,
        appBar: MainAppBar(context, false),
        body: Container(
          margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
          alignment: Alignment.topCenter,
          child: ListView(
            children: [
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 90,
                child: Image.asset('app_files/defeat.png'),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "DERROTA",
                style: TextStyle(
                  fontSize: 30,
                  color: myBlack,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Estadísticas:",
                  style: TextStyle(
                    fontSize: 17,
                    color: myBlack,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontFamily: 'RaleWay',
                  ),
                ),
              ),
              SizedBox(
                height: 7.5,
              ),
              Text(
                infoStats,
                style: TextStyle(
                  fontSize: 16,
                  color: myBlack,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                emojiStats + "\nTiempo: " + calculate_play_time(),
                style: TextStyle(
                  fontSize: 16,
                  color: myBlack,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "¿No sabes el significado de la palabra?",
                  style: TextStyle(
                    fontSize: 17,
                    color: myBlack,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontFamily: 'RaleWay',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TextButton(
                    onPressed: _launchURL,
                    style: TextButton.styleFrom(
                      primary: myWhite,
                      backgroundColor: Color(0xff009688),
                    ),
                    child: Text("Definición de " + wordOfTheDayString)),
              ]),
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Empieza una partida nueva:",
                  style: TextStyle(
                    fontSize: 17,
                    color: myBlack,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontFamily: 'RaleWay',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TextButton(
                    onPressed: () {
                      restart_variables();
                      generateWord();
                      startDate = DateTime.now();
                      Navigator.pop(context);
                      runApp(MyApp());
                    },
                    style: TextButton.styleFrom(
                      primary: myWhite,
                      backgroundColor: Color(0xff009688),
                    ),
                    child: Row(
                      children: [
                        Text("Nueva partida"),
                        SizedBox(
                          width: 6,
                        ),
                        Image.asset(
                          restartImage,
                          scale: 1.3,
                        ),
                      ],
                    )),
              ]),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "¡Compártelo con tus amigos!",
                  style: TextStyle(
                    fontSize: 17,
                    color: myBlack,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontFamily: 'RaleWay',
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RawMaterialButton(
                    onPressed: () {
                      copy_to_clipboard(context);
                    },
                    elevation: 1,
                    child: Image.asset('app_files/clipboard_logo.png'),
                    //Lienzo: 300px , img: 40px
                    fillColor: myGrey,
                    shape: CircleBorder(),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      wpp_share();
                    },
                    elevation: 1,
                    child: Image.asset('app_files/whatsapp_logo.png'),
                    //Lienzo: 280px , img: 40px
                    fillColor: myGreen,
                    shape: CircleBorder(),
                  ),
                ],
              ),
              Expanded(child: Text("")),
              Text(
                "Gracias por jugar a Joadle\n\nJoadle by joa",
                style: TextStyle(
                  fontSize: 12,
                  color: myGrey,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ));
  }
}

class explanation_page extends StatelessWidget {
  const explanation_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    update_stats();
    infoStats = wordOfTheDayString +
        " - Intentos: " +
        (currentRow + 1).toString() +
        "/6";

    String ex_green;
    String ex_yellow;
    String ex_grey;
    if (colorBlind) {
      ex_green = 'app_files/ex_green_COLORBLIND.png';
      ex_yellow = 'app_files/ex_yellow_COLORBLIND.png';
      ex_grey = 'app_files/ex_grey_COLORBLIND.png';
    } else {
      ex_green = 'app_files/ex_green.png';
      ex_yellow = 'app_files/ex_yellow.png';
      ex_grey = 'app_files/ex_grey.png';
    }

    return Scaffold(
        backgroundColor: myWhite,
        appBar: MainAppBar(context, false),
        body: Container(
          margin: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
          alignment: Alignment.topCenter,
          child: ListView(
            children: [
              SizedBox(
                height: 5,
              ),
              Text(
                "¿Cómo jugar?",
                style: TextStyle(
                  fontSize: 25,
                  color: myBlack,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Tienes 6 intentos para adivinar la palabra oculta, que está compuesta por 5 letras.\n\n"
                "Las palabras que pruebes deben estar en el diccionario.\n\n"
                "Cada vez que pruebes una palabra las casillas cambiarán de color para indicar tu progreso:\n",
                style: TextStyle(
                  fontSize: 16,
                  color: myBlack,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.left,
              ),
              Container(
                height: 40,
                child: Image.asset(ex_green),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "La letra A está en la palabra oculta y va en esa posición\n",
                style: TextStyle(
                  fontSize: 16,
                  color: myBlack,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 40,
                child: Image.asset(ex_yellow),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "La letra E está en la palabra oculta pero no va en esa posición\n",
                style: TextStyle(
                  fontSize: 16,
                  color: myBlack,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 40,
                child: Image.asset(ex_grey),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "La letra T no está en la palabra oculta\n",
                style: TextStyle(
                  fontSize: 16,
                  color: myBlack,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.none,
                  fontFamily: 'RaleWay',
                ),
                textAlign: TextAlign.left,
              ),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(child: Text("")),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          primary: myWhite,
                          backgroundColor: Color(0xff009688),
                        ),
                        child: Text("VAMOS ALLÁ")),
                    Expanded(child: Text("")),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class settings_page extends StatelessWidget {
  const settings_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String githubLogo;
    if(nightMode) githubLogo = 'app_files/github_logo_BLACK.png';
      else githubLogo = 'app_files/github_logo.png';

    return Scaffold(
        backgroundColor: myWhite,
        appBar: MainAppBar(context, false),
        body: Container(
            margin: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Text(
                  "Ajustes",
                  style: TextStyle(
                    fontSize: 30,
                    color: myBlack,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontFamily: 'RaleWay',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //DALTONISMO
                    Text(
                      "Filtro para daltonismo:",
                      style: TextStyle(
                        fontSize: 16,
                        color: myBlack,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none,
                        fontFamily: 'RaleWay',
                      ),
                    ),
                    Expanded(child: Text("")),
                    Switch(
                      value: colorBlind,
                      onChanged: (value) {
                        colorBlind = (!colorBlind);
                        runApp(MyApp());
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),

                //MODO OSCURO
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //DALTONISMO
                    Text(
                      "Modo oscuro:",
                      style: TextStyle(
                        fontSize: 16,
                        color: myBlack,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none,
                        fontFamily: 'RaleWay',
                      ),
                    ),
                    Expanded(child: Text("")),
                    Switch(
                      value: nightMode,
                      onChanged: (value) {
                        nightMode = (!nightMode);
                        runApp(MyApp());
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Expanded(child: Text("")),
                Divider(
                  color: myGrey,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "\nSoy Joaquín, estudiante de ingeniería informática. "
                      "Espero que disfrutes mi app tanto como yo he disfrutado hacerla."
                      "\n\nPuedes encontrarme en:\n",
                      style: TextStyle(
                        fontSize: 12,
                        color: myGrey,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                        fontFamily: 'RaleWay',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    //INSTAGRAM BUTTON
                    TextButton(
                      onPressed: _launchMYINSTAGRAM, child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset('app_files/instagram_logo.png', scale: 19.5,),
                        SizedBox(width: 20,),
                        Text(
                          "Instagram",
                          style: TextStyle(
                            fontSize: 14,
                            color: myGrey,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                            fontFamily: 'RaleWay',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),),

                    SizedBox(height: 5,),
                    //GITHUB BUTTON
                    TextButton(
                      onPressed: _launchMYGITHUB, child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(githubLogo, scale: 13.5,),
                        SizedBox(width: 20,),
                        Text(
                          "GitHub",
                          style: TextStyle(
                            fontSize: 14,
                            color: myGrey,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                            fontFamily: 'RaleWay',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),),
                    SizedBox(height: 5,),
                    Divider(
                      color: myGrey,
                    ),
                    Text(
                      "\nAdaptación para Android en español de",
                      style: TextStyle(
                        fontSize: 12,
                        color: myGrey,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                        fontFamily: 'RaleWay',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 60,
                          child: TextButton(
                            onPressed: _launchWORDLE,
                            style: TextButton.styleFrom(
                              primary: myGrey,
                            ),
                            child: Text("Wordle"),
                          ),
                        ),
                        Text(
                          "de",
                          style: TextStyle(
                            fontSize: 12,
                            color: myGrey,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                            fontFamily: 'RaleWay',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          width: 100,
                          child: TextButton(
                            onPressed: _launchJOSH,
                            style: TextButton.styleFrom(
                              primary: myGrey,
                            ),
                            child: Text("Josh Wardle"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(
                  height: 20,
                ),
              ],
            )));
  }
}

class new_game extends StatelessWidget {
  const new_game({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(context, true),
      body: Column(children: [
        cellsField(),
        Expanded(
          child: Text(""),
        ),
        generate_keyboard(context),
      ]),
    );
  }
}

void update_stats() {
  bool lineUsed = false;
  emojiStats = "";
  for (var i = 0; i < colorsArray.length; i += 5) {
    lineUsed = false;
    for (var j = i; j < i + 5; j++) {
      if (colorsArray[j] == "V") {
        emojiStats += "🟩";
        lineUsed = true;
      }
      if (colorsArray[j] == "A") {
        emojiStats += "🟨";
        lineUsed = true;
      }
      if (colorsArray[j] == "G") {
        emojiStats += "⬜";
        lineUsed = true;
      }
    }
    if (lineUsed) emojiStats += "\n";
  }
}

void copy_to_clipboard(BuildContext context) {
  String text = infoStats +
      "\n" +
      emojiStats +
      "Tiempo: " +
      calculate_play_time() +
      "\n\nJoadle by joa\nhttps://instagram.com/joako.peke";
  Clipboard.setData(ClipboardData(text: text));
  //may cause problems with null sound safety
  Flushbar(
    message: "Copiado al portapapeles",
    duration: Duration(milliseconds: 2500),
    backgroundColor: myGrey,
    flushbarPosition: FlushbarPosition.BOTTOM,
  ).show(context);
}

Future<void> wpp_share() async {
  String text = infoStats +
      "\n" +
      emojiStats +
      "Tiempo: " +
      calculate_play_time() +
      "\n\nJoadle by joa\nhttps://instagram.com/joako.peke";
  await WhatsappShare.share(
    text: text,
    linkUrl: '',
    phone: '911234567890',
  );
}

String calculate_play_time() {
  int hours;
  int minutes;
  int seconds;

  hours = playSeconds.inHours;
  minutes = playSeconds.inMinutes - hours * 60;
  seconds = playSeconds.inSeconds - hours * 60 * 60 - minutes * 60;

  String h = hours.toString().padLeft(2, '0');
  String m = minutes.toString().padLeft(2, '0');
  String s = seconds.toString().padLeft(2, '0');

  return (h + ":" + m + ":" + s);
}

void restart_variables() {
// Cell control
  currentCell = 0;
  currentRow = 0;
  canWrite = true;
  finished = false;

// Content of each cell
  inputMatrix = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
  ];
  colorsArray = [
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B",
    "B"
  ];

// Word of the day letter by letter
  wordOfTheDayArray = ["", "", "", "", ""];
  wordOfTheDayString = "";
  definitionURL = "https://dle.rae.es/";

// Stats
  infoStats = "";
  emojiStats = "";
  startDate = DateTime.parse("2000-01-01 00:00:00.000000");
  endDate = DateTime.parse("2000-01-01 00:00:00.000000");
  playSeconds = endDate.difference(startDate);

  greenKeys = [];
  yellowKeys = [];
  greyKeys = [];
}
