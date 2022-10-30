import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kitapcim/constants/context_extentions.dart';

class UserComment extends StatefulWidget {
  const UserComment({Key? key}) : super(key: key);

  @override
  State<UserComment> createState() => _UserCommentState();
}

class _UserCommentState extends State<UserComment> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              flex: 9,
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  decoration: BoxDecoration(
                    //color: Colors.red,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 15,
                            backgroundImage: NetworkImage(
                                "https://images.pexels.com/photos/46274/pexels-photo-46274.jpeg?auto=compress&cs=tinysrgb&w=1200"),
                          ),
                          SizedBox(
                            width: context.dynamicWidth(0.01),
                          ),
                          Text(
                            "Ceyhun Gül",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Spacer(),
                          FaIcon(
                            FontAwesomeIcons.trashAlt,
                            size: 17,
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Bu bir yorum " * 5,
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      Divider()
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
