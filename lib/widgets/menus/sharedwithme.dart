import 'package:flutter/material.dart';

class SharedWithMe extends StatefulWidget {
  const SharedWithMe({super.key});

  @override
  State<SharedWithMe> createState() => _SharedWithMeState();
}

class _SharedWithMeState extends State<SharedWithMe>
    with TickerProviderStateMixin {
  late TabController tabController; // nullable

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.animateTo(0); // tab pertama dibuka adalah index 0
  }

  static const List<Tab> tabs = [
    Tab(icon: Icon(Icons.looks_one), child: Text("Tab One")),
    Tab(icon: Icon(Icons.looks_two), child: Text("Tab Two")),
    Tab(icon: Icon(Icons.looks_3), child: Text("Tab Three")),
  ];

  static const List<Widget> tabViews = [
    Center(child: Text("Content of Tab One", style: TextStyle(fontSize: 16))),
    Center(child: Text("Content of Tab Two", style: TextStyle(fontSize: 16))),
    Center(child: Text("Content of Tab Three", style: TextStyle(fontSize: 16))),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Shared with me"),
          centerTitle: true,
          elevation: 12,
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 8,
            isScrollable: false,
            physics: const BouncingScrollPhysics(),
            controller: tabController,
            tabs: tabs,
            onTap: (index) {
              debugPrint("Tab $index is tapped!");
            },
          ),
        ),
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          controller: tabController,
          children: tabViews,
        ),
      ),
    );
  }
}
