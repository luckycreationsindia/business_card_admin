import 'package:flutter/material.dart';

class CheckHandler extends StatefulWidget {
  final String title;
  final bool checked;
  final void Function(bool) callback;

  const CheckHandler({
    super.key,
    required this.checked,
    required this.title,
    required this.callback,
  });

  @override
  State<CheckHandler> createState() => _CheckHandlerState();
}

class _CheckHandlerState extends State<CheckHandler> {
  late bool checked;

  @override
  void initState() {
    checked = widget.checked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.title),
        Checkbox(
          checkColor: Colors.white,
          value: checked,
          onChanged: (bool? value) {
            setState(() {
              checked = value!;
              widget.callback(checked);
            });
          },
        ),
      ],
    );
  }
}