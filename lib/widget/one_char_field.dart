import 'package:flutter/material.dart';

class OneCharField extends StatelessWidget {

  final void Function(String)? onChange;
  final void Function(KeyEvent)? onKeyEvent;
  final FocusNode focusNode;
  final FocusNode? focus;
  final TextEditingController? controller;
  final BoxDecoration? boxDecoration;
  final double height;
  final double width;
  final InputDecoration? inputDecoration;
  final TextInputType textInputType;


  const OneCharField(
      {super.key,
      required this.onChange,
      required this.focusNode,
      required this.height,
      required this.width,
      required this.textInputType,
      this.onKeyEvent,
      this.controller,
      this.boxDecoration,
      this.inputDecoration,
      this.focus
      });

  @override
  Widget build(BuildContext context) {

    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    bool isKeyboardOpen = bottomInsets != 0; 

    return Container(
        width: width,
        height: height,
        decoration: boxDecoration,
        child: KeyboardListener(
            focusNode: focus ?? FocusNode(),
            onKeyEvent: onKeyEvent,
            child: TextField(
              controller: controller,
              onChanged: onChange,
              focusNode: focusNode,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              maxLength: 1,
              showCursor: false,
              decoration: inputDecoration!.copyWith(contentPadding: inputDecoration?.contentPadding ?? EdgeInsets.only(right: width/13, left: width/3.63)),
              keyboardType: isKeyboardOpen ? null:textInputType,
            )));
  }
}
