import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kitapcim/constants/context_extentions.dart';
import 'package:kitapcim/components/bottombar_view.dart';
import 'package:kitapcim/view/user/register_view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  late String email = "E-Posta";
  late String password = "Parola";
  late String butonAciklama;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        /*decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),*/
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

              buildTextFormField(
                text: email,
              ),
              buildTextFormField(
                text: password,
              ),
              SizedBox(
                height: context.dynamicHeight(0.005),
              ),
              buildButtonSignin(
                butonAciklama: "Giriş Yap",
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
              //buildShowDialogWidget(context);
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
      content: buildTextFormField(
        text: email,
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

  Future<dynamic> buildShowDialogWidget(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Parola Yenileme'),
            content: Container(
              width: context.dynamicWidth(0.7),
              height: context.dynamicHeight(0.25),
              child: Column(
                children: [
                  Text(
                    "Şifreni yenilemek için E-Posta adresini gir ve gönder butonuna tıkla.",
                    textAlign: TextAlign.justify,
                    style:
                        GoogleFonts.biryani(textStyle: TextStyle(fontSize: 15)),
                  ),
                  buildTextFormField(text: email),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Kapat')),
              TextButton(
                onPressed: () {
                  //print('HelloWorld!');
                },
                child: Text('Gönder'),
              )
            ],
          );
        });
  }

  Future<dynamic> buildBottomSheetWidget(BuildContext context) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (builder) {
          return Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Kapat"),
                        ))
                  ],
                ),

                buildTextFormField(text: email),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Şifreni yenilemek için E-Posta adresini gir ve gönder butonuna tıkla.",
                    textAlign: TextAlign.justify,
                    style:
                        GoogleFonts.biryani(textStyle: TextStyle(fontSize: 15)),
                  ),
                ),
                Divider(
                  indent: 15,
                  endIndent: 15,
                  thickness: 2,
                ),
                SizedBox(
                  height: context.dynamicHeight(0.01),
                ),
                //buildTextFormField(text: email),
                GestureDetector(
                  onTap: () {
                    /*Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EntryPage(),
                                          ));*/

                    Navigator.pop(context);
                  },
                  child: buildButtonPassword(
                    butonAciklama: "Gönder",
                  ),
                ),
              ],
            ),
          );
        });
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

class buildTextFormField2 extends StatelessWidget {
  const buildTextFormField2({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
              cursorColor: Colors.grey,
              keyboardType: TextInputType.emailAddress,
              decoration: new InputDecoration(
                  labelText: text,
                  labelStyle: TextStyle(color: Colors.grey),
                  border: new OutlineInputBorder(
                    borderSide: new BorderSide(
                      color: Colors.transparent,
                    ),
                  ))),
        ),
      ],
    );
  }
}

class buildTextFormField extends StatelessWidget {
  const buildTextFormField({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
                cursorColor: Colors.grey,
                keyboardType: TextInputType.emailAddress,
                decoration: new InputDecoration(
                    labelText: text,
                    labelStyle: TextStyle(color: Colors.grey),
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(
                        color: Colors.transparent,
                      ),
                    ))),
          ),
        ),
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

class buildButtonPassword extends StatelessWidget {
  buildButtonPassword({
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
                  MaterialPageRoute(builder: (context) => EntryPage()));
            },
            style: ElevatedButton.styleFrom(primary: Colors.brown),
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
      children: [Image.asset("assets/images/logo.png")],
    );
  }
}
