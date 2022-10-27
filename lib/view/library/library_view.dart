// ignore: import_of_legacy_library_into_null_safe
import 'package:category_picker/category_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitapcim/constants/context_extentions.dart';
import 'package:kitapcim/services/statusService.dart';
import 'package:kitapcim/view/library/library_view_model.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  State<Library> createState() => _LibraryState();
}

final _controller = Get.put(LibraryView());

class _LibraryState extends State<Library> {
  StatusService _statusService = StatusService();
  var categoryName = "Rastgele";
  var initSelected = 0;
  var photoList = [];

  void initState() {
    initSelected = 0;
    super.initState();
    _statusService.getBookAbout();
    buildBookListWidget();

    bookListUpdate(categoryName);
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
              Expanded(flex: 1, child: buildCategoryPicker(initSelected)),
              Expanded(flex: 6, child: buildBookListWidget())
            ],
          ),
        ),
      ),
    );
  }

  buildBookListWidget() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisSpacing: 20,
          maxCrossAxisExtent: 200,
        ),
        padding: EdgeInsets.all(0),
        shrinkWrap: true,
        itemCount: photoList.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                Get.snackbar("Uyarı", "deneme");
              },
              child: Image.network(photoList[index]));
        });
  }

  void bookListUpdate(categoryName) {
    photoList.clear();
    print(photoList);

    FirebaseFirestore.instance.collection('Books').get().then((value) {
      for (var i in value.docs) {
        setState(() {
          if (i.data()["category"] == categoryName) {
            photoList.add(i.data()["bookUrl"]);
          }
        });
      }
      print(photoList);
    });
  }

  CategoryPicker buildCategoryPicker(initSelected) {
    return CategoryPicker(
      selectedItemBorderColor: Colors.transparent,
      unselectedItemBorderColor: Colors.transparent,
      selectedItemColor: Color(0xffe4dfcc),
      selectedItemTextLightThemeColor: Color(0xff696353),
      unselectedItemTextLightThemeColor: Color(0xff696353),
      items: _controller.booksCategoryList,
      onValueChanged: (value) {
        setState(() {
          categoryName = value.label.toString();
          bookListUpdate(categoryName);
        });
      },
    );
  }
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
