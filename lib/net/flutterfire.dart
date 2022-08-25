// import 'dart:html' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

Future<bool> signin(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == "weak password") {
      print("password you provided is too weak");
    } else if (e.code == "email-already-in-use") {
      print("The account already exist for this email");
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> addCoin(String id, String amount) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var value = double.parse(amount);
    DocumentReference reference = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Coins')
        .doc(id);
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await transaction
          .get(reference as DocumentReference<Map<String, dynamic>>);
      if (!snapshot.exists) {
        transaction.set(reference, {'Amount': value});
        return true;
      }
      double newAmount = snapshot.data()!['Amount'] + value;
      transaction.update(reference, {"Amount": newAmount});
      return true;
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> removeCoin(
  String id,
) async {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  FirebaseFirestore.instance
      .collection("Users")
      .doc(uid)
      .collection("Coins")
      .doc(id)
      .delete();

  return true;
}
