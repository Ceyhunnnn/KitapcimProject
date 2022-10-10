import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:kitapcim/components/bookComment.dart';
import 'package:kitapcim/constants/context_extentions.dart';
import 'package:kitapcim/services/statusService.dart';

class buildBooksCards extends StatefulWidget {
  const buildBooksCards({Key? key}) : super(key: key);

  @override
  State<buildBooksCards> createState() => _buildBooksCardsState();
}

var name;
var about;
var url;
var author;
var number;
var bookUid;
// ignore: unused_element
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final current_id = FirebaseAuth.instance.currentUser!.uid;

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
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
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
                                    GestureDetector(
                                      child: Icon(Icons.favorite,
                                          color: Colors.red),
                                    ),
                                    SizedBox(
                                      width: context.dynamicWidth(0.03),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          name = '${myBooks['bookName']}';
                                          author = '${myBooks['bookAuthor']}';
                                          number =
                                              '${myBooks['bookPageNumber']}';
                                          url = '${myBooks['bookUrl']}';
                                          about = '${myBooks['bookAbout']}';
                                        });
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  CommentPageDetail(
                                                      name: name,
                                                      url: url,
                                                      author: author,
                                                      number: number,
                                                      about: about)),
                                        );
                                        print("Girilen Sayfa Index : " +
                                            index.toString());
                                      },
                                      child: Icon(
                                        Icons.comment_bank_outlined,
                                      ),
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

// Future<String> likePost(String bookUid, String current_id, likes) async {
//   String res = "Some error occurred";
//   try {
//     if (likes.contains(current_id)) {
//       // if the likes list contains the user uid, we need to remove it
//       _firestore.collection('Books').doc(bookUid).update({
//         'likes': FieldValue.arrayRemove([current_id])
//       });
//     } else {
//       // else we need to add uid to the likes array
//       _firestore.collection('Books').doc(bookUid).update({
//         'likes': FieldValue.arrayUnion([current_id])
//       });
//     }
//     res = 'success';
//   } catch (err) {
//     res = err.toString();
//   }
//   return res;
// }
