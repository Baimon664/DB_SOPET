import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String init;
  final String label;
  final Function save;
  final bool enable;
  const CustomTextField(
      {Key? key,
      required this.init,
      required this.label,
      required this.save,
      required this.enable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TextEditingController _myController = TextEditingController();

    return TextFormField(
      enabled: enable,
      // controller: _myController,
      initialValue: init,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(label),
      ),
      onChanged: (value) => save(value),
    );
  }
}
