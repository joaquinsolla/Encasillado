import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/widgets.dart';
import 'package:Encasillado/common/colors.dart';
import 'package:Encasillado/common/imagepaths.dart';
import 'package:Encasillado/common/methods.dart';
import 'package:Encasillado/common/urls.dart';
import 'package:flutter/services.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  _read_colorblind() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'colorblind';
    final value = prefs.getBool(key) ?? false;
    print('read: $value for colorblind');
    if (value == true){
      setState(() {
        colorBlind = value;
        appGreen = Colors.orange;
        appYellow = Colors.blue;
        greenEmoji = "🟧";
        yellowEmoji = "🟦";
      });
    } else {
      setState(() {
        colorBlind = value;
        appGreen = Colors.green;
        appYellow = Color(0xfff3d500);
        greenEmoji = "🟩";
        yellowEmoji = "🟨";
      });
    }
  }

  _save_colorblind(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'colorblind';
    prefs.setBool(key, value);
    print('saved $value');
  }

  _read_darkmode() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'darkmode';
    final value = prefs.getBool(key) ?? false;
    print('read: $value for darkmode');
    if (value == true){
      setState(() {
        darkMode = true;
        appBlack = Colors.white;
        appWhite = Color(0xff2d2d2d);
        appSemiBlack = Colors.white;
        whiteEmoji = "⬛";
        keyColor = Color(0xff131313);
      });
    } else {
      setState(() {
        darkMode = false;
        appBlack = Colors.black;
        appWhite = Colors.white;
        appSemiBlack = Colors.black54;
        whiteEmoji = "⬜";
        keyColor = Color(0xffefefef);
      });
    }
  }

  _save_darkmode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'darkmode';
    prefs.setBool(key, value);
    print('saved $value');
  }
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    late String myGithubImage;
    if (darkMode) {
      myGithubImage = githubImgDarkmode;
    } else {
      myGithubImage = githubImgLightmode;
    }

    return Scaffold(
      appBar: myAppBarWithoutButtonsAndBackArrow(context),
      backgroundColor: appWhite,
        body: Container(
            margin: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
            alignment: Alignment.topCenter,
            child: ListView(
              addAutomaticKeepAlives: true,
              children: [
                headerText('Ajustes'),
                SizedBox(
                  height: 15,
                ),
                settingsRow(
                  'Filtro para daltonismo:',
                  Switch(
                    value: colorBlind,
                    onChanged: (value) {
                      _save_colorblind(value);
                      _read_colorblind();
                    },
                  ),),
                settingsRow(
                  'Modo oscuro:',
                  Switch(
                    value: darkMode,
                    onChanged: (value) {
                      _save_darkmode(value);
                      _read_darkmode();
                    },
                  ),
                ),
                if (deviceWidth < 340) settingsRow(
                  'Anuncios:',
                  Switch(
                    value: showAds,
                    onChanged: (value) {
                      setState(() {
                        showAds = (!showAds);
                      });
                    },
                  ),
                ),
                if (deviceWidth >= 340) settingsRowAdvanced(
                  'Anuncios:', 'Apóyame como desarrollador independiente.',
                  Switch(
                    value: showAds,
                    onChanged: (value) {
                      setState(() {
                        showAds = (!showAds);
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/home');
                          },
                          style: TextButton.styleFrom(
                            primary: appWhite,
                            backgroundColor: appMainColor,
                          ),
                          child: Text("APLICAR")),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  color: appGrey,
                ),
                SizedBox(
                  height: 5,
                ),
                settingsRowAdvanced(
                  'Cómo jugar', '¿Necesitas ayuda para jugar?',
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/help');
                      },
                      style: TextButton.styleFrom(
                        primary: appWhite,
                        backgroundColor: appMainColor,
                      ),
                      child: Text("AYUDA")),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  color: appGrey,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    smallText(
                        '\nSoy Joaquín, estudiante de ingeniería informática. '
                            'Espero que disfrutes mi app tanto como yo he disfrutado hacerla.'
                            '\n\nPuedes encontrarme en:\n'),
                    socialsButton(
                        myInstagramUrl, instagramImg, 19.5, 'Instagram'),
                    SizedBox(
                      height: 5,
                    ),
                    socialsButton(myGitHubUrl, myGithubImage, 13.5, 'GitHub'),
                    SizedBox(
                      height: 5,
                    ),
                    socialsButton(
                        myWebsiteUrl, myWebsiteImg, 13.5, 'Mi página web'),
                    SizedBox(
                      height: 5,
                    ),
                    socialsButton(
                        myPlayStoreDevUrl, playStoreImg, 32.5, 'Play Store'),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: appGrey,
                    ),
                    smallText('\nApp basada en el juego original '),
                    Container(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Text("")),
                          TextButton(
                              onPressed: () {
                                url_launcher(wordleUrl);
                              },
                              style: TextButton.styleFrom(
                                primary: appGrey,
                              ),
                              child: Text("Wordle"),
                            ),
                          smallText("de"),
                          TextButton(
                              onPressed: () {
                                url_launcher(joshWardleUrl);
                              },
                              style: TextButton.styleFrom(
                                primary: appGrey,
                              ),
                              child: Text("Josh Wardle"),
                            ),
                          Expanded(child: Text("")),
                        ],
                      ),
                    ),
                    Divider(
                      color: appGrey,
                    ),
                    smallText(
                        '\nPuedes contactarme para reportar errores o comunicar sugerencias:'),
                    Container(
                      height: 40,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                mail_to(myDevEmail);
                              },
                              style: TextButton.styleFrom(
                                primary: appGrey,
                              ),
                              child: Text(
                                "Contacto",
                                style: TextStyle(fontSize: 12.5),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            TextButton(
                              onPressed: () {
                                url_launcher(privacyPolicyUrl);
                              },
                              style: TextButton.styleFrom(
                                primary: appGrey,
                              ),
                              child: Text(
                                "Política de privacidad",
                                style: TextStyle(fontSize: 12.5),
                              ),
                            ),
                          ]),
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