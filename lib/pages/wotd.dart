import 'package:flutter/material.dart';
import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/widgets.dart';
import 'package:Encasillado/common/colors.dart';

class Wotd extends StatefulWidget {
  @override
  _WotdState createState() => _WotdState();
}

class _WotdState extends State<Wotd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBarWithoutButtons(context),
      backgroundColor: appWhite,
      body: SizedBox(),
    );
  }
}