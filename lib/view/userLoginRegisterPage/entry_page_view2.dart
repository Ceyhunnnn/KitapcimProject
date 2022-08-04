import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kitapcim/constants/context_extentions.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class EntryPageView extends StatefulWidget {
  const EntryPageView({Key? key}) : super(key: key);

  @override
  State<EntryPageView> createState() => _EntryPageViewState();
}

class _EntryPageViewState extends State<EntryPageView> {
  PageController pageController = PageController();

//diger sayfaya yonlendirme

//  pageController.animateToPage(1,
//                     duration: Duration(milliseconds: 500), curve: Curves.ease);
  @override
  // ignore: override_on_non_overriding_member
  var changeIcon = FontAwesomeIcons.eyeSlash;
  bool showHide = true;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/books.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: PageView(
          controller: pageController,
          children: [
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                  decoration: context.contDecoration,
                  width: context.dynamicWidth(1),
                  height: Platform.isAndroid
                      ? context.dynamicHeight(0.59)
                      : context.dynamicHeight(0.55),
                  child: Column(
                    children: [
                      SizedBox(
                        height: context.dynamicHeight(0.02),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text("Kitapçım'a Hoş Geldin",
                                style: GoogleFonts.montserrat(fontSize: 20)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          cursorColor: Colors.grey,
                          keyboardType: TextInputType.emailAddress,
                          decoration: new InputDecoration(
                              prefixIcon: Icon(Icons.mail),
                              isDense: true,
                              labelText: "E-Posta",
                              labelStyle: TextStyle(color: Colors.grey),
                              border: UnderlineInputBorder()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          obscureText: showHide,
                          cursorColor: Colors.grey,
                          keyboardType: TextInputType.emailAddress,
                          decoration: new InputDecoration(
                              isDense: true,
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    child: FaIcon(changeIcon),
                                    onTap: () {
                                      setState(() {
                                        if (changeIcon ==
                                            FontAwesomeIcons.eye) {
                                          showHide = true;
                                          changeIcon =
                                              FontAwesomeIcons.eyeSlash;
                                        } else {
                                          showHide = false;
                                          changeIcon = FontAwesomeIcons.eye;
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                              labelText: "Parola",
                              labelStyle: TextStyle(color: Colors.grey),
                              border: UnderlineInputBorder()),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: context.appColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      )),
                                  onPressed: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20.0, bottom: 20),
                                    child: Text(
                                      "Giriş Yap",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              buildShowDialogWidget(context);
                            },
                            child: Text("Şifremi unuttum",
                                style: GoogleFonts.biryani(
                                    color: Color(0xFF1e319d))),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      side: BorderSide(color: Colors.grey),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      )),
                                  onPressed: () {
                                    pageController.animateToPage(1,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20.0, bottom: 20),
                                    child: Text(
                                      "Kaydol",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                decoration: context.contDecoration,
                width: context.dynamicWidth(1),
                height: context.dynamicHeight(0.5),
                child: Center(child: Text("İkinci sayfa")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool?> buildShowDialogWidget(BuildContext context) {
  return Alert(
    context: context,
    type: AlertType.warning,
    title: "Şifre Yenileme",
    desc:
        "Şifreni yenilemek için E-Posta adresini gir ve gönder butonuna tıkla.",
    content: Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
              cursorColor: Colors.grey,
              keyboardType: TextInputType.emailAddress,
              decoration: new InputDecoration(
                isDense: true,
                labelText: "E-Posta",
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              )),
        )),
      ],
    ),
    buttons: [
      DialogButton(
        child: Text(
          "Gönder",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        color: context.appColor,
      )
    ],
  ).show();
}
