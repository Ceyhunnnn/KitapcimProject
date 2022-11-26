import 'package:cloud_firestore/cloud_firestore.dart';

class StatusService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> getBookAbout() {
    var ref = _firestore.collection("Books").snapshots();
    return ref;
  }
}
