import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kitapcim/components/bottombar_view.dart';
import 'package:kitapcim/constants/assets_constant.dart';
import 'package:kitapcim/constants/context_extentions.dart';
import 'package:kitapcim/services/auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl/intl.dart';
part 'login_register_string_values.dart';

class EntryPageView extends StatefulWidget {
  const EntryPageView({Key? key}) : super(key: key);

  @override
  State<EntryPageView> createState() => _EntryPageViewState();
}

class _EntryPageViewState extends State<EntryPageView> {
  PageController pageController = PageController();
  _LoginRegisterStringValues values = _LoginRegisterStringValues();

  var _changeIcon = FontAwesomeIcons.eyeSlash;
  bool _showHide = true;

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
            image: AssetImage(AssetsConstant.instance.loginImage),
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
      child: SingleChildScrollView(
        child: Container(
            decoration: context.contDecoration,
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
                      child: Text(values.welcome,
                          style: context.customTextStyle(Colors.black, 17.0)),
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
                        labelText: values.email,
                        labelStyle: context.customTextStyle(Colors.black, 17.0),
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
                        labelText: values.password,
                        labelStyle: context.customTextStyle(Colors.black, 17.0),
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
                                values.login,
                                style:
                                    context.customTextStyle(Colors.white, 17.0),
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
                      child: Text(values.forgetPasswd,
                          style: context.customTextStyle(Colors.black, 17.0)),
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
                              child: Text(values.register,
                                  style: context.customTextStyle(
                                      Colors.black, 17.0)),
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
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
      child: SingleChildScrollView(
        child: Container(
            decoration: context.contDecoration,
            // width: context.dynamicWidth(1),
            // height: context.dynamicHeight(0.7),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text("Yeni bir Hesap oluştur",
                          style: context.customTextStyle(Colors.black, 18.0)),
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
                        labelStyle: context.customTextStyle(Colors.black, 17.0),
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
                        labelStyle: context.customTextStyle(Colors.black, 17.0),
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
                        labelStyle: context.customTextStyle(Colors.black, 17.0),
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
                                style:
                                    context.customTextStyle(Colors.white, 17.0),
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
                              style:
                                  context.customTextStyle(Colors.black, 17.0)),
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
                                style:
                                    context.customTextStyle(Colors.black, 17.0),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: context.dynamicHeight(0.02),
                ),
              ],
            )),
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
