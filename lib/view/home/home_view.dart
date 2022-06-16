import 'dart:io' show Platform;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:kitapcim/constants/context_extentions.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

import '../../components/bookCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      print("name : $name");
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userGet();
    });
    print("Home Page Inıt");
    super.initState();
  }

  List<String> listPhoto = [
    "assets/books/as.png",
    "assets/books/au.jpg",
    "assets/books/tcr.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RawScrollbar(
        child: CustomScrollView(
          clipBehavior: Clip.hardEdge,
          slivers: [
            SliverAppBar(
              stretch: true,
              collapsedHeight: Platform.isAndroid
                  ? context.dynamicHeight(0.15)
                  : Platform.isIOS
                      ? context.dynamicHeight(0.12)
                      : context.dynamicHeight(0.15),
              pinned: true,
              forceElevated: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              expandedHeight: context.dynamicHeight(0.12),
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
          "Sizin için seçilenler",
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
        padding: EdgeInsets.only(top: context.dynamicHeight(0.05)),
        //margin: EdgeInsets.only(top: context.dynamicHeight(0.05)),
        color: Color(0xff05595B),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: context.dynamicWidth(0.03),
                ),
                Image.asset(
                  "assets/icons/avataricon.png",
                  width: context.dynamicWidth(0.1),
                ),
                SizedBox(
                  width: context.dynamicWidth(0.03),
                ),
                Text(
                  "Merhaba $name",
                  style: buildTextStyle(20, Colors.white),
                )
              ],
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            buildSearchBar(),
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
      items: listPhoto.map<Widget>((index) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
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

class buildSearchBar extends StatelessWidget {
  const buildSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
          cursorColor: Colors.white,
          decoration: const InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: "Kitap arayın",
              hintStyle: TextStyle(color: Colors.white)),
        )),
        InkWell(
          onTap: () {
            buildMessageAlert(context);
          },
          child: Icon(
            Icons.message,
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: context.dynamicWidth(0.05),
        )
      ],
    );
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
}
