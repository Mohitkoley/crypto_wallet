import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:crypto_wallet/ui/home_view.dart';
import "package:flutter/material.dart";

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
          ),
          child: Form(
            key: _formkey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please fill this field";
                    }
                    return null;
                  },
                  controller: _emailField,
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: "123@gmail.com",
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 35),
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please fill this field";
                    }
                    return null;
                  },
                  controller: _passwordField,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: "password",
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 35),
              Container(
                  width: MediaQuery.of(context).size.height / 1.4,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                  ),
                  child: ElevatedButton(
                      onPressed: () async {
                        late bool shouldNavigate;
                        if (_formkey.currentState!.validate()) {
                          shouldNavigate = await register(
                              _emailField.text, _passwordField.text);
                        }
                        if (shouldNavigate) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeView()));
                        }
                      },
                      child: Text("Register"))),
              SizedBox(height: MediaQuery.of(context).size.height / 35),
              Container(
                  width: MediaQuery.of(context).size.height / 1.4,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                  ),
                  child: ElevatedButton(
                      onPressed: () async {
                        late bool shouldNavigate;
                        if (_formkey.currentState!.validate()) {
                          shouldNavigate = await signin(
                              _emailField.text, _passwordField.text);
                        }
                        if (shouldNavigate) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeView()));
                        }
                      },
                      child: Text("Login"))),
            ]),
          )),
    );
  }
}
