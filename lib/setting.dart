import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Setting', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.blue,
          leading: IconButton(
            icon: Icon(Icons.arrow_back), // 返回图标
            color: Colors.white,
            onPressed: () {
              // 当返回图标被点击时，关闭当前页面
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
