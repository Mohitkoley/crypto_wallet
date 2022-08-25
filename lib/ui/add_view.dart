import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddView extends StatefulWidget {
  const AddView({Key? key}) : super(key: key);

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  final _formkey = GlobalKey<FormState>();
  List<String> coins = ["bitcoin", "tether", "ethereum"];
  String dropdownValue = "bitcoin";
  final TextEditingController _amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton<String>(
          value: dropdownValue,
          onChanged: (value) {
            setState(() {
              dropdownValue = value!;
            });
          },
          items: coins.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 1.3,
          child: Form(
              key: _formkey,
              child: TextFormField(
                controller: _amountController,
                decoration: InputDecoration(label: Text("Coin Amount")),
              )),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 1.4,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ElevatedButton(
              onPressed: () async {
                late bool shouldNavigate;
                if (_formkey.currentState!.validate()) {
                  //TODO
                  await addCoin(dropdownValue, _amountController.text);
                  Navigator.pop(context);
                }
              },
              child: Text("Add")),
        )
      ],
    ));
  }
}
