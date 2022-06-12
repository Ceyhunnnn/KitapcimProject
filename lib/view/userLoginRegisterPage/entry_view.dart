import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:kitapcim/constants/context_extentions.dart';
import 'package:kitapcim/components/bottombar_view.dart';
import 'package:kitapcim/services/auth.dart';
import 'package:kitapcim/view/userLoginRegisterPage/register_view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

//final userRef = FirebaseFirestore.instance.collection("Users");

class EntryPage extends StatefulWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthService _authService = AuthService();
  late String butonAciklama = "Giriş Yap";
  var changeIcon = FontAwesomeIcons.eyeSlash;
  bool showHide = true;

/*
  getUsers() {
    userRef.get().then((QuerySnapshot snapshot) =>
        snapshot.docs.forEach((DocumentSnapshot doc) {
          print(doc.data());
        }));
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: Color(0XFFF7F7F7),
          width: context.dynamicWidth(1),
          height: context.dynamicHeight(1),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: context.dynamicHeight(0.01)),
                KitapcimWidget(), //logo

                SizedBox(
                  height: context.dynamicHeight(0.005),
                ),
                Account_Entry_Widget(), //hesabiniza giris yapin

                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                            controller: mailController,
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
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                            obscureText: showHide,
                            controller: passwordController,
                            cursorColor: Colors.grey,
                            decoration: new InputDecoration(
                              isDense: true,
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
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: context.dynamicHeight(0.005),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (mailController.text != "" &&
                              passwordController.text != "") {
                            _authService.signIn(
                                mailController.text, passwordController.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomBarPage()),
                            );
                          } else {
                            Alert(
                              context: context,
                              type: AlertType.warning,
                              title: "Hata",
                              desc: "E-posta ve Parolayı kontrol et",
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "Kapat",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  color: context.appColor,
                                )
                              ],
                            ).show();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff1e1b32)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 15, left: 20, right: 20),
                          child: Text(butonAciklama),
                        ))
                  ],
                ),
                SizedBox(
                  height: context.dynamicHeight(0.04),
                ),
                Create_Account(),
                SizedBox(
                  height: context.dynamicHeight(0.02),
                ),
                buildPasswordForget(context),
                SizedBox(height: context.dynamicHeight(0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Diğer oturum açma seçenekleri",
                        style: GoogleFonts.biryani())
                  ],
                ), //oturum acma secenekleri
                SizedBox(height: context.dynamicHeight(0.01)),
                buildSocialMedia(),
                SizedBox(height: context.dynamicHeight(0.020)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildPasswordForget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            child: Text("Şifremi unuttum",
                style: GoogleFonts.biryani(color: Color(0xFF1e319d))),
            onPressed: () {
              buildShowDialogWidget2(context);
            })
      ],
    );
  }

  Future<bool?> buildShowDialogWidget2(BuildContext context) {
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
}

class Create_Account extends StatelessWidget {
  const Create_Account({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "Hesabın yok mu?",
              style: GoogleFonts.biryani(color: Colors.black)),
          TextSpan(
              text: " Kayıt Ol",
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  debugPrint("KayitOl*");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Register(),
                      ));
                  // Single tapped.
                },
              style: GoogleFonts.biryani(
                color: Color(0xFF1e319d),
              ))
        ]))
      ],
    );
  }
}

class Account_Entry_Widget extends StatelessWidget {
  const Account_Entry_Widget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Hesabınıza giriş yapın",
            style: GoogleFonts.biryani(textStyle: TextStyle(fontSize: 15)),
          ),
        )
      ],
    );
  }
}

var googleSvg = "assets/icons/icons8-google.svg";
var facebookSvg = "assets/icons/icons8-facebook.svg";
var twitterSvg = "assets/icons/icons8-twitter.svg";

class buildSocialMedia extends StatelessWidget {
  const buildSocialMedia({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SvgPicture.asset(googleSvg),
        SvgPicture.asset(facebookSvg),
        SvgPicture.asset(twitterSvg),
      ],
    );
  }
}

class buildButtonSignin extends StatelessWidget {
  const buildButtonSignin({
    Key? key,
    required this.butonAciklama,
  }) : super(key: key);
  final String butonAciklama;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BottomBarPage()));
            },
            style: ElevatedButton.styleFrom(primary: Color(0xff1e1b32)),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 15, left: 20, right: 20),
              child: Text(butonAciklama),
            ))
      ],
    );
  }
}

class KitapcimWidget extends StatelessWidget {
  const KitapcimWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/newLogo.png",
          width: context.dynamicWidth(0.6),
          height: context.dynamicHeight(0.3),
        )
      ],
    );
  }
}
