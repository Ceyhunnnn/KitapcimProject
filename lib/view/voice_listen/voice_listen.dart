import 'package:audioplayers/audioplayers.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kitapcim/constants/context_extentions.dart';
import 'dart:io' show Platform;

class VoiceListen extends StatefulWidget {
  const VoiceListen({Key? key}) : super(key: key);
  @override
  State<VoiceListen> createState() => _VoiceListenState();
}
//F2F2F2 color code

class _VoiceListenState extends State<VoiceListen> {
  bool playing = false;
  IconData plyButton = Icons.play_arrow;

  late AudioPlayer _player;
  late AudioCache cache;
  Duration position = new Duration();
  Duration musicLength = new Duration();

  Widget slider() {
    return Container(
      width: context.dynamicWidth(0.5),
      child: Slider.adaptive(
          value: position.inSeconds.toDouble(),
          max: musicLength.inSeconds.toDouble(),
          activeColor: Colors.blue,
          inactiveColor: Colors.grey,
          onChanged: (value) {
            seekToSec(value.toInt());
          }),
    );
  }

  //let's create the seek function that will allow us to go to a certain position of the music
  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  //Now let's initialize our player
  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    _player.onDurationChanged.listen((Duration d) {
      print('Max duration: $d');
      setState(() => musicLength = d);
    });

    _player.onAudioPositionChanged
        .listen((Duration p) => {setState(() => position = p)});
  }

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
        body: Platform.isAndroid
            ? buildMp3Player(context)
            : Center(child: NullPageWidget()));
  }

  Container buildMp3Player(BuildContext context) {
    return Container(
        width: context.dynamicWidth(1),
        height: context.dynamicHeight(1),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromARGB(255, 129, 159, 153),
              Color.fromARGB(255, 83, 95, 105)
            ])),
        child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: context.dynamicHeight(0.03),
                ),
                Center(
                  child: Text(
                    "Oynatma Listesi",
                    style: context.buildTextStyle(25, Colors.white),
                  ),
                ),
                Center(
                  child: Container(
                    width: context.dynamicWidth(0.4),
                    height: context.dynamicHeight(0.4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                            image: AssetImage("assets/books/au.jpg"))),
                  ),
                ),
                Center(
                    child: Text("Aşkımız Eski Bir Roman",
                        style: context.buildTextStyle(20, Colors.white))),
                SizedBox(
                  height: context.dynamicHeight(0.05),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: context.dynamicWidth(1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  "${position.inMinutes}:${position.inSeconds.remainder(60)}"),
                              slider(),
                              Text(
                                  "${musicLength.inMinutes}:${musicLength.inSeconds.remainder(60)}"),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {},
                                iconSize: 45,
                                color: Colors.black,
                                icon: Icon(Icons.skip_previous)),
                            IconButton(
                                onPressed: () {
                                  if (!playing) {
                                    cache.play("sound_example.mp3");

                                    setState(() {
                                      plyButton = Icons.pause;
                                      playing = true;
                                    });
                                  } else {
                                    _player.pause();
                                    setState(() {
                                      plyButton = Icons.play_arrow;
                                      playing = false;
                                    });
                                  }
                                },
                                iconSize: 60,
                                color: Colors.black,
                                icon: Container(
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    child: Center(child: Icon(plyButton)))),
                            IconButton(
                                onPressed: () {},
                                iconSize: 45,
                                color: Colors.black,
                                icon: Icon(Icons.skip_next))
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ]),
        ));
  }
}

class NullPageWidget extends StatelessWidget {
  const NullPageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}
