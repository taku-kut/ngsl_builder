import 'package:flutter/material.dart';
import 'package:ngsl_builder/word_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LearnPage extends StatefulWidget {
  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  @override
  void initState() {
    super.initState();
    _loadSwitchState().then((value) {
      setState(() {
        _onChanged(value);
      });
    });

    wordList.initLoadList().then((value) {
      setState(() {
        randomIndex = value;
        quiz = wordList.getLearnQuiz(randomIndex, quizKey);
        answer = wordList.getLearnAnswer(randomIndex, answerKey);
        pos = wordList.getLearnPOS(randomIndex);
      });
    });
  }

  final langKey = 'langValue';
  final wordList = WordList();
  late int randomIndex = wordList.getRandomLearnIndex();
  late String quiz = wordList.getLearnQuiz(randomIndex, quizKey);
  late String answer = wordList.getLearnAnswer(randomIndex, answerKey);
  late String pos = wordList.getLearnPOS(randomIndex);
  String quizKey = 'english';
  String answerKey = 'japanese';

  bool _buttonVisible = true;
  bool _switchValue = false;

  Future<bool> _loadSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _switchValue = prefs.getBool(langKey) ?? false;
    });
    return _switchValue;
  }

  void _onChanged(bool value) {
    setState(() {
      switch (value) {
        case true:
          quizKey = 'japanese';
          answerKey = 'english';
          break;
        default:
          quizKey = 'english';
          answerKey = 'japanese';
          break;
      }
    });
  }

// 図形を表すウィジェット
  Container shape = Container(
    width: 340,
    height: 100,
    color: Colors.blue,
  );

// 線を表すウィジェット
  Container line = Container(
    width: 240,
    height: 1,
    color: Colors.white,
  );

  void nextQuiz(int randomNum) {
    quiz = wordList.getLearnQuiz(randomNum, quizKey);
    answer = wordList.getLearnAnswer(randomNum, answerKey);
    pos = wordList.getLearnPOS(randomNum);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NGSL単語アプリ'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Stack(
                    alignment: Alignment.center, // 子ウィジェットを中央に配置する
                    children: [
                      shape, // 図形を一番下に置く
                      Column(
                        // 単語と線を横に並べる
                        mainAxisAlignment:
                            MainAxisAlignment.center, // 単語と線を横方向の中央に揃える
                        children: [
                          SizedBox(height: 8),
                          Text(
                            quiz,
                            style: TextStyle(fontSize: 22, color: Colors.black),
                          ), // 最初の単語
                          SizedBox(height: 12), // 単語と線の間にスペースを入れる
                          line, // 線
                          SizedBox(height: 8), // 線と単語の間にスペースを入れる
                          Text(
                            pos,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ), // 次の単語
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  _buttonVisible
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(340, 100)),
                          child: Text(
                            '答えを見る',
                            style: TextStyle(fontSize: 22, color: Colors.black),
                          ),
                          onPressed: () {
                            setState(() {
                              _buttonVisible = false;
                            });
                          },
                        )
                      : Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              width: 340,
                              height: 100,
                              color: Colors.blue,
                              child: Text(
                                answer,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ),
                            SizedBox(height: 32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    randomIndex =
                                        wordList.getRandomLearnIndex();
                                    nextQuiz(randomIndex);
                                    setState(() {
                                      _buttonVisible = true;
                                    });
                                  },
                                  style: OutlinedButton.styleFrom(
                                      fixedSize: Size(160, 40),
                                      backgroundColor: Colors.blueAccent),
                                  child: Text(
                                    '×',
                                    style: TextStyle(
                                        fontSize: 32, color: Colors.black),
                                  ),
                                ),
                                SizedBox(width: 32),
                                OutlinedButton(
                                  onPressed: () {
                                    randomIndex =
                                        wordList.getRandomLearnIndex();
                                    nextQuiz(randomIndex);
                                    setState(() {
                                      _buttonVisible = true;
                                    });
                                  },
                                  style: OutlinedButton.styleFrom(
                                      fixedSize: Size(160, 40),
                                      backgroundColor: Colors.blueAccent),
                                  child: Text(
                                    '〇',
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                SizedBox(height: 64),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '学習中の単語数',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 64),
                    Text(
                      wordList.getLearnListLength().toString(),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
