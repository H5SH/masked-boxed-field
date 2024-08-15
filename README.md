# Masked Boxed Input

A Flutter package to create masked input fields with individual character blocks. This is particularly useful for inputs like masked numbers or other formatted text inputs.

## Demo

![Getting Started]("C:\Users\adila\Pictures\Screenshots\Screenshot 2024-07-29 020155.png")

## Features

- Individual character input fields
- Customizable decorations for each input field
- Supports different input masks
- Handles backspace and focus management
- Customizable keyboard type

## Browser

https://github.com/user-attachments/assets/9d9c5211-530d-4f2a-82f3-a90167e5ad09

## Parameters

### `MaskedBoxedInput`

| Parameter             | Type                        | Default Value                                                                                               | Description                                                                                             |
|-----------------------|-----------------------------|-------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------|
| `mask`                | `String`                    | `required`                                                                                                  | The mask pattern for the input. Use `#` for input fields and any other character for static content.   |
| `controller`          | `TextEditingController?`    | `null`                                                                                                      | Optional main text controller to get the full input text.                                               |
| `boxDecorations`      | `List<BoxDecoration>`       | `const []`                                                                                                  | List of box decorations for each input field.                                                           |
| `height`              | `double`                    | `50`                                                                                                        | Height of each input field.                                                                             |
| `width`               | `double`                    | `20`                                                                                                        | Width of each input field.                                                                              |
| `inputDecorations`    | `List<InputDecoration>?`    | `const []`                                                                                                  | List of input decorations for each input field.                                                         |
| `inputDecoration`     | `InputDecoration?`          | `const InputDecoration(...)`                                                                                | Default input decoration for all input fields.                                                          |
| `boxDecoration`       | `BoxDecoration?`            | `null`                                                                                                      | Default box decoration for all input fields.                                                            |
| `keyboardType`        | `TextInputType`             | `TextInputType.number`                                                                                      | Keyboard type for the input fields.                                                                     |
| `sizeOfDivider`       | `double`                    | `10`                                                                                                        | Size of the divider between static characters.                                                          |
| `mainAxisSpacing`     | `double`                    | `0.0`                                                                                                       | Spacing between each input field.                                                                       |
| `sizeOfOtherCharaters`| `double`                    | `15`                                                                                                        | Size of static characters in the mask.                                                                  |
| `onChange`            | `void Function(String)?`    | `null`                                                                                                      | Callback function when the input changes.                                                               |
| `onKeyEvent`          | `void Function(KeyEvent)?`  | `null`                                                                                                      | Callback function for key events.                                                                       |

### `OneCharField`

| Parameter         | Type                      | Default Value       | Description                                                                 |
|-------------------|---------------------------|---------------------|-----------------------------------------------------------------------------|
| `onChange`        | `void Function(String)?`  | `required`          | Callback function when the input changes.                                   |
| `onKeyEvent`      | `void Function(KeyEvent)?`| `null`              | Callback function for key events.                                           |
| `focusNode`       | `FocusNode`               | `required`          | Focus node for the input field.                                             |
| `focus`           | `FocusNode?`              | `null`              | Optional parent focus node for managing keyboard events.                    |
| `controller`      | `TextEditingController?`  | `null`              | Controller for the input field.                                             |
| `boxDecoration`   | `BoxDecoration?`          | `null`              | Box decoration for the input field.                                         |
| `height`          | `double`                  | `required`          | Height of the input field.                                                  |
| `width`           | `double`                  | `required`          | Width of the input field.                                                   |
| `inputDecoration` | `InputDecoration?`        | `null`              | Input decoration for the input field.                                       |
| `textInputType`   | `TextInputType`           | `required`          | Keyboard type for the input field.                                          |

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:masked_boxed_field/masked_boxed_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Masked Boxed Input Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController _controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Masked Boxed Input Demo'),
      ),
      body: Center(
        child: MaskedBoxedInput(
          mask: '###-###-####',
          constroller: _controller
          onChange: (value) {
            print('Input changed: $value');
          },
          onKeyEvent: (event) {
            print('Key event: $event');
          },
        ),
      ),
    );
  }
}
