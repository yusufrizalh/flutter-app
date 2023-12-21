// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/widgets/pages/dashboard/productlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  void handleSelectedMenuButton(String menu) {
    switch (menu) {
      case "Products":
        debugPrint("Products");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProductList(),
          ),
        );
        break;
      case "Logout":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
        break;
    }
  }

  userLogout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("login", false);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const Home(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          PopupMenuButton(
            onSelected: handleSelectedMenuButton,
            itemBuilder: (context) {
              return {"Products", "Logout"}.map((String menu) {
                return PopupMenuItem(
                  value: menu,
                  child: Text(menu),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Dashboard Page"),
          ],
        ),
      ),
    );
  }
}
