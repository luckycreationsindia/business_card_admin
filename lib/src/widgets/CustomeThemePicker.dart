import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CustomerThemePicker extends StatefulWidget {
  final void Function(Color) callback;
  final Color currentColor;

  const CustomerThemePicker({
    super.key,
    required this.callback,
    required this.currentColor,
  });

  @override
  State<CustomerThemePicker> createState() => _CustomerThemePickerState();
}

class _CustomerThemePickerState extends State<CustomerThemePicker> {
  late Color currentColor;

  @override
  void initState() {
    currentColor = widget.currentColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          child: const Text("Select theme"),
          onPressed: () => _showColorPicker(),
        ),
        Container(
          height: 50,
          width: 50,
          color: currentColor,
        )
      ],
    );
  }

  Future<void> _showColorPicker() {
    Color pickerColor = currentColor;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (color) => {pickerColor = color},
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Done'),
              onPressed: () {
                widget.callback(pickerColor);
                setState(() => currentColor = pickerColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}