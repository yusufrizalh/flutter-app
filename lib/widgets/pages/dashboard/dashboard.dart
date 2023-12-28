// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/widgets/pages/dashboard/productlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  final String userName, userEmail, userPhone, userAddress, userImage;

  const Dashboard({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.userAddress,
    required this.userImage,
  });

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

  String name = "";
  String email = "";
  String phone = "";
  String address = "";
  String image = "";

  getUserInfo() async {
    setState(() {
      name = widget.userName;
      email = widget.userEmail;
      phone = widget.userPhone;
      address = widget.userAddress;
      image = widget.userImage;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
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
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.20,
            decoration: const BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                image: AssetImage("assets/images/pexels_1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -120 / 2),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                        image: NetworkImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    phone,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    address,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
