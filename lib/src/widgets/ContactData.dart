import 'package:flutter/material.dart';

class ContactData extends StatelessWidget {
  const ContactData({
    Key? key,
    required this.icon,
    required this.title,
    required this.mainColor,
    required this.onClick,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final Color mainColor;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: onClick,
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