import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masked_boxed_field/widget/one_char_field.dart';

class MaskedBoxedInput extends StatefulWidget {
  final String mask;
  final TextEditingController? controller;
  final List<BoxDecoration> boxDecorations;
  final double height;
  final double width;
  final List<InputDecoration>? inputDecorations;
  final InputDecoration? inputDecoration;
  final BoxDecoration? boxDecoration;
  final TextInputType keyboardType;
  final double sizeOfDivider;
  final double mainAxisSpacing;
  final double sizeOfOtherCharaters;
  final void Function(String)? onChange;
  final void Function(KeyEvent)? onKeyEvent;


  const MaskedBoxedInput(
      {super.key,
      required this.mask,
      this.controller,
      this.boxDecorations = const [],
      this.height = 50,
      this.width = 20,
      this.inputDecorations = const [],
      this.mainAxisSpacing = 0.0,
      this.inputDecoration = const InputDecoration(
        filled: true,
        fillColor: Color.fromARGB(74, 22, 23, 21),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
      this.boxDecoration,
      this.keyboardType = TextInputType.number,
      this.sizeOfDivider = 10,
      this.sizeOfOtherCharaters = 15,
      this.onChange,
      this.onKeyEvent});

  @override
  _MaskedBoxedInputState createState() => _MaskedBoxedInputState();
}

class _MaskedBoxedInputState extends State<MaskedBoxedInput> {
  List<Widget> row = [];

  late List<FocusNode> focusNodes = [];
  FocusNode focus = FocusNode();
  List<TextEditingController> controllers = [];
  int nodeCount = 0;
  int propertyCount = 0;

  void maskedRow() {
    String mask = widget.mask;
    TextEditingController mainController =
        widget.controller ?? TextEditingController();

    for (int i = 0; i < mask.length; i++) {
      if (mask[i] == '#') {
        FocusNode focusNode = FocusNode();
        TextEditingController controller = TextEditingController();

        if (nodeCount < mainController.text.length) {
          controller.text = mainController.text[nodeCount++];
        }

        row.add(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: widget.mainAxisSpacing),
            child: OneCharField(
              focus: focus,
              boxDecoration: propertyCount < widget.boxDecorations.length
                  ? widget.boxDecorations[propertyCount]
                  : widget.boxDecoration,
              inputDecoration: (widget.inputDecorations!.isNotEmpty &&
                      propertyCount < widget.inputDecorations!.length)
                  ? widget.inputDecorations![propertyCount]
                  : widget.inputDecoration,
              controller: controller,
              onChange: (value) {
                if (value.isNotEmpty && (nodeCount + 1) < focusNodes.length) {
                  mainController.text = '${mainController.text}$value';
                  focusNodes[++nodeCount].requestFocus();
                }
                widget.onChange != null ? widget.onChange!(value) : null;
              },
              focusNode: focusNode,
              onKeyEvent: (e) {
                widget.onKeyEvent != null ? widget.onKeyEvent!(e) : null;

                if (e is KeyDownEvent &&
                    e.logicalKey == LogicalKeyboardKey.backspace) {
                  // if the backspace is pressed on the last node
                  if (nodeCount == focusNodes.length - 1 &&
                      controllers[nodeCount].text.isNotEmpty) {
                    controllers[nodeCount].text = '';
                    focusNodes[nodeCount].requestFocus();
                  }

                  // back space on middle nodes
                  else if ((nodeCount - 1) >= 0) {
                    controllers[nodeCount - 1].text = '';
                    focusNodes[--nodeCount].requestFocus();
                    // focusNode.
                  }

                  // updating main controller
                  mainController.text = mainController.text
                      .substring(0, mainController.text.length - 1);
                }
              },
              height: widget.height,
              width: widget.width,
              textInputType: widget.keyboardType,
            ),
          ),
        );
        focusNodes.add(focusNode);
        controllers.add(controller);
        propertyCount++;
      } else if (mask[i] == ' ') {
        row.add(const Padding(padding: EdgeInsets.all(5)));
      } else if (mask[i] == '-') {
        row.add(const SizedBox(
            width: 10,
            child: Padding(
                padding: EdgeInsets.only(top: 7, left: 2, right: 2),
                child: Divider(color: Color.fromARGB(255, 0, 0, 0)))));
      } else {
        row.add(SizedBox(
            width: widget.sizeOfOtherCharaters,
            child: Padding(
              padding: const EdgeInsets.only(top: 5, left: 2, right: 2),
              child: Text(mask[i]),
            )));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    maskedRow();
  }

  @override
  void dispose() {
    for (int i = 0; i < focusNodes.length; i++) {
      focusNodes[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(focus);
        // TextInputType.number;
      },
      
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: row,
      ),
    );
  }
}
