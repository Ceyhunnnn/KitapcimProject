import 'package:flutter/material.dart';

import 'package:kitapcim/core/extensions/context_extentions.dart';
part 'message_string_values.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.appColor,
        centerTitle: true,
        title: Text(_MessasgeStringValues.instance.appBarTitle),
      ),
      body: Column(),
    );
  }
}
