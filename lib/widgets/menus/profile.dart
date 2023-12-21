// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/pages/dashboard/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool visible = false;
  final TextEditingController userEmailCtrl = TextEditingController();
  final TextEditingController userPasswordCtrl = TextEditingController();
  final String apiUrl = "http://192.168.1.6/flutter-api/users/";

  loginCheck() async {
    setState(() {
      visible = true;
    });

    final prefs = await SharedPreferences.getInstance();
    var params =
        "signin.php?user_email=${userEmailCtrl.text}&user_password=${userPasswordCtrl.text}";

    try {
      var resp = await http.get(Uri.parse(apiUrl + params));
      if (resp.statusCode == 200) {
        var respCheck = convert.json.decode(resp.body);
        if (respCheck["status"] == "OK") {
          prefs.setBool("login", true);
          setState(() {
            visible = false;
          });
          // arahkan ke halaman dashboard
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const Dashboard(),
            ),
          );
        } else {
          setState(() {
            visible = false;
          });
          showErrorMessage(context, respCheck["message"]);
        }
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  showErrorMessage(BuildContext context, String errorMsg) {
    Widget okButton = ElevatedButton(
      onPressed: () => Navigator.of(context).pop(),
      child: const Text("OK"),
    );
    AlertDialog alertDialog = AlertDialog(
      title: const Text("Error"),
      content: Text(errorMsg),
      actions: <Widget>[
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (context) => alertDialog,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Visibility(
                visible: visible,
                maintainSize: true,
                maintainState: true,
                maintainAnimation: true,
                child: const Center(child: CircularProgressIndicator()),
              ),
              const Padding(padding: EdgeInsets.only(top: 8, bottom: 8)),
              Container(
                margin: const EdgeInsets.all(12),
                child: Column(
                  children: <Widget>[
                    const Text(
                      "User Email",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 6)),
                    TextField(
                      controller: userEmailCtrl
                        ..text = "yusufrizalh@example.com",
                      decoration: InputDecoration(
                        hintText: "Please enter your email address",
                        border: InputBorder.none,
                        fillColor: Colors.grey.shade200,
                        filled: true,
                      ),
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(12),
                child: Column(
                  children: <Widget>[
                    const Text(
                      "User Password",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 6)),
                    TextField(
                      controller: userPasswordCtrl..text = "Pa\$\$w0rd",
                      decoration: InputDecoration(
                        hintText: "Please enter your password",
                        border: InputBorder.none,
                        fillColor: Colors.grey.shade200,
                        filled: true,
                      ),
                      obscureText: false,
                      keyboardType: TextInputType.visiblePassword,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 30)),
              GestureDetector(
                onTap: loginCheck,
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "Signin",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
