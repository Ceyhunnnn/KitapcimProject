import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kitapcim/core/extensions/context_extentions.dart';

// ignore: must_be_immutable
class CommentPageDetail extends StatefulWidget {
  CommentPageDetail({
    Key? key,
    required String this.name,
    required String this.url,
    required String this.author,
    required String this.number,
    required String this.about,
    required String this.bookUid,
  }) : super(key: key);

  var name;
  var url;
  var author;
  var number;
  var about;
  var bookUid;

  @override
  State<CommentPageDetail> createState() => _CommentPageDetailState();
}

class _CommentPageDetailState extends State<CommentPageDetail> {
  var firestore;
  var current_id;
  var sender;

  var firebaseUser = FirebaseAuth.instance.currentUser;
  String comments = "Yorumlar";
  String notFoundComment = "Henüz yorum yapılmamıştır";
  List commentList = [];

  Future<void> userGet() async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseUser!.uid)
        .get()
        .then((gelenVeri) {
      setState(() {
        sender = gelenVeri.data()!['userName'];
      });
    });
  }

  void initState() {
    super.initState();
    userGet();
    firestore = FirebaseFirestore.instance;
    current_id = FirebaseAuth.instance.currentUser!.uid;

    //await getCommentFromFirebase(widget.bookUid);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController content = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: context.appColor,
          title: Text(
            comments,
            style: context.customTextStyle(Colors.white, 20.0),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Image.network(widget.url),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.author}',
                          style: context.customTextStyle(Colors.black, 15.0),
                        ),
                        SizedBox(
                          height: context.dynamicHeight(0.02),
                        ),
                        Text('${widget.name}',
                            style: context.customTextStyle(Colors.black, 15.0)),
                        SizedBox(
                          height: context.dynamicHeight(0.02),
                        ),
                        Text(
                          '${widget.number}',
                          style: context.customTextStyle(Colors.black, 15.0),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                flex: 9,
                child: FutureBuilder(
                    future: getCommentFromFirebase(widget.bookUid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List? comment = snapshot.data as List;
                        return comment.isEmpty
                            ? Center(
                                child: Text(
                                "Henüz yorum yok...",
                                style:
                                    context.customTextStyle(Colors.black, 15.0),
                              ))
                            : ListView.builder(
                                itemCount: comment.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 9,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  //color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          radius: 15,
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  "https://images.pexels.com/photos/46274/pexels-photo-46274.jpeg?auto=compress&cs=tinysrgb&w=1200"),
                                                        ),
                                                        SizedBox(
                                                          width: context
                                                              .dynamicWidth(
                                                                  0.01),
                                                        ),
                                                        Text(
                                                            comment[index]
                                                                    ["sender"]
                                                                .toString(),
                                                            style: context
                                                                .customTextStyle(
                                                                    Colors
                                                                        .black,
                                                                    15.0)),
                                                        Spacer(),
                                                        current_id ==
                                                                comment[index]
                                                                    ["id"]
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    deleteComment(
                                                                            widget
                                                                                .bookUid,
                                                                            comment[index]["sender"]
                                                                                .toString(),
                                                                            comment[index]["content"]
                                                                                .toString(),
                                                                            current_id)
                                                                        .then((value) =>
                                                                            {
                                                                              getCommentFromFirebase(widget.bookUid)
                                                                            });
                                                                  });
                                                                },
                                                                child: FaIcon(
                                                                  FontAwesomeIcons
                                                                      // ignore: deprecated_member_use
                                                                      .trashAlt,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 20,
                                                                ),
                                                              )
                                                            : Text("")
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          comment[index]
                                                                  ["content"]
                                                              .toString(),
                                                          style: context
                                                              .customTextStyle(
                                                                  Colors.black,
                                                                  15.0)),
                                                    ),
                                                    Divider()
                                                  ],
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                  );
                                },
                              );
                      } else {
                        return Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                    })),
            Expanded(
              flex: 3,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: content,
                          decoration: InputDecoration(
                              suffixIcon: InkWell(
                                  onTap: () => {
                                        if (content.text.isNotEmpty)
                                          {
                                            saveComment(widget.bookUid, sender,
                                                content.text, current_id),
                                            content.clear(),
                                            setState(() {
                                              getCommentFromFirebase(
                                                  widget.bookUid);
                                            })
                                          }
                                        else
                                          {
                                            Get.snackbar(
                                              "***Uyarı***",
                                              "Yorum kısmı boş bırakılamaz",
                                              colorText: Colors.white,
                                            )
                                          }
                                      },
                                  child: Icon(Icons.send)),
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(15.0),
                                borderSide: new BorderSide(),
                              ),
                              hintStyle:
                                  context.customTextStyle(Colors.black, 15.0),
                              hintText: "Yorum Yap..."),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Future<String> deleteComment(
    String bookUid,
    String sender,
    String content,
    String current_id,
  ) async {
    String res = "Some error occurred";
    try {
      firestore.collection('Books').doc(bookUid).update({
        'comments': FieldValue.arrayRemove([
          {"content": content, "sender": sender, "id": current_id}
        ]),
      });
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> saveComment(
    String bookUid,
    String sender,
    String content,
    String current_id,
  ) async {
    String res = "Some error occurred";
    try {
      firestore.collection('Books').doc(bookUid).update({
        'comments': FieldValue.arrayUnion([
          {"content": content, "sender": sender, "id": current_id}
        ]),
      });
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<List?> getCommentFromFirebase(String bookUid) async {
    await FirebaseFirestore.instance
        .collection('Books')
        .doc("${bookUid}")
        .get()
        .then((value) => {commentList = value.data()!['comments']});

    return commentList;
  }
}
