import 'package:flutter/material.dart';
import 'package:Encasillado/common/miscellaneous.dart';
import 'package:Encasillado/common/widgets.dart';
import 'package:Encasillado/common/colors.dart';

class WotdEnd extends StatefulWidget {
  @override
  _WotdEndState createState() => _WotdEndState();
}

class _WotdEndState extends State<WotdEnd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBarWithoutButtons(context),
      backgroundColor: appWhite,
      body: SizedBox(),
    );
  }
}