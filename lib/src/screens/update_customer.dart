import 'package:flutter/material.dart';

class UpdateCustomerScreen extends StatefulWidget {
  final String id;
  const UpdateCustomerScreen({super.key, required this.id});

  @override
  State<UpdateCustomerScreen> createState() => _UpdateCustomerScreenState();
}

class _UpdateCustomerScreenState extends State<UpdateCustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Update Customer",
          style: TextStyle(fontSize: 30),
        ),
      ],
    );
  }
}
