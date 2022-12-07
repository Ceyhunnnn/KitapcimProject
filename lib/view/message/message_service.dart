import 'package:cloud_firestore/cloud_firestore.dart';

class MessageService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> getUsers() {
    var ref = _firestore.collection("Users").snapshots();
    return ref;
  }
}
