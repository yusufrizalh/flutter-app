import 'package:flutter/material.dart';

class MyFiles extends StatefulWidget {
  const MyFiles({super.key});

  @override
  State<MyFiles> createState() => _MyFilesState();
}

class _MyFilesState extends State<MyFiles> {
  int selectedIndex = 0;

  void onItemTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  static const List<Widget> widgetBottomNavigation = <Widget>[
    Icon(Icons.key, size: 70, color: Colors.orange),
    Icon(Icons.lock, size: 70, color: Colors.orange),
    Icon(Icons.chat, size: 70, color: Colors.orange),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            widgetBottomNavigation.elementAt(selectedIndex),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.key), label: "Account"),
          BottomNavigationBarItem(icon: Icon(Icons.lock), label: "Privacy"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
        ],
        onTap: onItemTap,
      ),
    );
  }
}
