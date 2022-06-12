import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:kitapcim/constants/context_extentions.dart';
import 'package:kitapcim/services/statusService.dart';
import 'package:like_button/like_button.dart';

class buildBooksCards extends StatefulWidget {
  const buildBooksCards({Key? key}) : super(key: key);

  @override
  State<buildBooksCards> createState() => _buildBooksCardsState();
}

class _buildBooksCardsState extends State<buildBooksCards> {
  StatusService _statusService = StatusService();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _statusService.getBookAbout(),
        builder: ((context, snapshot) {
          return !snapshot.hasData
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  padding: EdgeInsets.all(0),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot myBooks = snapshot.data!.docs[index];
                    String photoUrl = '${myBooks['bookUrl']}';
                    return InkWell(
                      onTap: () {
                        print('*************\n'
                            'Kitap Ad : ${myBooks['bookName']}\n'
                            'Kitap Yazar Ad : ${myBooks['bookAuthor']}\n'
                            'Kitap Hakkında : ${myBooks['bookAbout']}\n'
                            'Kitap Url : ${myBooks['bookUrl']}\n'
                            'Kitap Sayfa Sayısı : ${myBooks['bookPageNumber']}\n'
                            '*************');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
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
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      '${myBooks['bookAbout']}',
                                      style: context.buildTextStyle(
                                          15, Colors.black),
                                    ),
                                  ))
                                ],
                              ), //kitaba dair aciklama
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Image.network(photoUrl),
                                      width: context.dynamicWidth(0.20),
                                      height: context.dynamicHeight(0.15),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${myBooks['bookAuthor']}',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                        SizedBox(
                                          height: context.dynamicHeight(0.02),
                                        ),
                                        Text(
                                          '${myBooks['bookName']}',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                        SizedBox(
                                          height: context.dynamicHeight(0.02),
                                        ),
                                        Text(
                                          '${myBooks['bookPageNumber']}',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
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
                                    LikeButton(
                                      countPostion: CountPostion.right,
                                      likeCount: 0,
                                    ),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                        ),
                      ),
                    );
                  });
        }));
  }
}
