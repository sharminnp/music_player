import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextFieldPlaylist extends StatelessWidget {
  const TextFieldPlaylist(
      {Key? key,
      required this.hintText,
      required this.validator,
      required this.textController,
      this.onchange})
      : super(key: key);
  final String hintText;
  final TextEditingController textController;
  final String? Function(String?)? validator;
  final void Function(String?)? onchange;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: onchange,
        validator: validator,
        controller: textController,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(hintText: hintText));
  }
}
