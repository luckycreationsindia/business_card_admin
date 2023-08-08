import 'package:flutter/material.dart';

class BottomNavButton extends StatelessWidget {
  const BottomNavButton({
    Key? key,
    required this.mainColor,
    required this.pageKey,
    required this.icon,
    required this.title,
  }) : super(key: key);
  final GlobalKey pageKey;
  final IconData icon;
  final String title;
  final Color mainColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          IconButton(
            onPressed: () => Scrollable.ensureVisible(
              pageKey.currentContext!,
              duration: const Duration(seconds: 2),
            ),
            icon: Icon(
              icon,
              color: mainColor,
            ),
          ),
          Text(title),
        ],
      ),
    );
  }
}