// ignore: import_of_legacy_library_into_null_safe

// ignore: import_of_legacy_library_into_null_safe
// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:kitapcim/constants/context_extentions.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  var photoList = [];
  var bookAbout = [];
  var bookName = [];
  var categoryItems = [
    "Rastgele",
    "Olay",
    "Biyografi",
    "Tarih",
  ];
  var selectedItemCategory = "Rastgele";

  void initState() {
    super.initState();
    buildBookListWidget();
    bookListUpdate(selectedItemCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: context.dynamicHeight(1),
          child: Column(
            children: [
              Expanded(flex: 3, child: buildTopBar(context)),
              Expanded(flex: 1, child: buildCategory()),
              Expanded(flex: 6, child: buildBookListWidget())
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategory() {
    return ListView.builder(
        itemCount: categoryItems.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          return GestureDetector(
              onTap: () {
                selectedItemCategory = categoryItems[index];
                bookListUpdate(selectedItemCategory);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          categoryItems[index],
                          style: TextStyle(
                              fontSize: 19,
                              color:
                                  categoryItems[index] == selectedItemCategory
                                      ? Colors.white
                                      : Colors.black),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: categoryItems[index] == selectedItemCategory
                            ? Color.fromARGB(255, 156, 153, 147)
                            : Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ));
        }));
  }

  buildBookListWidget() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisSpacing: 5,
          maxCrossAxisExtent: 150,
        ),
        padding: EdgeInsets.all(0),
        shrinkWrap: true,
        itemCount: photoList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                Alert(
                  context: context,
                  title: "${bookName[index]}",
                  desc: "${bookAbout[index]}",
                  buttons: [
                    DialogButton(
                      // gradient: Gradient(colors: [Colors.red, Colors.black]),
                      color: Color(0xff05595B),
                      child: Text(
                        "Kapat",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ).show();
              });
            },
            child: Image.network(
              photoList[index],
            ),
          );
        });
  }

  void bookListUpdate(selectedItemCategory) {
    photoList.clear();
    bookAbout.clear();
    bookName.clear();
    FirebaseFirestore.instance.collection('Books').get().then((value) {
      for (var i in value.docs) {
        setState(() {
          if (i.data()["category"] == selectedItemCategory) {
            photoList.add(i.data()["bookUrl"]);
            bookAbout.add(i.data()["bookAbout"]);
            bookName.add(i.data()["bookName"]);
          }
        });
      }
    });
  }

  Container buildTopBar(BuildContext context) {
    var bookForYou = "Senin için\nen iyi kitaplar!";
    var findLoveBook = "En sevdiğin kitapları ara";
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(35)),
        color: Color(0xff05595B),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Spacer(),
            Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Text(
                      bookForYou,
                      style: context.buildTextStyle(25, Colors.white),
                    ),
                  ],
                )),
            Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Text(
                      findLoveBook,
                      style: context.buildTextStyle(14, Colors.white),
                    ),
                  ],
                )),
            Expanded(
                flex: 2,
                child: TextFormField(
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Kitap adı",
                      prefixIcon: Icon(Icons.search),
                      fillColor: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
