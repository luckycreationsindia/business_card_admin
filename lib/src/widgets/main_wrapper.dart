import 'package:business_card_admin/src/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class MainWrapper extends StatefulWidget {
  final Widget child;
  final int selectedIndex;

  const MainWrapper(
      {super.key, required this.child, required this.selectedIndex});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  @override
  Widget build(BuildContext context) {
    bool showDrawer = MediaQuery.of(context).size.width < 1000;

    return Scaffold(
      drawer:
          showDrawer ? CustomDrawer(selectedIndex: widget.selectedIndex) : null,
      appBar: showDrawer
          ? AppBar(
              backgroundColor: const Color(0xFF151928),
              elevation: 0,
              title: const Text("Digital Business Card - Admin Panel"),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Image.asset("assets/images/logo.png"),
                )
              ],
            )
          : null,
      body: Row(
        children: [
          showDrawer
              ? const SizedBox()
              : CustomDrawer(selectedIndex: widget.selectedIndex),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Row(
                    children: [
                      Flexible(
                        child: SearchBar(
                          trailing: [
                            Icon(Icons.search),
                          ],
                          hintText: "Search",
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: widget.child,
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
