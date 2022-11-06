// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kitapcim/services/auth.dart';

import '../userLoginRegisterPage/entry_page_view2.dart';

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
    });
    isLoading = true;
  }

  late File yuklenecekDosya;
  String indirmeBag =
      "https://images.pexels.com/photos/46274/pexels-photo-46274.jpeg?auto=compress&cs=tinysrgb&w=1200";

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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      userGet();
      //baglantiAl();
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
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xff05595B),
                Colors.grey,
              ],
            )),
            child: oldProfilePage(context)));
  }

  SafeArea oldProfilePage(BuildContext context) {
    return SafeArea(
        child: isLoading
            ? Column(
                children: [
                  Expanded(
                    flex: 0,
                    child: myProfileText(),
                  ), //profilimYazisi

                  Expanded(
                    flex: 1,
                    child: buildProfilePhoto(),
                  ),
                  //circle avatar ad soyad

                  Expanded(
                    flex: 0,
                    child: nameAndBooks(context),
                  ),

                  Expanded(
                    flex: 1,
                    child: mailDateLike(),
                  ),
                  Expanded(
                    flex: 1,
                    child: buildMyFav(),
                  ), //kütüphanem

                  Expanded(
                    flex: 1,
                    child: buildMyFavBooks(),
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(
                color: Color.fromARGB(255, 215, 213, 213),
              )));
  }

  GestureDetector buildExitButton(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _authService.singOut();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => EntryPageView()),
              (Route<dynamic> route) => false);
        },
        child: Icon(
          Icons.logout,
          color: Color.fromARGB(255, 215, 213, 213),
        ));
  }

  Container buildMyFavBooks() {
    return Container(
      child: Center(
          child: Text(
        "Henüz bir kitap beğenilmedi",
        style: buildTextStyle(15, Color.fromARGB(255, 215, 213, 213)),
      )),
    );
  }

  Row buildMyFav() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Favorilerim",
          style: buildTextStyle(20, Color.fromARGB(255, 215, 213, 213)),
        )
      ],
    );
  }

  Column mailDateLike() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "E-posta : $mail",
          style: TextStyle(color: Color.fromARGB(255, 215, 213, 213)),
        ),
        Text(
          "Kayıt tarihi : $date",
          style: TextStyle(color: Color.fromARGB(255, 215, 213, 213)),
        ),
        Text(
          "Beğenilen kitap sayısı : 0",
          style: TextStyle(color: Color.fromARGB(255, 215, 213, 213)),
        ),
      ],
    );
  }

  Row buildMyInfo() {
    return Row(
      children: [
        Text(
          "Bilgilerim",
          style: buildTextStyle(20, Color.fromARGB(255, 215, 213, 213)),
        )
      ],
    );
  }

  Column nameAndBooks(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("$name ",
            style: buildTextStyle(22, Color.fromARGB(255, 215, 213, 213))),
        Text("Kitap okuma ünvanı",
            style: buildTextStyle(15, Color.fromARGB(255, 215, 213, 213))),
      ],
    );
  }

  Row buildProfilePhoto() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48, // Image radius
          backgroundImage: NetworkImage(indirmeBag),
        ),
      ],
    );
  }

  Row myProfileText() {
    return Row(
      children: [
        Expanded(
          child: Stack(children: [
            Align(
              alignment: Alignment.center,
              child: Text("Profilim",
                  style:
                      buildTextStyle(26, Color.fromARGB(255, 215, 213, 213))),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: buildExitButton(context)),
          ]),
        ),
      ],
    );
  }

  TextStyle buildTextStyle(double fontSize, Color color) {
    return GoogleFonts.comfortaa(fontSize: fontSize, color: color);
  }
}
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