import 'package:carousel_slider/carousel_slider.dart';
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
              collapsedHeight: context.dynamicHeight(0.15),
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
      SizedBox(
        height: context.dynamicHeight(0.015),
      ),
      Divider(
        thickness: 2,
      ),
      Center(
        child: Text(
          "Sizin için seçilenler",
          style: buildTextStyle(20, Colors.black),
        ),
      ),
      SingleChildScrollView(
          //builBooksList(),
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildBooksCards(
              context: context,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildBooksCards(
              context: context,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildBooksCards(
              context: context,
            ),
          ),
        ],
      )),
    ];
  }

  Expanded buildTopBar(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(
          top:context.dynamicHeight(0.05)
        ),
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
                  "Merhaba Ceyhun",
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
        enlargeCenterPage: true,
        autoPlay: true,
        height: context.dynamicHeight(0.30),
      ),
      items: listPhoto.map<Widget>((index) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                  child: Center(child: Image.asset(index.toString()))),
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

class builBooksList extends StatelessWidget {
  const builBooksList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.asset("assets/books/as.png",
                        width: context.dynamicWidth(0.25),
                        height: context.dynamicHeight(0.12)),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                        "Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması"),
                  )),
                ],
              ),
            )),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                          "Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması"),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset("assets/books/au.jpg",
                          width: context.dynamicWidth(0.25),
                          height: context.dynamicHeight(0.12))),
                ],
              ),
            )),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.asset("assets/books/as.png",
                        width: context.dynamicWidth(0.25),
                        height: context.dynamicHeight(0.12)),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                        "Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması"),
                  )),
                ],
              ),
            )),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                          "Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması"),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset("assets/books/au.jpg",
                          width: context.dynamicWidth(0.25),
                          height: context.dynamicHeight(0.12))),
                ],
              ),
            )),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.asset("assets/books/tcr.png",
                        width: context.dynamicWidth(0.25),
                        height: context.dynamicHeight(0.12)),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                        "Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması Kitap Açıklaması"),
                  )),
                ],
              ),
            )),
      ],
    );
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
