import 'package:flutter/material.dart';
import 'package:kitapcim/constants/context_extentions.dart';

// ignore: must_be_immutable
class CommentPageDetail extends StatefulWidget {
  CommentPageDetail(
      {Key? key,
      required String this.name,
      required String this.url,
      required String this.author,
      required String this.number,
      required String this.about})
      : super(key: key);

  var name;
  var url;
  var author;
  var number;
  var about;
  @override
  State<CommentPageDetail> createState() => _CommentPageDetailState();
}

class _CommentPageDetailState extends State<CommentPageDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: context.appColor,
          title: Text("Yorumlar"),
        ),
        body: Column(
          children: [
            // Expanded(
            //   flex: 0,
            //   child: Padding(
            //     padding: const EdgeInsets.all(10.0),
            //     child: Text(
            //       '${widget.about}',
            //       overflow: TextOverflow.ellipsis,
            //       textAlign: TextAlign.justify,
            //       style: context.buildTextStyle(15, Colors.black),
            //     ),
            //   ),
            // ),
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
                  child: Container(
                    color: Colors.red,
                    child: Text("Yorum " * 500),
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
                          decoration: InputDecoration(
                              suffixIcon: InkWell(
                                  onTap: () => print("Yorum Yapildi!"),
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
}
