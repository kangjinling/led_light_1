import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:led_light/setting.dart';

import 'utils/ToastUtils.dart';
import 'about.dart';
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
  final textController = TextEditingController(text: '#2F19DB');
  String dynamicText = "";
  bool isMusicOn = false;

  @override
  void initState() {
    super.initState();
    dynamicText = textController.text;
  }
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 320.0,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 12.0, bottom: 12),
                    child: GestureDetector(
                      onTap: (){
                        ToastUtils.showToast("1111");
                      },
                      child:Text(
                        textController.text,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ) ,
                    ) ,
                  ),
                ),
                Center(
                  child: Container(
                    width: 300.0,
                    height: 300.0,
                    child: ColorPicker(
                      pickerColor: widget.pickerColor,
                      onColorChanged: widget.onColorChanged,
                      colorPickerWidth: 300,
                      pickerAreaHeightPercent: 1.0,
                      enableAlpha: false,
                      // hexInputController will respect it too.
                      displayThumbColor: true,
                      paletteType: PaletteType.hueWheel,
                      labelTypes: const [],
                      pickerAreaBorderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(2),
                        topRight: Radius.circular(2),
                      ),
                      hexInputController: textController,
                      // <- here
                      portraitOnly: true,
                      hexInputBar: false,
                      colorHistory: widget.colorHistory,
                      onHistoryChanged: widget.onHistoryChanged,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(top: 16.0, right: 12.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // 跳转到新的页面
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return AboutPage(); // 用你的新页面替换 AnotherPage
                                },
                              ),
                            );
                          },
                          child: Icon(
                            Icons.info_outline,
                            size: 28,
                          ), //,
                        ),
                        SizedBox(height: 20.0),
                        GestureDetector(
                          onTap: () {
                            // 跳转到新的页面
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SettingPage(); // 用你的新页面替换 AnotherPage
                                },
                              ),
                            );
                          },
                          child: Icon(
                            Icons.settings,
                            size: 28,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12.0, right: 12.0),
                    child: GestureDetector(
                      onTap: toggleMusic,
                      child: Icon(
                        isMusicOn ? Icons.music_note : Icons.music_off,
                        size: 30,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 12,top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildButton(Color(0xFFFF0000)),
                _buildButton(Color(0xFF00FF08)),
                _buildButton(Color(0xFF0000FF)),
                _buildButton(Color(0xFFFFFF00)),
                _buildButton(Color(0xFFFF07FE)),
                _buildButton(Color(0xFF0FFFF6)),
                _buildButton(Color(0xFFFFFFFF)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(Color color) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonSize = (screenWidth-12 - 84) / 7; // 7 buttons with 12dp gap on each side

    return GestureDetector(
      onTap: (){
        setState(() {
          dynamicText = color.value.toRadixString(16).toUpperCase().padLeft(6, '0').substring(2);;
          textController.text = dynamicText;
        });
      },
      child:Container(
        width: buttonSize,
        height: buttonSize,
        margin: EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ) ,
    );

  }
  void toggleMusic() {
    setState(() {
      isMusicOn = !isMusicOn;
    });
    // 在这里执行音乐开关逻辑，根据 isMusicOn 的值控制音乐播放或暂停
    if (isMusicOn) {
      // 打开音乐
    } else {
      // 关闭音乐
    }
  }
}
