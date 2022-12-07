import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitapcim/core/components/bookCard.dart';

import 'package:kitapcim/core/extensions/context_extentions.dart';
import 'package:kitapcim/view/message/message_service.dart';
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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  context.appColor,
                  Color.fromARGB(255, 156, 53, 45),
                ],
              ),
            ),
            child: buildUsersList(messageService: _messageService)));
  }
}

class buildUsersList extends StatelessWidget {
  buildUsersList({
    Key? key,
    required MessageService messageService,
  })  : _messageService = messageService,
        super(key: key);

  final MessageService _messageService;

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
                        onTap: () => {print(userName)},
                        child: Card(
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          shadowColor: Colors.grey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                                trailing: Icon(
                                  Icons.arrow_right_alt,
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
                                  style: context.customTextStyle(
                                      Colors.white, 18.0),
                                ),
                                subtitle: Text(userMail,
                                    style: context.customTextStyle(
                                        Colors.white, 14.0))),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                    ;
                  });
        }));
  }
}
