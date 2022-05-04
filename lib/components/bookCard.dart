import "package:flutter/material.dart";
import 'package:kitapcim/constants/context_extentions.dart';
import 'package:like_button/like_button.dart';

class buildBooksCards extends StatelessWidget {
  const buildBooksCards({
    Key? key,
    required this.context,
  }) : super(key: key);
  final BuildContext context;
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Kitaba ait açıklama bu kısımda yer almaktadır. "
                  "Kısa ve öz bir şekilde açıklama eklenmelidir.",
                  style: context.buildTextStyle(18, Colors.black),
                ),
              ))
            ],
          ), //kitaba dair aciklama
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Image.asset("assets/books/au.jpg"),
                  width: context.dynamicWidth(0.20),
                  height: context.dynamicHeight(0.15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Ahmet Ümit"),
                    SizedBox(
                      height: context.dynamicHeight(0.02),
                    ),
                    Text(
                      "Aşkımız Eski Bir Roman",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: context.dynamicHeight(0.02),
                    ),
                    Text("250 Sayfa"),
                  ],
                ),
              )
            ],
          ), //kitap bilgileri
          Divider(
            indent: 10,
            endIndent: 10,
            thickness: 2,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                LikeButton(countPostion: CountPostion.right, likeCount: 0),
                SizedBox(
                  width: context.dynamicWidth(0.03),
                ),
                Icon(
                  Icons.comment_bank_outlined,
                ),
                SizedBox(
                  width: context.dynamicWidth(0.05),
                ),
                Icon(
                  Icons.ios_share,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.save),
                      SizedBox(
                        width: context.dynamicWidth(0.03),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
