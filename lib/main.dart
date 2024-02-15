import 'package:flutter/material.dart';
import 'package:flutter_app/onboarding.dart';
import 'package:flutter_app/widgets/menus/about.dart';
import 'package:flutter_app/widgets/menus/call.dart';
import 'package:flutter_app/widgets/menus/contact.dart';
import 'package:flutter_app/widgets/menus/myfiles.dart';
import 'package:flutter_app/widgets/menus/profile.dart';
import 'package:flutter_app/widgets/menus/settings.dart';
import 'package:flutter_app/widgets/menus/sharedwithme.dart';

void main() {
  // MaterialApp adalah sebagai root widget
  runApp(const MyFlutterApp());
}

class MyFlutterApp extends StatefulWidget {
  const MyFlutterApp({super.key});
  @override
  State<MyFlutterApp> createState() => _MyFlutterAppState();
}

class _MyFlutterAppState extends State<MyFlutterApp> {
  @override
  Widget build(Object context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      title: "My Flutter App",
      home: const OnBoarding(), // starting widget
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void handleSelectedMenuButton(String menu) {
    switch (menu) {
      case "Profile":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Profile(),
          ),
        );
        break;
      case "Contact":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Contact(),
          ),
        );
        break;
      case "About":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const About(),
          ),
        );
        break;
    }
  }

  // drawer menu yang pertama kali dibuka
  int selectedDrawerIndex = 0;
  // menu - menu dalam drawer
  static const List<Widget> widgetDrawerMenu = <Widget>[
    Expanded(child: MyFiles()),
    Expanded(child: SharedWithMe()),
    Text("Recent files"),
    Text("Trash"),
    Text("Bookmarks"),
  ];

  // salah satu menu drawer dipilih
  void onItemDrawerTap(int index) {
    setState(() {
      selectedDrawerIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.grey,
                image: DecorationImage(
                  image: AssetImage("assets/images/pexels_1.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 55,
                    height: 55,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                        "https://i.ibb.co/PxkfQPX/github-avatar.png",
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 8, right: 8)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Yusuf Rizal H.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "rizal@inixindo.co.id",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text("My Files"),
              leading: const Icon(Icons.folder_copy),
              selected: selectedDrawerIndex == 0,
              onTap: () {
                onItemDrawerTap(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Shared with me"),
              leading: const Icon(Icons.group),
              selected: selectedDrawerIndex == 1,
              onTap: () {
                onItemDrawerTap(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Recent files"),
              leading: const Icon(Icons.access_time),
              selected: selectedDrawerIndex == 2,
              onTap: () {
                onItemDrawerTap(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Trash"),
              leading: const Icon(Icons.delete),
              selected: selectedDrawerIndex == 3,
              onTap: () {
                onItemDrawerTap(3);
                Navigator.pop(context);
              },
            ),
            const Divider(color: Colors.grey, thickness: 1),
            const Padding(padding: EdgeInsets.only(bottom: 12)),
            ListTile(
              title: const Text("Bookmarks"),
              leading: const Icon(Icons.bookmark),
              selected: selectedDrawerIndex == 4,
              onTap: () {
                onItemDrawerTap(4);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              snap: true,
              floating: true,
              backgroundColor: const Color.fromRGBO(219, 98, 4, 1),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Call(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.call, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Settings(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.settings, color: Colors.white),
                ),
                PopupMenuButton(
                  onSelected: handleSelectedMenuButton,
                  itemBuilder: (context) {
                    return {"Profile", "Contact", "About"}.map((String menu) {
                      return PopupMenuItem(
                        value: menu,
                        child: Text(menu),
                      );
                    }).toList();
                  },
                ),
              ],
              flexibleSpace: const FlexibleSpaceBar(
                title: Text("My Flutter App"),
                centerTitle: false,
                background: Image(
                  image: NetworkImage(
                      "https://images.pexels.com/photos/2653362/pexels-photo-2653362.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              widgetDrawerMenu[selectedDrawerIndex],
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final myMessage = SnackBar(
            content: const Text("Flash message by snackbar"),
            backgroundColor: const Color.fromRGBO(219, 98, 4, 1),
            elevation: 12,
            behavior: SnackBarBehavior.floating,
            showCloseIcon: true,
            closeIconColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(
                color: Colors.grey,
                width: 1,
              ),
            ),
            duration: const Duration(seconds: 3),
          );
          ScaffoldMessenger.of(context).showSnackBar(myMessage);
        },
        elevation: 8,
        tooltip: "Creating",
        backgroundColor: const Color.fromRGBO(219, 98, 4, 1),
        hoverColor: Colors.red,
        child: const Icon(
          Icons.create,
          color: Colors.white,
          size: 26,
        ),
      ),
    );
  }
}
