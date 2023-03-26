import 'package:flutter/material.dart';
import 'package:ngsl_builder/word_list.dart';

class wordSelectPage extends StatefulWidget {
  const wordSelectPage({super.key});

  @override
  State<wordSelectPage> createState() => _wordSelectPageState();
}

class _wordSelectPageState extends State<wordSelectPage> {
  int ListNumber = 0;
  int displayListNumber = 0;
  final wordList = WordList();
  final hundredTrueList = List.filled(100, true);
  List<bool> boolList = List.filled(2800, false);

  @override
  void initState() {
    wordList.initWordSelect().then((value) {
      setState(() {
        value.forEach((index) => boolList[index] = true);
      });
    });

    // wordList.loadList();

    super.initState();
    // wordList.printedList();
  }

  void setBandNumber(int inData) {
    setState(() {
      ListNumber = inData;
    });
  }

  void _selectAll() {
    setState(() {
      wordList.allTrueSelected(ListNumber);
      boolList.setRange(ListNumber * 100, ListNumber * 100 + 100, hundredTrueList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NGSL Builder'),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Text(
                '英単語を選択する',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 8),
              Text(
                '学習したい英単語を追加してください',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 8),
              // ScrollHorizontalAppBar(),
              Container(
                color: Colors.blue,
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemExtent: 96,
                  itemCount: 28,
                  itemBuilder: (context, index) {
                    displayListNumber = index + 1;
                    return TextButton(
                      child: Text(
                        'リスト$displayListNumber',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        setBandNumber(index);
                      },
                    );
                  },
                ),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: 100,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3.5,
                  ),
                  itemBuilder: (context, index2) {
                    return Container(
                      color: Colors.white,
                      child: Container(
                        child: CheckboxListTile(
                          value: boolList[index2 + ListNumber * 100],
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (value) {
                            setState(() {
                              wordList.setSelected(index2, ListNumber, value!);
                              boolList[index2 + ListNumber * 100] = value;
                              // _checked[ListNumber][index2] = value!;
                            });
                          },
                          title: Text(wordList.getEnglish(index2, ListNumber)),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(160, 16),
                      backgroundColor: Color.fromARGB(255, 198, 255, 255),
                    ),
                    child: const Text(
                      'すべて選択',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    onPressed: () {
                      _selectAll();
                    },
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(160, 16),
                      backgroundColor: Color.fromARGB(255, 198, 255, 255),
                    ),
                    child: const Text(
                      '選択項目を追加',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    onPressed: () {
                      setState(() {
                        wordList.addLearnList();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
