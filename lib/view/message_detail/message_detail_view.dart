import 'package:cloud_firestore/cloud_firestore.dart';
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
  var isLoading = false;
  List message = [
    {
      "content": "selam",
      "date": DateTime.now().subtract(Duration(minutes: 1)),
      "isSendByMe": true
    },
    {
      "content": "Naber",
      "date": DateTime.now().subtract(Duration(minutes: 1)),
      "isSendByMe": false
    },
    {
      "content": "iyidir, senden naber",
      "date": DateTime.now().subtract(Duration(minutes: 1)),
      "isSendByMe": true
    },
    {
      "content": "iyi ben de :)",
      "date": DateTime.now().subtract(Duration(minutes: 1)),
      "isSendByMe": false
    },
    {
      "content": "Hayat nasıl gidiyor",
      "date": DateTime.now().subtract(Duration(minutes: 1)),
      "isSendByMe": false
    },
  ];
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

  // ignore: unnecessary_cast
  List chatDoc = [] as List;

  List meesageFromFirebase = [];
  Future<void> getDoc() async {
    buildChangeState();

    chatDoc.clear();
    await _firestore.collection("chats").snapshots().listen((event) {
      event.docs.forEach((element) {
        chatDoc.add(element.id);
      });
    });
  }

  sendMessage() {}
  getMessage() {}

  Future<void>? messageCreateAndGet() {
    getDoc();
    Future.delayed(Duration(seconds: 1)).then((value) => {
          mes1 = chatDoc.contains(widget.messageId),
          mes2 = chatDoc.contains(widget.otherUser),
          if (chatDoc.contains(widget.messageId) ||
              chatDoc.contains(widget.otherUser))
            {
              print("var, konuşmalar gelecek"),
              if (mes1) {getMessage()} else if (mes2) {getMessage()},
            }
          else
            {print("yok. konuşma başlayacak")},
          print("mes1 : " + mes1.toString()),
          print("mes2 : " + mes2.toString()),
          buildChangeState(),
        });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userName),
        backgroundColor: context.appColor,
      ),
      body: Container(
        decoration: context.customBackgroundStyle,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: message.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                  alignment: message[index]["isSendByMe"]
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        message[index]["content"],
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
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.grey,
                          decoration: new InputDecoration(
                              suffixIconColor: Colors.white,
                              suffixIcon: Icon(Icons.send),
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
