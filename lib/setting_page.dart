import 'package:flutter/material.dart';
import 'package:ngsl_builder/word_list.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final wordList = WordList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NGSL Builder'),
      ),
      body: Container(
        child: ElevatedButton(
          child: Text('学習をリセット'),
          onPressed: (() {
            wordList.removeLearnList();
          }),
        ),
      ),
    );
  }
}
