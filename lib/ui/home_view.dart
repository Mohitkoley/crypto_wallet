import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/net/api_methods.dart';
import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:crypto_wallet/ui/add_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double bitcoin = 0.0;
  double tether = 0.0;
  double ethereum = 0.0;

  @override
  void initState() {
    getValues();
    super.initState();
  }

  getValues() async {
    bitcoin = await getPrice("bitcoin");
    tether = await getPrice("tether");
    ethereum = await getPrice("ethereum");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getValues(String id, double amount) {
      if (id == "bitcoin") {
        return bitcoin * amount;
      } else if (id == "tether") {
        return tether * amount;
      } else {
        return ethereum * amount;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Home View"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.height,
        height: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.white),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('Coins')
                .snapshots(),
            builder: ((context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                children: snapshot.data!.docs.map(
                    (QueryDocumentSnapshot<Map<String, dynamic>> document) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 12,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 5),
                          Text("Coin: ${document.id}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          Text(
                            "\₹${getValues(document.id, document.data()['Amount']).toStringAsFixed(2)}",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            color: Colors.red,
                            onPressed: () async {
                              await removeCoin(document.id);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            })),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddView()))),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
