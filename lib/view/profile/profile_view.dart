// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kitapcim/constants/context_extentions.dart';
import 'package:kitapcim/services/auth.dart';
import 'package:kitapcim/view/userLoginRegisterPage/entry_page_view2.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var isLoading = false;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  AuthService _authService = AuthService();
  FirebaseAuth _auth = FirebaseAuth.instance;
  var name, surname, mail, date, photo;
  Future<void> userGet() async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseUser!.uid)
        .get()
        .then((gelenVeri) {
      setState(() {
        name = gelenVeri.data()!['userName'];
        mail = gelenVeri.data()!['E-Mail'];
        date = gelenVeri.data()!['Date'];
      });
      print("name : $name, mail : $mail, date : $date");
    });
    isLoading = true;
  }

  late File yuklenecekDosya;
  String indirmeBag =
      "https://icon-library.com/images/profile-image-icon/profile-image-icon-25.jpg";

  baglantiAl() async {
    //String baglanti = await

    try {
      FirebaseStorage.instance
          .ref()
          .child("ProfilePhoto")
          .child(_auth.currentUser!.uid)
          .child("ProfilResmi.png")
          .getDownloadURL()
          .then((value) {
        print(value);
        if (value.isEmpty) {
          print("Fotoğraf yok");
        } else {
          indirmeBag = value;
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    print("Profile Page Init");
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      userGet();
      //baglantiAl();
      print("Giris Yapili Kullanici id : " + firebaseUser!.uid);
      //ilk durum için kontrol yap
    });

    super.initState();
  }

  kameradanYukle() async {
    var alinanDosya = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      yuklenecekDosya = File(alinanDosya!.path);
    });
    Reference refYol = FirebaseStorage.instance
        .ref()
        .child("ProfilePhoto")
        .child(_auth.currentUser!.uid)
        .child("ProfilResmi.png");

    UploadTask yuklemeGorevi = refYol.putFile(yuklenecekDosya);
    String url = await (await yuklemeGorevi).ref.getDownloadURL();
    setState(() {
      indirmeBag = url;
      print("URL  :   $indirmeBag");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: oldProfilePage(context));
  }

  SafeArea oldProfilePage(BuildContext context) {
    return SafeArea(
        child: isLoading
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Profilim",
                            style: buildTextStyle(22, Colors.black)),
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
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 48, // Image radius
                            backgroundImage: NetworkImage(indirmeBag),
                          ),
                          Positioned(
                              right: 1,
                              bottom: 1,
                              child: InkWell(
                                  onTap: () {
                                    kameradanYukle();
                                  },
                                  child:
                                      Icon(FontAwesomeIcons.camera, size: 25)))
                        ]),
                        SizedBox(
                          width: context.dynamicWidth(0.03),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("$name ",
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
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => EntryPageView()),
                                  (Route<dynamic> route) => false);
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
              )
            : Center(
                child: CircularProgressIndicator(
                color: Color(0xff05595B),
              )));
  }

  TextStyle buildTextStyle(double fontSize, Color color) {
    return GoogleFonts.comfortaa(fontSize: fontSize, color: color);
  }
}
