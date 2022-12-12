import 'package:flutter/material.dart';
import 'package:kitapcim/core/extensions/context_extentions.dart';

class MessageDetailView extends StatefulWidget {
  MessageDetailView({Key? key, required this.userName, required this.messageId})
      : super(key: key);

  @override
  State<MessageDetailView> createState() => _MessageDetailViewState();
  final String userName;
  final String messageId;
}

class _MessageDetailViewState extends State<MessageDetailView> {
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
                                  borderRadius: BorderRadius.circular(15)),
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
