// ignore: import_of_legacy_library_into_null_safe

// ignore: import_of_legacy_library_into_null_safe
// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:kitapcim/constants/context_extentions.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
part "library_string_value.dart";

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  final _LibraryStringValue values = _LibraryStringValue();
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
    buildBookListWidget(values);
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
              Expanded(flex: 3, child: buildTopBar(context, values)),
              Expanded(flex: 1, child: buildCategory()),
              Expanded(flex: 6, child: buildBookListWidget(values))
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
                        child: Column(
                          children: [
                            Text(
                              categoryItems[index],
                              style:
                                  context.customTextStyle(Colors.black, 20.0),
                            ),
                            SizedBox(
                              height: context.dynamicHeight(0.005),
                            ),
                            selectedItemCategory == categoryItems[index]
                                ? CircleAvatar(
                                    radius: 5,
                                    backgroundColor: Color(0xff05595B),
                                  )
                                : Text("")
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ));
        }));
  }

  buildBookListWidget(values) {
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
                        values.close,
                        style: context.customTextStyle(Colors.white, 20.0),
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

  void bookListUpdate(selectedItemCategory) async {
    photoList.clear();
    bookAbout.clear();
    bookName.clear();
    await FirebaseFirestore.instance.collection('Books').get().then((value) {
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

  Container buildTopBar(BuildContext context, values) {
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
                      "${values.forYou}\n${values.theBestBooks}",
                      style: context.customTextStyle(Colors.white, 30.0),
                    ),
                  ],
                )),
            Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Text(
                      values.findLoveBook,
                      style: context.customTextStyle(Colors.white, 20.0),
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
                      hintStyle: context.customTextStyle(Colors.white, 15.0),
                      hintText: values.bookName,
                      prefixIcon: Icon(Icons.search),
                      fillColor: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
