import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kitapcim/constants/context_extentions.dart';
import 'package:kitapcim/services/auth.dart';
import 'package:kitapcim/view/user/entry_view.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var firebaseUser = FirebaseAuth.instance.currentUser;

  AuthService _authService = AuthService();
  var name, surname, mail, date;

  Future<void> veriAl() async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseUser!.uid)
        .get()
        .then((gelenVeri) {
      setState(() {
        name = gelenVeri.data()!['userName'];
        surname = gelenVeri.data()!['userSurname'];
        mail = gelenVeri.data()!['E-Mail'];
        date = gelenVeri.data()!['Date'];
      });
      print("name : $name, surname : $surname, mail : $mail, date : $date");
    });
  }

  @override
  void initState() {
    veriAl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Profilim", style: buildTextStyle(22, Colors.black)),
              ],
            ), //profilimYazisi

            SizedBox(
              height: context.dynamicHeight(0.05),
            ),
            Row(
              children: [
                SizedBox(
                  width: context.dynamicWidth(0.05),
                ),
                Stack(children: [
                  Image.asset(
                    "assets/icons/avataricon.png",
                  ),
                  Positioned(
                      right: 1,
                      bottom: 1,
                      child: GestureDetector(
                          child: Icon(FontAwesomeIcons.camera, size: 25)))
                ]),
                SizedBox(
                  width: context.dynamicWidth(0.03),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("$name $surname",
                        style: buildTextStyle(22, Colors.black)),
                    Text("Kitap okuma ünvanı",
                        style: buildTextStyle(15, Colors.grey)),
                  ],
                )
              ],
            ) //circle avatar ad soyad
            ,
            SizedBox(
              height: context.dynamicHeight(0.03),
            ),
            Row(
              children: [
                SizedBox(
                  width: context.dynamicWidth(0.05),
                ),
                Text(
                  "Bilgilerim",
                  style: buildTextStyle(20, Colors.black),
                )
              ],
            ), //bilgilerim
            /*Row(
                      children: [
                        SizedBox(
                          width: context.dynamicWidth(0.05),
                          height: context.dynamicHeight(0.05),
                        ),
                        Text("Mail Adresi", style: buildTextStyle(15, Colors.grey),)
                      ],
              
                    ),*/
            // buildTextFormField( text: "E-Posta",),
            /* Row(
                      children: [
                        SizedBox(
                          width: context.dynamicWidth(0.05),
                         // height: context.dynamicHeight(0.05),
                        ),
                        Text("Parola", style: buildTextStyle(15, Colors.grey),)
                      ],
              
                    ),*/
            //buildTextFormField(text:"Parola"),

            SizedBox(
              height: context.dynamicHeight(0.04),
            ),
            Text("E-posta : $mail"),
            SizedBox(
              height: context.dynamicHeight(0.04),
            ),
            Text("Kayıt tarihi : $date"),
            SizedBox(
              height: context.dynamicHeight(0.04),
            ),
            Text("Beğenilen kitap sayısı : 0"),
            SizedBox(
              height: context.dynamicHeight(0.04),
            ),

            SizedBox(
              height: context.dynamicHeight(0.01),
            ),
            Row(
              children: [
                SizedBox(
                  width: context.dynamicWidth(0.05),
                ),
                Text(
                  "Favorilerim",
                  style: buildTextStyle(20, Colors.black),
                )
              ],
            ), //kütüphanem
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            Container(
              // width: context.dynamicWidth(0.3),
              height: context.dynamicHeight(0.10),
              child: Center(
                  child: Text(
                "Henüz bir kitap beğenilmedi",
                style: buildTextStyle(15, Colors.black),
              )),
            ),
            //begenilen kitapların fotoğraflarının görünecegi kisim
            /*CarouselSlider(
                      options: CarouselOptions(
                        height: context.dynamicHeight(0.15),
                      ),
                      items: [1,2].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: context.dynamicWidth(0.3),
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                    color: Color(0xFF1e319d)
                                ),
                                child: Center(child: Text('text $i', style: TextStyle(fontSize: 16.0),))
                            );
                          },
                        );
                      }).toList(),
                    ),*/
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () {
                      _authService.singOut();
                      print("Çıkış");
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => EntryPage()));
                      print("Logout!");
                    },
                    child: Icon(Icons.logout_sharp)),
                SizedBox(
                  width: context.dynamicWidth(0.05),
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }

  TextStyle buildTextStyle(double fontSize, Color color) {
    return GoogleFonts.comfortaa(fontSize: fontSize, color: color);
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
