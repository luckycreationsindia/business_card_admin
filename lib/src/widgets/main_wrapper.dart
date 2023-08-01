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
    return Scaffold(
      body: Row(
        children: [
          CustomDrawer(selectedIndex: widget.selectedIndex),
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
