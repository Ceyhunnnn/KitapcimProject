import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitapcim/core/components/bookCard.dart';

import 'package:kitapcim/core/extensions/context_extentions.dart';
import 'package:kitapcim/view/message/message_service.dart';
import 'package:kitapcim/view/message_detail/message_detail_view.dart';
part 'message_string_values.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  MessageService _messageService = MessageService();
  late final currentUser;
  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: context.appColor,
          centerTitle: true,
          title: Text(_MessasgeStringValues.instance.appBarTitle),
        ),
        body: Container(
            decoration: context.customBackgroundStyle,
            child: buildUsersList(messageService: _messageService)));
  }
}

// ignore: must_be_immutable
class buildUsersList extends StatelessWidget {
  buildUsersList({
    Key? key,
    required MessageService messageService,
  })  : _messageService = messageService,
        super(key: key);

  final MessageService _messageService;
  String userMessageDoc = "";
  String otherUser = "";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _messageService.getUsers(),
        builder: ((context, snapshot) {
          return !snapshot.hasData
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot users = snapshot.data!.docs[index];
                    String userName = '${users['userName']}';
                    String userMail = '${users['E-Mail']}';
                    String userUid = '${users['uid']}';
                    if (current_id != userUid) {
                      return InkWell(
                        onTap: () => {
                          userMessageDoc =
                              userUid.toString() + current_id.toString(),
                          otherUser =
                              current_id.toString() + userUid.toString(),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => MessageDetailView(
                                      userName: userName,
                                      messageId: userMessageDoc,
                                      otherUser: otherUser))))
                        },
                        child: Card(
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          shadowColor: Colors.grey,
                          child: ListTile(
                              trailing: Icon(
                                Icons.message,
                                color: Colors.white,
                              ),
                              leading: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(
                                      _MessasgeStringValues
                                          .instance.defaultPhoto
                                          .toString())),
                              title: Text(
                                userName,
                                style:
                                    context.customTextStyle(Colors.white, 18.0),
                              ),
                              subtitle: Text(userMail,
                                  style: context.customTextStyle(
                                      Colors.white, 14.0))),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  });
        }));
  }
}
