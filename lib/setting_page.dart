import 'package:flutter/material.dart';
import 'package:ngsl_builder/word_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final wordList = WordList();
  final langKey = 'langValue';
  bool _switchValue = false; // switchの状態を保持する変数

  @override
  void initState() {
    super.initState();
    _loadSwitchState().then((value) => null);
  }

  // SharedPreferencesからswitchの状態を読み込むメソッド
  Future<void> _loadSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _switchValue = prefs.getBool(langKey) ??
          false; // switchValueというキーで保存された値を取得する。値がなければfalseにする
    });
  }

  // SharedPreferencesにswitchの状態を保存するメソッド
  Future<void> _saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(langKey, value); // switchValueというキーでswitchの状態を保存する
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NGSL単語アプリ'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Text('単語の表示設定',
                style: TextStyle(
                  fontSize: 22,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('英語',
                    style: TextStyle(
                      fontSize: 22,
                    )),
                SizedBox(width: 32),
                Transform.scale(
                  scale: 1.5,
                  child: Switch(
                    value: _switchValue, // switchの状態は変数で管理する
                    onChanged: (value) {
                      setState(() {
                        _switchValue = value; // switchの状態が変わったら変数の値も変える
                      });
                      _saveSwitchState(_switchValue);
                      print(_switchValue);
                    },
                  ),
                ),
                SizedBox(width: 32),
                Text('日本語',
                    style: TextStyle(
                      fontSize: 22,
                    )),
              ],
            ),
            SizedBox(
              height: 32,
            ),
            Text('学習の設定',
                style: TextStyle(
                  fontSize: 22,
                )),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: Size(250, 60)),
              child: Text('学習をリセット',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                  )),
              onPressed: (() {
                wordList.removeLearnList();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
