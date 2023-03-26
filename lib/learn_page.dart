import 'package:flutter/material.dart';
import 'package:ngsl_builder/word_list.dart';

class LearnPage extends StatefulWidget {
  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  @override
  void initState() {
    super.initState();
    wordList.initLoadList().then((value) {
      setState(() {
        randomIndex = value;
        english = wordList.getLearnEnglish(randomIndex);
        japanese = wordList.getLearnJapanese(randomIndex);
        pos = wordList.getLearnPOS(randomIndex);
      });
    });
  }

  final wordList = WordList();
  late int randomIndex = wordList.getRandomLearnIndex();
  late String english = wordList.getLearnEnglish(randomIndex);
  late String japanese = wordList.getLearnJapanese(randomIndex);
  late String pos = wordList.getLearnPOS(randomIndex);

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
    english = wordList.getLearnEnglish(randomNum);
    japanese = wordList.getLearnJapanese(randomNum);
    pos = wordList.getLearnPOS(randomNum);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NGSL Builder'),
      ),
      body: Container(
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
                      english,
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
            Container(
              padding: const EdgeInsets.all(10),
              width: 340,
              height: 100,
              color: Colors.blue,
              child: Text(
                japanese,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    randomIndex = wordList.getRandomLearnIndex();
                    nextQuiz(randomIndex);
                  },
                  style: OutlinedButton.styleFrom(
                      fixedSize: Size(160, 40),
                      backgroundColor: Colors.blueAccent),
                  child: Text(
                    '×',
                    style: TextStyle(fontSize: 32, color: Colors.black),
                  ),
                ),
                SizedBox(width: 32),
                OutlinedButton(
                  onPressed: () {
                    randomIndex = wordList.getRandomLearnIndex();
                    nextQuiz(randomIndex);
                  },
                  style: OutlinedButton.styleFrom(
                      fixedSize: Size(160, 40),
                      backgroundColor: Colors.blueAccent),
                  child: Text(
                    '〇',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
