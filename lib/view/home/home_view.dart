import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:kitapcim/constants/context_extentions.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

import '../../components/bookCard.dart';
part "home_string_values.dart";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _HomeStringValues values = _HomeStringValues();
  var isLoading = false;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  var name;
  Future<void> userGet() async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseUser!.uid)
        .get()
        .then((gelenVeri) {
      setState(() {
        name = gelenVeri.data()!['userName'];
      });
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userGet();
      getBookInfo();
    });
    super.initState();
  }

  List photoList = [];
  var profilePhoto =
      "https://images.pexels.com/photos/46274/pexels-photo-46274.jpeg?auto=compress&cs=tinysrgb&w=1200";

  Future<void> getBookInfo() async {
    FirebaseFirestore.instance.collection('Books').get().then((value) {
      for (var i in value.docs) {
        photoList.add(i.data()["bookUrl"]);
      }
    });
    isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RawScrollbar(
        child: CustomScrollView(
          clipBehavior: Clip.hardEdge,
          slivers: [
            SliverAppBar(
              stretch: false,
              collapsedHeight: 75,
              pinned: true,
              forceElevated: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: [
                    buildTopBar(context),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(Widgets()),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> Widgets() {
    return [
      buildCarouselSlider(context),
      Divider(
        thickness: 1,
      ),
      Center(
        child: Text(
          values.forYou,
          style: buildTextStyle(20, Colors.black),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: buildBooksCards(),
      ),
    ];
  }

  Expanded buildTopBar(BuildContext context) {
    return Expanded(
      child: Container(
        color: Color(0xff05595B),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 15, // Image radius
                      backgroundImage: NetworkImage(profilePhoto),
                    ),
                    SizedBox(
                      width: context.dynamicWidth(0.03),
                    ),
                    Text(
                      "${values.hello} $name",
                      style: buildTextStyle(20, Colors.white),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        buildMessageAlert(context);
                      },
                      child: Icon(
                        Icons.message,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  CarouselSlider buildCarouselSlider(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: context.dynamicHeight(0.25),
        enlargeCenterPage: true,
        autoPlay: true,
      ),
      items: photoList.map<Widget>((index) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: isLoading == false
                  ? Center(
                      child: CircularProgressIndicator(
                      color: context.appColor,
                    ))
                  : Image.network(
                      index.toString(),
                    ),
            );
          },
        );
      }).toList(),
    );
  }

  TextStyle buildTextStyle(double fontSize, Color color) {
    return GoogleFonts.comfortaa(fontSize: fontSize, color: color);
  }
}

Future<bool?> buildMessageAlert(BuildContext context) {
  return Alert(
    context: context,
    type: AlertType.info,
    title: "Kitapçım",
    desc: "Bu özellik yakın zamanda sizlerle.",
    buttons: [
      DialogButton(
        color: Color(0xff05595B),
        child: Text(
          "Kapat",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
      )
    ],
  ).show();
}
