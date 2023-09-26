import 'package:flutter/material.dart';
import 'package:led_light/hue_picker.dart';

import 'color_pickers/utils.dart';

void main() => runApp(
    const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp()));

class MyApp extends StatefulWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool lightTheme = true;
  Color currentColor = Colors.blueAccent;
  List<Color> currentColors = [Colors.yellow, Colors.green];
  List<Color> colorHistory = [];

  void changeColor(Color color) => setState(() => currentColor = color);
  void changeColors(List<Color> colors) => setState(() => currentColors = colors);

  @override
  Widget build(BuildContext context) {

    final foregroundColor = useWhiteForeground(currentColor) ? Colors.white : Colors.black;
    return AnimatedTheme(
      data: lightTheme ? ThemeData.light() : ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('流光灯',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
          backgroundColor: currentColor,
          foregroundColor: foregroundColor,
        ),
        body: ColorPickerExample(
          pickerColor: currentColor,
          onColorChanged: changeColor,
          colorHistory: colorHistory,
          onHistoryChanged: (List<Color> colors) => colorHistory = colors,
        ),
      ),
    );
  }
}
