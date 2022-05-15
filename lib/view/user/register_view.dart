import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:kitapcim/constants/context_extentions.dart';
import 'package:kitapcim/services/auth.dart';

import 'entry_view.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: context.dynamicHeight(1),
          width: context.dynamicWidth(1),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: context.dynamicHeight(0.01)),
                KitapcimWidget(),
                SizedBox(height: context.dynamicHeight(0.01)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: context.dynamicWidth(0.015)),
                    Text(
                      "Yeni bir hesap oluşturun",
                      style: GoogleFonts.biryani(
                          textStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                          controller: nameController,
                          cursorColor: Colors.grey,
                          keyboardType: TextInputType.emailAddress,
                          decoration: new InputDecoration(
                            labelText: "Ad",
                            labelStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          )),
                    )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                          controller: surnameController,
                          cursorColor: Colors.grey,
                          keyboardType: TextInputType.emailAddress,
                          decoration: new InputDecoration(
                            labelText: "Soyad",
                            labelStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          )),
                    )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                          controller: mailController,
                          cursorColor: Colors.grey,
                          keyboardType: TextInputType.emailAddress,
                          decoration: new InputDecoration(
                            labelText: "E-Posta",
                            labelStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          )),
                    )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                          controller: passwordController,
                          cursorColor: Colors.grey,
                          keyboardType: TextInputType.emailAddress,
                          decoration: new InputDecoration(
                            labelText: "Parola",
                            labelStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          )),
                    )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          _authService.createUser(
                              nameController.text,
                              surnameController.text,
                              mailController.text,
                              passwordController.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EntryPage(),
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff1e1b32)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 15, left: 20, right: 20),
                          child: Text("Kullanıcı oluştur"),
                        ))
                  ],
                ),
                SizedBox(height: context.dynamicHeight(0.010))
              ],
            ),
          ),
        ),
      ),
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
