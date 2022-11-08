import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitapcim/components/userComment.dart';
import 'package:kitapcim/constants/context_extentions.dart';

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
    print("Giris yapili kullanici : " + current_id);
    print("Acilan Kitap Uid : ${widget.bookUid}");
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController content = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: context.appColor,
          title: Text("Yorumlar"),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Image.network(widget.url),
                      width: context.dynamicWidth(0.20),
                      height: context.dynamicHeight(0.15),
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
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        SizedBox(
                          height: context.dynamicHeight(0.02),
                        ),
                        Text(
                          '${widget.name}',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        SizedBox(
                          height: context.dynamicHeight(0.02),
                        ),
                        Text(
                          '${widget.number}',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                flex: 9,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      UserComment(
                        userId: "Ergga0QZOHecK3iMytoHytnfjjF3",
                        content: "content",
                        sender: "sender",
                      ),
                    ],
                  ),
                )),
            Expanded(
              flex: 2,
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
                                        print(
                                            "Yorum yapan kisi : ${sender}\n Yorum : ${content.text}\n yorum yapan id : ${current_id}"),
                                        saveComment(widget.bookUid, sender,
                                            content.text, current_id)
                                      },
                                  child: Icon(Icons.send)),
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(15.0),
                                borderSide: new BorderSide(),
                              ),
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
}
