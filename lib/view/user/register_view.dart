import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:kitapcim/constants/context_extentions.dart';

import 'entry_view.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late String email = "E-Posta";
  late String password = "Parola";
  late String cPassword = "Tekrar Parola";
  late String name = "Ad";
  late String surname = "Soyad";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              buildTextFormField(text: name),
              buildTextFormField(text: surname),
              buildTextFormField(text: email),
              buildTextFormField(text: password),
              buildButtonSignin(),
              SizedBox(height: context.dynamicHeight(0.010))
            ],
          ),
        ),
      ),
    );
  }
}

class buildButtonSignin extends StatelessWidget {
  const buildButtonSignin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EntryPage(),
                  ));
            },
            style: ElevatedButton.styleFrom(primary: Color(0xff1e1b32)),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 15, left: 20, right: 20),
              child: Text("Kullanıcı oluştur"),
            ))
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
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
              cursorColor: Colors.grey,
              keyboardType: TextInputType.emailAddress,
              decoration: new InputDecoration(
                labelText: text,
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              )),
        )),
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
