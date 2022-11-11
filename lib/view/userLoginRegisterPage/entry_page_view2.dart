import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kitapcim/components/bottombar_view.dart';
import 'package:kitapcim/constants/context_extentions.dart';
import 'package:kitapcim/services/auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl/intl.dart';

class EntryPageView extends StatefulWidget {
  const EntryPageView({Key? key}) : super(key: key);

  @override
  State<EntryPageView> createState() => _EntryPageViewState();
}

class _EntryPageViewState extends State<EntryPageView> {
  PageController pageController = PageController();

  var _changeIcon = FontAwesomeIcons.eyeSlash;
  bool _showHide = true;
  final _forgetPasswd = "Şifremi unuttum";
  final _login = "Giriş Yap";
  final _welcome = "Kitapçım'a Hoş Geldin";
  final _register = "Kaydol";
  final _email = "E-Posta";
  final _password = "Parola";
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameRegisterController = TextEditingController();
  TextEditingController mailRegisterController = TextEditingController();
  TextEditingController passwordRegisterController = TextEditingController();

  AuthService _authService = AuthService();

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
            _loginPage(context),
            _registerPage(pageController: pageController),
          ],
        ),
      ),
    );
  }

  Align _loginPage(BuildContext context) {
    return Align(
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
                    child: Text(_welcome,
                        style: GoogleFonts.quicksand(fontSize: 20)),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: mailController,
                  cursorColor: Colors.grey,
                  keyboardType: TextInputType.emailAddress,
                  decoration: new InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      isDense: true,
                      labelText: _email,
                      labelStyle: TextStyle(color: Colors.grey),
                      border: UnderlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: _showHide,
                  cursorColor: Colors.grey,
                  keyboardType: TextInputType.emailAddress,
                  decoration: new InputDecoration(
                      isDense: true,
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: FaIcon(_changeIcon),
                            onTap: () {
                              setState(() {
                                if (_changeIcon == FontAwesomeIcons.eye) {
                                  _showHide = true;
                                  _changeIcon = FontAwesomeIcons.eyeSlash;
                                } else {
                                  _showHide = false;
                                  _changeIcon = FontAwesomeIcons.eye;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      labelText: _password,
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
                              backgroundColor: context.appColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                          onPressed: () {
                            _loginFunction();
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 20.0, bottom: 20),
                            child: Text(
                              _login,
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                    child: Text(_forgetPasswd,
                        style: GoogleFonts.quicksand(
                            color: Colors.black, fontSize: 17)),
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
                              backgroundColor: Colors.white,
                              side: BorderSide(color: Colors.grey),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                          onPressed: () {
                            pageController.animateToPage(1,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 20.0, bottom: 20),
                            child: Text(
                              _register,
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
    );
  }

  void _loginFunction() {
    _authService
        .signIn(mailController.text, passwordController.text)
        .then((value) {
      return Navigator.push(
          context, MaterialPageRoute(builder: (context) => BottomBarPage()));
    }).catchError((dynamic error) {
      if (error.code.contains('invalid-email')) {
        _buildErrorMessage("Mail adresi geçersizdir");
      }
      if (error.code.contains('user-not-found')) {
        _buildErrorMessage("Kullanıcı bulunamadı");
      }
      if (error.code.contains('wrong-password')) {
        _buildErrorMessage("Parola yanlıştır");
      }

      //  _buildErrorMessage(error.message);
    });
  }

  void _buildErrorMessage(String text) {
    //Get.snackbar("Uyarı", text);
    Get.defaultDialog(
      title: "Uyarı",
      barrierDismissible: true,
      content: Text(text),
      textCancel: "Kapat",
    );
  }
}

// ignore: must_be_immutable
class _registerPage extends StatelessWidget {
  TextEditingController nameRegisterController = TextEditingController();
  TextEditingController mailRegisterController = TextEditingController();
  TextEditingController passwordRegisterController = TextEditingController();

  // ignore: unused_field
  AuthService _authService = AuthService();
  _registerPage({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Container(
          decoration: context.contDecoration,
          width: context.dynamicWidth(1),
          height: context.dynamicHeight(0.6),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Yeni bir Hesap oluştur",
                        style: GoogleFonts.quicksand(fontSize: 20)),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: nameRegisterController,
                  cursorColor: Colors.grey,
                  keyboardType: TextInputType.emailAddress,
                  decoration: new InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      isDense: true,
                      labelText: "Ad",
                      labelStyle: TextStyle(color: Colors.grey),
                      border: UnderlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: mailRegisterController,
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
                  obscureText: true,
                  controller: passwordRegisterController,
                  cursorColor: Colors.grey,
                  keyboardType: TextInputType.emailAddress,
                  decoration: new InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      isDense: true,
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
                            backgroundColor: context.appColor,
                          ),
                          onPressed: () {
                            final DateTime now = DateTime.now();
                            final DateFormat formatter =
                                DateFormat('dd.MM.yyyy');
                            // ignore: unused_local_variable
                            final String formatted = formatter.format(now);
                            _authService
                                .createUser(
                                    nameRegisterController.text,
                                    mailRegisterController.text,
                                    passwordRegisterController.text,
                                    formatted)
                                .then((value) => {
                                      if (value != null)
                                        {
                                          pageController.animateToPage(0,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve: Curves.ease),
                                          Get.snackbar(
                                              "Kayıt", "Hesap oluşturuldu",
                                              colorText: Colors.white,
                                              backgroundColor:
                                                  context.appColor),
                                        }
                                      else
                                        {}
                                    });
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 20.0, bottom: 20),
                            child: Text(
                              "Kaydol",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: context.dynamicHeight(0.02),
              ),
              Row(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text("Zaten bir hesabın var mı?",
                            style: GoogleFonts.quicksand(fontSize: 16)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(color: Colors.grey),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                          onPressed: () {
                            pageController.animateToPage(0,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 20.0, bottom: 20),
                            child: Text(
                              "Giriş Yap",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ],
                  ),
                ],
              )
            ],
          )),
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
