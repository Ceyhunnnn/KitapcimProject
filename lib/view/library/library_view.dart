// ignore: import_of_legacy_library_into_null_safe
import 'package:category_picker/category_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitapcim/constants/context_extentions.dart';
import 'package:kitapcim/view/library/library_view_model.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  State<Library> createState() => _LibraryState();
}

final _controller = Get.put(LibraryView());

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [buildTopBar(), buildCategoryPicker(), buildBooksListWidget()],
    );
  }

  CategoryPicker buildCategoryPicker() {
    return CategoryPicker(
      selectedItemBorderColor: Colors.transparent,
      unselectedItemBorderColor: Colors.transparent,
      selectedItemColor: Color(0xffe4dfcc),
      selectedItemTextLightThemeColor: Color(0xff696353),
      unselectedItemTextLightThemeColor: Color(0xff696353),
      items: _controller.booksCategoryList,
      onValueChanged: (value) {
        setState(() {
          print("Category value : " + value.label.toString());
        });
      },
    );
  }
}

class buildBooksListWidget extends StatelessWidget {
  const buildBooksListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          padding: EdgeInsets.all(0),
          scrollDirection: Axis.vertical,
          primary: true,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisSpacing: 20,
            maxCrossAxisExtent: 200,
          ),
          itemCount: _controller.booksGridList.length,
          itemBuilder: (BuildContext context, index) {
            return Image.asset(_controller.booksGridList[index]);
          }),
    );
  }
}

class buildTopBar extends StatelessWidget {
  const buildTopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
        color: Color(0xff05595B),
      ),
      width: context.dynamicWidth(1),
      height: context.dynamicHeight(0.28),
      child: Column(
        children: [
          SizedBox(
            height: context.dynamicHeight(0.01),
          ),
          SizedBox(
            height: context.dynamicHeight(0.03),
          ),
          Row(
            children: [
              SizedBox(
                width: context.dynamicWidth(0.05),
              ),
              Text(
                "Senin için\nen iyi kitaplar!",
                style: context.buildTextStyle(25, Colors.white),
              )
            ],
          ),
          SizedBox(
            height: context.dynamicHeight(0.03),
          ),
          Row(
            children: [
              SizedBox(
                width: context.dynamicWidth(0.05),
              ),
              Text(
                "En sevdiğin kitapları ara",
                style: context.buildTextStyle(14, Colors.white),
              )
            ],
          ),
          SizedBox(
            height: context.dynamicHeight(0.03),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 75, left: 25),
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
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
