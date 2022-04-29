import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kitapcim/constants/context_extentions.dart';

class VoiceListen extends StatefulWidget {
  const VoiceListen({Key? key}) : super(key: key);
  @override
  State<VoiceListen> createState() => _VoiceListenState();
}

class _VoiceListenState extends State<VoiceListen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.grey,
          backgroundColor: context.appColor,
          title: Text(
            "Kitapları Sesli Dinle",
            style: context.buildTextStyle(20, Colors.white),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/gifs/workss.gif"),
              Icon(
                FontAwesomeIcons.exclamationTriangle,
                size: 25,
                color: Colors.black,
              ),
              SizedBox(
                height: context.dynamicHeight(0.01),
              ),
              Text(
                "Bu bölüm yapım aşamasındadır.",
                style: context.buildTextStyle(15, Colors.black),
              )
            ],
          ),
        ));
  }
}
