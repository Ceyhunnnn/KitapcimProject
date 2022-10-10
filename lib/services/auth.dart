import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";

class AuthService {
  var userUID;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var defaultProfilPhoto =
      "https://icon-library.com/images/profile-image-icon/profile-image-icon-25.jpg";

  //profil fotoğrafı

//Giris yap fonk.
  Future<Object?> signIn(String email, String password) async {
    try {
      var user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print("Basarili");
      return user.user;
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print("basarisiz");
      return e.message;
    }
  }

  //Cikis yap Fonk.
  singOut() async {
    return await _auth.signOut();
  }

  //Kayit ol Fonk.
  Future<User?> createUser(String name, String email, String password) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await _firestore.collection("Users").doc(user.user?.uid).set({
      "userName": name,
      "E-Mail": email,
      "Password": password,
    });
    userUID = user.user;
    return user.user;
  }
}
