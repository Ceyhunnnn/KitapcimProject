import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitapcim/core/extensions/context_extentions.dart';

class MessageDetailView extends StatefulWidget {
  MessageDetailView(
      {Key? key,
      required this.userName,
      required this.messageId,
      required this.otherUser})
      : super(key: key);

  @override
  State<MessageDetailView> createState() => _MessageDetailViewState();
  final String userName;
  final String messageId;
  final String otherUser;
}

class _MessageDetailViewState extends State<MessageDetailView> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var mes1;
  var mes2;
  var firebaseUser = FirebaseAuth.instance.currentUser!.uid;

  var isLoading = false;
  List chatDoc = [];
  List meesageFromFirebase = [];
  List messeageList = [];
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    messageCreateAndGet();
  }

  void buildChangeState() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> getDoc() async {
    // buildChangeState();

    chatDoc.clear();
    await _firestore.collection("chats").snapshots().listen((event) {
      event.docs.forEach((element) {
        chatDoc.add(element.id);
      });
    });
  }

  Future<void> getMessage(String uid) async {
    await FirebaseFirestore.instance.collection('chats').doc(uid).get().then(
        (value) async => {
              messeageList = await value.data()!['messages'],
              print(messeageList)
            });
  }

  buildCreateDocument(String uid) async {
    print(uid);
    print("ile başlayan olacak");
    await _firestore.collection('chats').doc(uid).set({'messages': []});
    //konusma alani olmamasinan karsin document olusturan metottur.
  }

  Future<void>? messageCreateAndGet() {
    getDoc();
    Future.delayed(Duration(seconds: 1)).then((value) async => {
          mes1 = chatDoc.contains(widget.messageId),
          mes2 = chatDoc.contains(widget.otherUser),
          if (chatDoc.contains(widget.messageId) ||
              chatDoc.contains(widget.otherUser))
            {
              print("var, konuşmalar gelecek"),
              if (mes1)
                {
                  print("mes1 den gelecek"),
                  await getMessage(widget.messageId),
                }
              else if (mes2)
                {
                  print("mes2 den gelecek"),
                  setState(() {
                    getMessage(widget.otherUser);
                  }),
                },
            }
          else
            {
              buildCreateDocument(widget.otherUser),
              print(widget.otherUser.toString() + " document created")
            },
          // buildChangeState(),
        });
  }

  sendMessage() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userName),
        backgroundColor: context.appColor,
      ),
      body: Container(
        decoration: context.customBackgroundStyle,
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: messeageList.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: messeageList[index]["sendBy"] ==
                                    firebaseUser.toString()
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  messeageList[index]["content"],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )),
                      );
                    }))),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: messageController,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.grey,
                    decoration: new InputDecoration(
                        suffixIconColor: Colors.white,
                        suffixIcon: InkWell(
                            onTap: () {
                              print("messageController");
                            },
                            child: Icon(Icons.send)),
                        isDense: true,
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: "Mesaj Yaz...",
                        hintStyle: TextStyle(color: Colors.white),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
