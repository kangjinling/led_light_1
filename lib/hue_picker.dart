import 'package:flutter/cupertino.dart' show CupertinoTextField;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_pickers/colorpicker.dart';
import 'color_pickers/palette.dart';


// Just an example of how to use/interpret/format text input's result.
void copyToClipboard(String input) {
  String textToCopy = input.replaceFirst('#', '').toUpperCase();
  if (textToCopy.startsWith('FF') && textToCopy.length == 8) {
    textToCopy = textToCopy.replaceFirst('FF', '');
  }
  Clipboard.setData(ClipboardData(text: '#$textToCopy'));
}

class ColorPickerExample extends StatefulWidget {
  const ColorPickerExample({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
    this.colorHistory,
    this.onHistoryChanged,
  }) : super(key: key);

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final List<Color>? colorHistory;
  final ValueChanged<List<Color>>? onHistoryChanged;

  @override
  State<ColorPickerExample> createState() => _ColorPickerExample();
}

class _ColorPickerExample extends State<ColorPickerExample> {


  // Picker 4
  final textController =
      TextEditingController(text: '#2F19DB'); // The initial value can be provided directly to the controller.
  bool _enableAlpha4 = true;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColorPicker(
          pickerColor: widget.pickerColor,
          onColorChanged: widget.onColorChanged,
          colorPickerWidth: 400,
          pickerAreaHeightPercent: 0.8,
          enableAlpha: false, // hexInputController will respect it too.
          displayThumbColor: true,
          paletteType: PaletteType.hueWheel,
          labelTypes: const [],
          pickerAreaBorderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2),
            topRight: Radius.circular(2),
          ),
          hexInputController: textController, // <- here
          portraitOnly: true,
          hexInputBar: false,
          colorHistory: widget.colorHistory,
          onHistoryChanged: widget.onHistoryChanged,
        ),
        Text(textController.text,style: const TextStyle(color: Colors.blue,fontSize: 16),),
      ],
    );
  }
}
