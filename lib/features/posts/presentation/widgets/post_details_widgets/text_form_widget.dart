import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String name;
  final bool multiline;
  final TextEditingController controller;
  const TextFormFieldWidget({
    Key? key,
    this.multiline = false,
    required this.name,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        controller: controller,
        validator: (val) => val!.isEmpty ? "$name Can't be empty" : null,
        decoration: InputDecoration(hintText: name),
        maxLines: multiline ? 6 : 1,
        minLines: multiline ? 6 : 1,
      ),
    );
  }
}
