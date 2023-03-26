import 'dart:async';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class WordList {
  WordList();
  String saveKey = 'KEY';
  List<int> indexLearnList = [];
  List<String> stringList = [];

  Future<void> loadList() async {
    final prefs = await SharedPreferences.getInstance();
    stringList = await prefs.getStringList(saveKey) ?? [];
    indexLearnList = await stringList.map((s) => int.parse(s)).toList();
    // print(stringList);
    // print('4');
    // print(indexLearnList);
  }

  Future<void> saveList() async {
    final prefs = await SharedPreferences.getInstance();
    stringList = indexLearnList.map((i) => i.toString()).toList();
    await prefs.setStringList(saveKey, stringList);
  }

  Future<int> initLoadList() async {
    final prefs = await SharedPreferences.getInstance();
    stringList = prefs.getStringList(saveKey) ?? [];
    indexLearnList = stringList.map((s) => int.parse(s)).toList();
    return getRandomLearnIndex();
  }

  Future<List> initWordSelect() async {
    final prefs = await SharedPreferences.getInstance();
    stringList = prefs.getStringList(saveKey) ?? [];
    indexLearnList = stringList.map((s) => int.parse(s)).toList();
    indexLearnList.forEach((index) => ngslList[index]['selected'] = true);
    return indexLearnList;
  }

  Future<void> removeLearnList() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(saveKey);
  }

  String getEnglish(int num, int bandNumber) {
    return ngslList[num + (bandNumber * 100)]['english'];
  }

  bool getSelected(int num, int bandNumber) {
    return ngslList[num + (bandNumber * 100)]['selected'];
  }

  void setSelected(int num, int bandNumber, bool value) {
    ngslList[num + (bandNumber * 100)]['selected'] = value;
  }

  void allTrueSelected(int bandNumber) {
    final start = bandNumber * 100;
    final end = start + 100;
// 指定した範囲のインデックスに対して、mapメソッドでvalueを変更する
    ngslList = ngslList.map((map) {
      // インデックスを取得する
      int index = ngslList.indexOf(map);
      // インデックスが範囲内ならば、valueを変更する
      if (index >= start && index < end) {
        map['selected'] = true;
      }
      // mapを返す
      return map;
    }).toList(); // mapメソッドはIterableを返すため、toList()でListに変換する
  }

  void addLearnList() {
    indexLearnList = List.generate(ngslList.length, (i) => i)
        .where((i) => ngslList[i]['selected'] == true)
        .toList();
    saveList();
  }

  int getRandomLearnIndex() {
    if (indexLearnList.isEmpty) {
      return ngslList.length - 1;
    } else {
      return indexLearnList[Random().nextInt(indexLearnList.length)];
    }
  }

  String getLearnEnglish(int index) {
    return ngslList[index]['english'];
  }

  String getLearnJapanese(int index) {
    return ngslList[index]['japanese'];
  }

  String getLearnPOS(int index) {
    return ngslList[index]['POS'];
  }



  List<Map<String, dynamic>> ngslList = [
    {'english': 'the', 'japanese': 'その', 'POS': 'article', 'selected': false},
    {'english': 'be', 'japanese': 'である', 'POS': 'verb', 'selected': false},
    {
      'english': 'and',
      'japanese': '～と',
      'POS': 'conjunction',
      'selected': false
    },
    {'english': 'of', 'japanese': 'の', 'POS': 'preposition', 'selected': false},
    {
      'english': 'to',
      'japanese': '～へ',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'a', 'japanese': '一つの', 'POS': 'article', 'selected': false},
    {
      'english': 'in',
      'japanese': '～の中',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'have', 'japanese': '持つ', 'POS': 'verb', 'selected': false},
    {'english': 'it', 'japanese': 'それ', 'POS': 'pronoun', 'selected': false},
    {'english': 'you', 'japanese': 'あなた', 'POS': 'pronoun', 'selected': false},
    {'english': 'he', 'japanese': '彼', 'POS': 'pronoun', 'selected': false},
    {
      'english': 'for',
      'japanese': '～のため',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'they', 'japanese': '彼ら', 'POS': 'pronoun', 'selected': false},
    {'english': 'not', 'japanese': '～でない', 'POS': 'adverb', 'selected': false},
    {
      'english': 'that',
      'japanese': 'あの',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'we', 'japanese': '私たち', 'POS': 'pronoun', 'selected': false},
    {
      'english': 'on',
      'japanese': '～に接して',
      'POS': 'preposition',
      'selected': false
    },
    {
      'english': 'with',
      'japanese': '～と一緒',
      'POS': 'preposition',
      'selected': false
    },
    {
      'english': 'this',
      'japanese': 'この',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'I', 'japanese': '私は', 'POS': 'pronoun', 'selected': false},
    {'english': 'do', 'japanese': 'する', 'POS': 'verb', 'selected': false},
    {
      'english': 'as',
      'japanese': '～のように',
      'POS': 'conjunction',
      'selected': false
    },
    {
      'english': 'at',
      'japanese': '～で',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'she', 'japanese': '彼女', 'POS': 'pronoun', 'selected': false},
    {
      'english': 'but',
      'japanese': 'でも',
      'POS': 'conjunction',
      'selected': false
    },
    {
      'english': 'from',
      'japanese': '～から',
      'POS': 'preposition',
      'selected': false
    },
    {
      'english': 'by',
      'japanese': 'の近くに',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'will', 'japanese': '～だろう', 'POS': 'verb', 'selected': false},
    {
      'english': 'or',
      'japanese': '～か',
      'POS': 'conjunction',
      'selected': false
    },
    {'english': 'say', 'japanese': '言う', 'POS': 'verb', 'selected': false},
    {'english': 'go', 'japanese': '行く', 'POS': 'verb', 'selected': false},
    {'english': 'so', 'japanese': 'とても', 'POS': 'adverb', 'selected': false},
    {
      'english': 'all',
      'japanese': '全て',
      'POS': 'determiner',
      'selected': false
    },
    {
      'english': 'if',
      'japanese': 'もし',
      'POS': 'conjunction',
      'selected': false
    },
    {
      'english': 'one',
      'japanese': '1、ひとり、ひとつ',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'would', 'japanese': '～だろう', 'POS': 'verb', 'selected': false},
    {
      'english': 'about',
      'japanese': '～について',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'can', 'japanese': '～できる', 'POS': 'verb', 'selected': false},
    {
      'english': 'which',
      'japanese': 'どちらか',
      'POS': 'pronoun',
      'selected': false
    },
    {'english': 'there', 'japanese': 'そこ', 'POS': 'adverb', 'selected': false},
    {'english': 'know', 'japanese': '知る', 'POS': 'verb', 'selected': false},
    {'english': 'more', 'japanese': 'もっと', 'POS': 'adverb', 'selected': false},
    {'english': 'get', 'japanese': '得る', 'POS': 'verb', 'selected': false},
    {'english': 'who', 'japanese': '誰', 'POS': 'pronoun', 'selected': false},
    {'english': 'like', 'japanese': '好む', 'POS': 'verb', 'selected': false},
    {'english': 'when', 'japanese': 'どこ', 'POS': 'adverb', 'selected': false},
    {'english': 'think', 'japanese': '思う', 'POS': 'verb', 'selected': false},
    {'english': 'make', 'japanese': '作る', 'POS': 'verb', 'selected': false},
    {'english': 'time', 'japanese': '時間', 'POS': 'noun', 'selected': false},
    {'english': 'see', 'japanese': '見る', 'POS': 'verb', 'selected': false},
    {'english': 'what', 'japanese': 'なに', 'POS': 'pronoun', 'selected': false},
    {'english': 'up', 'japanese': '上がる', 'POS': 'adverb', 'selected': false},
    {
      'english': 'some',
      'japanese': 'いくらか',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'other',
      'japanese': '他',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'out', 'japanese': '外へ', 'POS': 'adverb', 'selected': false},
    {
      'english': 'good',
      'japanese': '良い',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'people', 'japanese': '人々', 'POS': 'noun', 'selected': false},
    {'english': 'year', 'japanese': '年', 'POS': 'noun', 'selected': false},
    {
      'english': 'take',
      'japanese': '持っていく、取る',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'no', 'japanese': 'いいえ、ない', 'POS': 'adverb', 'selected': false},
    {
      'english': 'well',
      'japanese': '上手く、上手に',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'because',
      'japanese': 'なぜならば',
      'POS': 'conjunction',
      'selected': false
    },
    {'english': 'very', 'japanese': 'とても', 'POS': 'adverb', 'selected': false},
    {'english': 'just', 'japanese': 'ただ～', 'POS': 'adverb', 'selected': false},
    {'english': 'come', 'japanese': '来る', 'POS': 'verb', 'selected': false},
    {'english': 'could', 'japanese': 'できた', 'POS': 'verb', 'selected': false},
    {'english': 'work', 'japanese': '働く', 'POS': 'verb', 'selected': false},
    {'english': 'use', 'japanese': '使う', 'POS': 'verb', 'selected': false},
    {
      'english': 'than',
      'japanese': '～より',
      'POS': 'conjunction',
      'selected': false
    },
    {'english': 'now', 'japanese': '今', 'POS': 'adverb', 'selected': false},
    {
      'english': 'then',
      'japanese': 'その時、それから',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'also', 'japanese': '～もまた', 'POS': 'adverb', 'selected': false},
    {
      'english': 'into',
      'japanese': '～の中に',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'only', 'japanese': 'たった', 'POS': 'adverb', 'selected': false},
    {'english': 'look', 'japanese': '見る', 'POS': 'verb', 'selected': false},
    {'english': 'want', 'japanese': '欲しい', 'POS': 'verb', 'selected': false},
    {'english': 'give', 'japanese': '与える', 'POS': 'verb', 'selected': false},
    {'english': 'first', 'japanese': '最初', 'POS': 'ord', 'selected': false},
    {
      'english': 'new',
      'japanese': '新しい',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'way', 'japanese': '方法', 'POS': 'noun', 'selected': false},
    {'english': 'find', 'japanese': '見つける', 'POS': 'verb', 'selected': false},
    {
      'english': 'over',
      'japanese': '超える',
      'POS': 'preposition',
      'selected': false
    },
    {
      'english': 'any',
      'japanese': '何か',
      'POS': 'determiner',
      'selected': false
    },
    {
      'english': 'after',
      'japanese': '後で',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'day', 'japanese': '日', 'POS': 'noun', 'selected': false},
    {'english': 'where', 'japanese': 'どこ', 'POS': 'adverb', 'selected': false},
    {'english': 'thing', 'japanese': '物', 'POS': 'noun', 'selected': false},
    {'english': 'most', 'japanese': 'もっとも', 'POS': 'adverb', 'selected': false},
    {'english': 'should', 'japanese': '～すべき', 'POS': 'verb', 'selected': false},
    {'english': 'need', 'japanese': '必要とする', 'POS': 'verb', 'selected': false},
    {'english': 'much', 'japanese': 'たくさん', 'POS': 'adverb', 'selected': false},
    {
      'english': 'right',
      'japanese': '正しい',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'how',
      'japanese': 'どのようにして',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'back', 'japanese': '背', 'POS': 'noun', 'selected': false},
    {
      'english': 'mean',
      'japanese': '～するつもりだ',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'even',
      'japanese': '平らな、等しい',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'may', 'japanese': 'かもしれない', 'POS': 'verb', 'selected': false},
    {'english': 'here', 'japanese': 'ここ', 'POS': 'adverb', 'selected': false},
    {
      'english': 'many',
      'japanese': 'たくさん',
      'POS': 'determiner',
      'selected': false
    },
    {
      'english': 'such',
      'japanese': 'そのような',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'last', 'japanese': '最後', 'POS': 'ord', 'selected': false},
    {'english': 'child', 'japanese': '子供', 'POS': 'noun', 'selected': false},
    {'english': 'tell', 'japanese': '話す', 'POS': 'verb', 'selected': false},
    {
      'english': 'really',
      'japanese': '本当に',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'call', 'japanese': '呼ぶ', 'POS': 'verb', 'selected': false},
    {
      'english': 'before',
      'japanese': '以前',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'company', 'japanese': '会社', 'POS': 'noun', 'selected': false},
    {
      'english': 'through',
      'japanese': '～の間',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'down', 'japanese': '下へ', 'POS': 'adverb', 'selected': false},
    {'english': 'show', 'japanese': '見せる', 'POS': 'verb', 'selected': false},
    {'english': 'life', 'japanese': '生命', 'POS': 'noun', 'selected': false},
    {'english': 'man', 'japanese': '男性', 'POS': 'noun', 'selected': false},
    {'english': 'change', 'japanese': '変える', 'POS': 'verb', 'selected': false},
    {'english': 'place', 'japanese': '場所', 'POS': 'noun', 'selected': false},
    {
      'english': 'long',
      'japanese': '長い',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'between',
      'japanese': '～の間',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'feel', 'japanese': '感じる', 'POS': 'verb', 'selected': false},
    {'english': 'too', 'japanese': '～もまた', 'POS': 'adverb', 'selected': false},
    {'english': 'still', 'japanese': 'まだ', 'POS': 'adverb', 'selected': false},
    {'english': 'problem', 'japanese': '問題', 'POS': 'noun', 'selected': false},
    {'english': 'write', 'japanese': '書く', 'POS': 'verb', 'selected': false},
    {
      'english': 'same',
      'japanese': '同じ',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'lot', 'japanese': '用地', 'POS': 'noun', 'selected': false},
    {
      'english': 'great',
      'japanese': '巨大な、多量の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'try', 'japanese': '試す', 'POS': 'verb', 'selected': false},
    {'english': 'leave', 'japanese': '去る', 'POS': 'verb', 'selected': false},
    {'english': 'number', 'japanese': '数字', 'POS': 'noun', 'selected': false},
    {
      'english': 'both',
      'japanese': '両方とも',
      'POS': 'determiner',
      'selected': false
    },
    {
      'english': 'own',
      'japanese': '自身の',
      'POS': 'determiner',
      'selected': false
    },
    {'english': 'part', 'japanese': '部品', 'POS': 'noun', 'selected': false},
    {'english': 'point', 'japanese': '主張', 'POS': 'noun', 'selected': false},
    {
      'english': 'little',
      'japanese': '少し、小さい',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'help', 'japanese': '助ける', 'POS': 'verb', 'selected': false},
    {'english': 'ask', 'japanese': '求める', 'POS': 'verb', 'selected': false},
    {'english': 'meet', 'japanese': '会う', 'POS': 'verb', 'selected': false},
    {'english': 'start', 'japanese': '始める', 'POS': 'verb', 'selected': false},
    {'english': 'talk', 'japanese': '話す', 'POS': 'verb', 'selected': false},
    {
      'english': 'something',
      'japanese': '何か',
      'POS': 'pronoun',
      'selected': false
    },
    {'english': 'put', 'japanese': '置く', 'POS': 'verb', 'selected': false},
    {
      'english': 'another',
      'japanese': 'もう一つ',
      'POS': 'determiner',
      'selected': false
    },
    {'english': 'become', 'japanese': 'なる', 'POS': 'verb', 'selected': false},
    {'english': 'interest', 'japanese': '興味', 'POS': 'noun', 'selected': false},
    {'english': 'country', 'japanese': '国', 'POS': 'noun', 'selected': false},
    {'english': 'old', 'japanese': '古い', 'POS': 'adjective', 'selected': false},
    {
      'english': 'each',
      'japanese': '各々',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'school', 'japanese': '学校', 'POS': 'noun', 'selected': false},
    {
      'english': 'late',
      'japanese': '遅れる',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'high',
      'japanese': '高い',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'different',
      'japanese': '違う',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'off', 'japanese': '離れて', 'POS': 'adverb', 'selected': false},
    {'english': 'next', 'japanese': '次', 'POS': 'ord', 'selected': false},
    {'english': 'end', 'japanese': '終わり', 'POS': 'noun', 'selected': false},
    {'english': 'live', 'japanese': '生きる', 'POS': 'verb', 'selected': false},
    {'english': 'why', 'japanese': 'なぜ', 'POS': 'adverb', 'selected': false},
    {
      'english': 'while',
      'japanese': '間',
      'POS': 'conjunction',
      'selected': false
    },
    {'english': 'world', 'japanese': '世界', 'POS': 'noun', 'selected': false},
    {'english': 'week', 'japanese': '週', 'POS': 'noun', 'selected': false},
    {'english': 'play', 'japanese': '遊ぶ', 'POS': 'verb', 'selected': false},
    {
      'english': 'might',
      'japanese': '～かもしれない',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'must',
      'japanese': '～しなければならない',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'home', 'japanese': '住まい', 'POS': 'noun', 'selected': false},
    {
      'english': 'never',
      'japanese': '決して～しない',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'include', 'japanese': '含む', 'POS': 'verb', 'selected': false},
    {'english': 'course', 'japanese': '進路', 'POS': 'noun', 'selected': false},
    {'english': 'house', 'japanese': '家', 'POS': 'noun', 'selected': false},
    {'english': 'report', 'japanese': '報告', 'POS': 'noun', 'selected': false},
    {'english': 'group', 'japanese': '集団', 'POS': 'noun', 'selected': false},
    {'english': 'case', 'japanese': '事例', 'POS': 'noun', 'selected': false},
    {'english': 'woman', 'japanese': '女性', 'POS': 'noun', 'selected': false},
    {
      'english': 'around',
      'japanese': '～の周りに',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'book', 'japanese': '本', 'POS': 'noun', 'selected': false},
    {'english': 'family', 'japanese': '家族', 'POS': 'noun', 'selected': false},
    {
      'english': 'seem',
      'japanese': '～のように思われる',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'let', 'japanese': 'させる', 'POS': 'verb', 'selected': false},
    {'english': 'again', 'japanese': '再び', 'POS': 'adverb', 'selected': false},
    {
      'english': 'kind',
      'japanese': '親切',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'keep', 'japanese': '保つ', 'POS': 'verb', 'selected': false},
    {'english': 'hear', 'japanese': '聞く', 'POS': 'verb', 'selected': false},
    {'english': 'system', 'japanese': 'システム', 'POS': 'noun', 'selected': false},
    {
      'english': 'every',
      'japanese': '毎',
      'POS': 'determiner',
      'selected': false
    },
    {
      'english': 'question',
      'japanese': '質問する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'during',
      'japanese': '間',
      'POS': 'preposition',
      'selected': false
    },
    {
      'english': 'always',
      'japanese': 'いつも',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'big',
      'japanese': '大きい',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'set', 'japanese': '設置する', 'POS': 'verb', 'selected': false},
    {
      'english': 'small',
      'japanese': '小さい',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'study',
      'japanese': '勉強する、研究する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'follow',
      'japanese': 'ついて行く',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'begin', 'japanese': '始める', 'POS': 'verb', 'selected': false},
    {
      'english': 'important',
      'japanese': '大切',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'since',
      'japanese': '～なので、～だから',
      'POS': 'conjunction',
      'selected': false
    },
    {'english': 'run', 'japanese': '走る', 'POS': 'verb', 'selected': false},
    {
      'english': 'under',
      'japanese': '下に',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'turn', 'japanese': '回る', 'POS': 'verb', 'selected': false},
    {
      'english': 'few',
      'japanese': '少し',
      'POS': 'determiner',
      'selected': false
    },
    {'english': 'bring', 'japanese': '持っていく', 'POS': 'verb', 'selected': false},
    {
      'english': 'early',
      'japanese': '早い',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'hand', 'japanese': '手', 'POS': 'noun', 'selected': false},
    {'english': 'state', 'japanese': '状態', 'POS': 'noun', 'selected': false},
    {'english': 'move', 'japanese': '動かす', 'POS': 'verb', 'selected': false},
    {'english': 'money', 'japanese': '金', 'POS': 'noun', 'selected': false},
    {'english': 'fact', 'japanese': '事実', 'POS': 'noun', 'selected': false},
    {
      'english': 'however',
      'japanese': 'しかし',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'area', 'japanese': '地域', 'POS': 'noun', 'selected': false},
    {
      'english': 'provide',
      'japanese': '提供する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'name', 'japanese': '名前', 'POS': 'noun', 'selected': false},
    {'english': 'read', 'japanese': '読む', 'POS': 'verb', 'selected': false},
    {'english': 'friend', 'japanese': '友達', 'POS': 'noun', 'selected': false},
    {'english': 'month', 'japanese': '口', 'POS': 'noun', 'selected': false},
    {
      'english': 'large',
      'japanese': '大きい',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'business',
      'japanese': 'ビジネス、商売',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'without',
      'japanese': '～なしに',
      'POS': 'preposition',
      'selected': false
    },
    {
      'english': 'information',
      'japanese': '情報',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'open',
      'japanese': '開いている',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'order', 'japanese': '命令', 'POS': 'noun', 'selected': false},
    {
      'english': 'government',
      'japanese': '政府',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'word', 'japanese': '語', 'POS': 'noun', 'selected': false},
    {'english': 'issue', 'japanese': '問題', 'POS': 'noun', 'selected': false},
    {'english': 'market', 'japanese': '市場', 'POS': 'noun', 'selected': false},
    {'english': 'pay', 'japanese': 'はらう', 'POS': 'verb', 'selected': false},
    {'english': 'build', 'japanese': '建てる', 'POS': 'verb', 'selected': false},
    {'english': 'hold', 'japanese': '手に持つ', 'POS': 'verb', 'selected': false},
    {
      'english': 'service',
      'japanese': '奉仕、勤務',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'against',
      'japanese': '反対に、逆らって',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'believe', 'japanese': '信じる', 'POS': 'verb', 'selected': false},
    {'english': 'second', 'japanese': '秒', 'POS': 'ord', 'selected': false},
    {
      'english': 'though',
      'japanese': 'だが',
      'POS': 'conjunction',
      'selected': false
    },
    {
      'english': 'yes',
      'japanese': 'はい',
      'POS': 'interjection',
      'selected': false
    },
    {'english': 'love', 'japanese': '愛', 'POS': 'noun', 'selected': false},
    {
      'english': 'increase',
      'japanese': '増える',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'job', 'japanese': '仕事', 'POS': 'noun', 'selected': false},
    {'english': 'plan', 'japanese': '予定', 'POS': 'noun', 'selected': false},
    {'english': 'result', 'japanese': '結果', 'POS': 'noun', 'selected': false},
    {
      'english': 'away',
      'japanese': '離れて・去って',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'example', 'japanese': '例', 'POS': 'noun', 'selected': false},
    {'english': 'happen', 'japanese': '起こる', 'POS': 'verb', 'selected': false},
    {'english': 'offer', 'japanese': '申し出る', 'POS': 'verb', 'selected': false},
    {
      'english': 'young',
      'japanese': '若い',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'close', 'japanese': '閉める', 'POS': 'verb', 'selected': false},
    {
      'english': 'program',
      'japanese': 'プログラム',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'lead', 'japanese': '導く', 'POS': 'verb', 'selected': false},
    {'english': 'buy', 'japanese': '買う', 'POS': 'verb', 'selected': false},
    {
      'english': 'understand',
      'japanese': '理解する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'thank', 'japanese': '感謝する', 'POS': 'verb', 'selected': false},
    {'english': 'far', 'japanese': '遠い', 'POS': 'adverb', 'selected': false},
    {'english': 'today', 'japanese': '今日', 'POS': 'noun', 'selected': false},
    {'english': 'hour', 'japanese': '時間', 'POS': 'noun', 'selected': false},
    {'english': 'student', 'japanese': '生徒', 'POS': 'noun', 'selected': false},
    {'english': 'face', 'japanese': '顔', 'POS': 'noun', 'selected': false},
    {'english': 'hope', 'japanese': '望む', 'POS': 'noun', 'selected': false},
    {'english': 'idea', 'japanese': 'アイデア', 'POS': 'noun', 'selected': false},
    {'english': 'cost', 'japanese': '費用', 'POS': 'noun', 'selected': false},
    {
      'english': 'less',
      'japanese': 'より少ない',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'room', 'japanese': '部屋', 'POS': 'noun', 'selected': false},
    {
      'english': 'until',
      'japanese': 'まで',
      'POS': 'conjunction',
      'selected': false
    },
    {'english': 'reason', 'japanese': '理由', 'POS': 'noun', 'selected': false},
    {'english': 'form', 'japanese': '形', 'POS': 'noun', 'selected': false},
    {'english': 'spend', 'japanese': '費やす', 'POS': 'verb', 'selected': false},
    {'english': 'head', 'japanese': '頭', 'POS': 'noun', 'selected': false},
    {'english': 'car', 'japanese': '車', 'POS': 'noun', 'selected': false},
    {'english': 'learn', 'japanese': '学ぶ', 'POS': 'verb', 'selected': false},
    {'english': 'level', 'japanese': '高さ', 'POS': 'noun', 'selected': false},
    {'english': 'person', 'japanese': '人', 'POS': 'noun', 'selected': false},
    {
      'english': 'experience',
      'japanese': '経験',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'once', 'japanese': '一度', 'POS': 'adverb', 'selected': false},
    {'english': 'member', 'japanese': 'メンバー', 'POS': 'noun', 'selected': false},
    {'english': 'enough', 'japanese': '十分', 'POS': 'adverb', 'selected': false},
    {'english': 'bad', 'japanese': '悪い', 'POS': 'adjective', 'selected': false},
    {'english': 'city', 'japanese': '都市', 'POS': 'noun', 'selected': false},
    {'english': 'night', 'japanese': '夜', 'POS': 'noun', 'selected': false},
    {
      'english': 'able',
      'japanese': 'できる',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'support', 'japanese': '支える', 'POS': 'verb', 'selected': false},
    {
      'english': 'whether',
      'japanese': '～かどうか',
      'POS': 'conjunction',
      'selected': false
    },
    {'english': 'line', 'japanese': '線', 'POS': 'noun', 'selected': false},
    {
      'english': 'present',
      'japanese': '現在',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'side', 'japanese': '端', 'POS': 'noun', 'selected': false},
    {'english': 'quite', 'japanese': 'かなり', 'POS': 'adverb', 'selected': false},
    {
      'english': 'although',
      'japanese': 'だけれども',
      'POS': 'conjunction',
      'selected': false
    },
    {
      'english': 'sure',
      'japanese': '確信',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'term', 'japanese': '用語', 'POS': 'noun', 'selected': false},
    {
      'english': 'least',
      'japanese': '最小',
      'POS': 'determiner',
      'selected': false
    },
    {'english': 'age', 'japanese': '年齢', 'POS': 'noun', 'selected': false},
    {'english': 'low', 'japanese': '低い', 'POS': 'adjective', 'selected': false},
    {'english': 'speak', 'japanese': '話す', 'POS': 'verb', 'selected': false},
    {
      'english': 'within',
      'japanese': '以内に',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'process', 'japanese': '過程', 'POS': 'noun', 'selected': false},
    {
      'english': 'public',
      'japanese': '公共',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'often',
      'japanese': 'しばしば',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'train', 'japanese': '電車', 'POS': 'noun', 'selected': false},
    {
      'english': 'possible',
      'japanese': '可能性',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'actually',
      'japanese': '実際',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'rather',
      'japanese': 'やや、割に',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'view', 'japanese': '見解', 'POS': 'noun', 'selected': false},
    {
      'english': 'together',
      'japanese': '一緒に',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'consider',
      'japanese': 'よく考える',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'price', 'japanese': '価格', 'POS': 'noun', 'selected': false},
    {'english': 'parent', 'japanese': '親', 'POS': 'noun', 'selected': false},
    {
      'english': 'hard',
      'japanese': '固い',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'party', 'japanese': '政党', 'POS': 'noun', 'selected': false},
    {
      'english': 'local',
      'japanese': '地方の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'control',
      'japanese': '操作する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'already',
      'japanese': 'すでに',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'concern',
      'japanese': '心配する',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'product',
      'japanese': '製品、生産物',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'lose', 'japanese': '失う', 'POS': 'verb', 'selected': false},
    {'english': 'story', 'japanese': '物語', 'POS': 'noun', 'selected': false},
    {
      'english': 'almost',
      'japanese': 'ほとんど',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'continue',
      'japanese': '続ける',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'stand', 'japanese': '立つ', 'POS': 'verb', 'selected': false},
    {
      'english': 'whole',
      'japanese': '全体',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'yet', 'japanese': 'まだ', 'POS': 'adverb', 'selected': false},
    {'english': 'rate', 'japanese': '速度、率', 'POS': 'noun', 'selected': false},
    {'english': 'care', 'japanese': '注意', 'POS': 'noun', 'selected': false},
    {'english': 'expect', 'japanese': '期待する', 'POS': 'verb', 'selected': false},
    {'english': 'effect', 'japanese': '効果', 'POS': 'noun', 'selected': false},
    {'english': 'sort', 'japanese': '一部', 'POS': 'noun', 'selected': false},
    {'english': 'ever', 'japanese': '今までに', 'POS': 'adverb', 'selected': false},
    {
      'english': 'anything',
      'japanese': '何でも',
      'POS': 'pronoun',
      'selected': false
    },
    {'english': 'cause', 'japanese': '要因', 'POS': 'noun', 'selected': false},
    {'english': 'fall', 'japanese': '落ちる', 'POS': 'verb', 'selected': false},
    {'english': 'deal', 'japanese': '取引', 'POS': 'verb', 'selected': false},
    {'english': 'water', 'japanese': '水', 'POS': 'noun', 'selected': false},
    {'english': 'send', 'japanese': '送る', 'POS': 'verb', 'selected': false},
    {'english': 'allow', 'japanese': '許可する', 'POS': 'verb', 'selected': false},
    {'english': 'soon', 'japanese': 'すぐに', 'POS': 'adverb', 'selected': false},
    {'english': 'watch', 'japanese': '見る', 'POS': 'verb', 'selected': false},
    {'english': 'base', 'japanese': '土台', 'POS': 'noun', 'selected': false},
    {
      'english': 'probably',
      'japanese': 'おそらく',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'suggest',
      'japanese': '提案する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'past',
      'japanese': '過去',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'power', 'japanese': '力', 'POS': 'noun', 'selected': false},
    {'english': 'test', 'japanese': 'テスト', 'POS': 'noun', 'selected': false},
    {'english': 'visit', 'japanese': '訪問する', 'POS': 'verb', 'selected': false},
    {'english': 'center', 'japanese': '中央', 'POS': 'noun', 'selected': false},
    {'english': 'grow', 'japanese': '育つ', 'POS': 'verb', 'selected': false},
    {
      'english': 'nothing',
      'japanese': '無',
      'POS': 'pronoun',
      'selected': false
    },
    {'english': 'return', 'japanese': '戻る', 'POS': 'verb', 'selected': false},
    {'english': 'mother', 'japanese': '母', 'POS': 'noun', 'selected': false},
    {'english': 'walk', 'japanese': '歩く', 'POS': 'verb', 'selected': false},
    {'english': 'matter', 'japanese': '物質', 'POS': 'noun', 'selected': false},
    {'english': 'mind', 'japanese': '心', 'POS': 'noun', 'selected': false},
    {'english': 'value', 'japanese': '価値', 'POS': 'noun', 'selected': false},
    {'english': 'office', 'japanese': '事務所', 'POS': 'noun', 'selected': false},
    {'english': 'record', 'japanese': '記録', 'POS': 'noun', 'selected': false},
    {'english': 'stay', 'japanese': 'とどまる', 'POS': 'verb', 'selected': false},
    {'english': 'force', 'japanese': '強いる', 'POS': 'verb', 'selected': false},
    {'english': 'stop', 'japanese': '止まる', 'POS': 'verb', 'selected': false},
    {
      'english': 'several',
      'japanese': '数個の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'light', 'japanese': '光、明かり', 'POS': 'noun', 'selected': false},
    {
      'english': 'develop',
      'japanese': '発展させる',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'remember',
      'japanese': '思い出す',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'bit', 'japanese': '少し', 'POS': 'noun', 'selected': false},
    {'english': 'share', 'japanese': '共有する', 'POS': 'verb', 'selected': false},
    {
      'english': 'real',
      'japanese': '本当の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'answer', 'japanese': '答え', 'POS': 'noun', 'selected': false},
    {'english': 'sit', 'japanese': '座る', 'POS': 'verb', 'selected': false},
    {'english': 'figure', 'japanese': '図', 'POS': 'noun', 'selected': false},
    {'english': 'letter', 'japanese': '文字', 'POS': 'noun', 'selected': false},
    {'english': 'decide', 'japanese': '決める', 'POS': 'verb', 'selected': false},
    {'english': 'language', 'japanese': '言語', 'POS': 'noun', 'selected': false},
    {'english': 'subject', 'japanese': '主題', 'POS': 'noun', 'selected': false},
    {'english': 'class', 'japanese': 'クラス', 'POS': 'noun', 'selected': false},
    {
      'english': 'development',
      'japanese': '開発',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'town', 'japanese': '町', 'POS': 'noun', 'selected': false},
    {
      'english': 'half',
      'japanese': '半分',
      'POS': 'determiner',
      'selected': false
    },
    {'english': 'minute', 'japanese': '分', 'POS': 'noun', 'selected': false},
    {'english': 'food', 'japanese': '食べ物', 'POS': 'noun', 'selected': false},
    {'english': 'break', 'japanese': '壊す', 'POS': 'verb', 'selected': false},
    {
      'english': 'clear',
      'japanese': '明らかに',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'future', 'japanese': '未来', 'POS': 'noun', 'selected': false},
    {
      'english': 'either',
      'japanese': 'どちらか',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'ago', 'japanese': '以前に', 'POS': 'adverb', 'selected': false},
    {
      'english': 'per',
      'japanese': '～につき',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'remain', 'japanese': '残る', 'POS': 'verb', 'selected': false},
    {'english': 'top', 'japanese': '最上部', 'POS': 'noun', 'selected': false},
    {
      'english': 'among',
      'japanese': '～の間で',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'win', 'japanese': '勝つ', 'POS': 'verb', 'selected': false},
    {'english': 'color', 'japanese': '色', 'POS': 'noun', 'selected': false},
    {
      'english': 'involve',
      'japanese': '巻き込む',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'reach', 'japanese': '届く', 'POS': 'verb', 'selected': false},
    {
      'english': 'social',
      'japanese': '社会の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'period', 'japanese': '期間', 'POS': 'noun', 'selected': false},
    {
      'english': 'across',
      'japanese': '横切って',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'note', 'japanese': 'メモ', 'POS': 'noun', 'selected': false},
    {'english': 'history', 'japanese': '歴史', 'POS': 'noun', 'selected': false},
    {'english': 'create', 'japanese': '作る', 'POS': 'verb', 'selected': false},
    {'english': 'drive', 'japanese': '運転する', 'POS': 'verb', 'selected': false},
    {
      'english': 'along',
      'japanese': '沿って',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'type', 'japanese': '型', 'POS': 'noun', 'selected': false},
    {'english': 'sound', 'japanese': '音', 'POS': 'noun', 'selected': false},
    {'english': 'eye', 'japanese': '目', 'POS': 'noun', 'selected': false},
    {'english': 'music', 'japanese': '音楽', 'POS': 'noun', 'selected': false},
    {'english': 'game', 'japanese': 'ゲーム、競技', 'POS': 'noun', 'selected': false},
    {
      'english': 'political',
      'japanese': '政治の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'free',
      'japanese': '自由',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'receive',
      'japanese': '受け取る',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'moment', 'japanese': '瞬間', 'POS': 'noun', 'selected': false},
    {'english': 'sale', 'japanese': '販売', 'POS': 'noun', 'selected': false},
    {'english': 'policy', 'japanese': '政策', 'POS': 'noun', 'selected': false},
    {
      'english': 'further',
      'japanese': 'さらに',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'body', 'japanese': '体', 'POS': 'noun', 'selected': false},
    {
      'english': 'require',
      'japanese': '必要とする',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'wait', 'japanese': '待つ', 'POS': 'verb', 'selected': false},
    {
      'english': 'general',
      'japanese': '一般的な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'appear', 'japanese': '現れる', 'POS': 'verb', 'selected': false},
    {
      'english': 'toward',
      'japanese': '向かって',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'team', 'japanese': 'チーム', 'POS': 'noun', 'selected': false},
    {
      'english': 'easy',
      'japanese': '簡単な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'individual',
      'japanese': '個人の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'full',
      'japanese': 'いっぱい',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'black',
      'japanese': '黒い',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'sense', 'japanese': '感覚', 'POS': 'noun', 'selected': false},
    {
      'english': 'perhaps',
      'japanese': 'ひょっとして',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'add', 'japanese': '加える', 'POS': 'verb', 'selected': false},
    {'english': 'rule', 'japanese': '規則', 'POS': 'noun', 'selected': false},
    {'english': 'pass', 'japanese': '通る', 'POS': 'verb', 'selected': false},
    {
      'english': 'produce',
      'japanese': '生産する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'sell', 'japanese': '売る', 'POS': 'verb', 'selected': false},
    {
      'english': 'short',
      'japanese': '短い',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'agree', 'japanese': '賛成する', 'POS': 'verb', 'selected': false},
    {'english': 'law', 'japanese': '法律', 'POS': 'noun', 'selected': false},
    {
      'english': 'everything',
      'japanese': 'すべて',
      'POS': 'pronoun',
      'selected': false
    },
    {
      'english': 'research',
      'japanese': '調査研究',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'cover', 'japanese': '覆う', 'POS': 'verb', 'selected': false},
    {'english': 'paper', 'japanese': '紙', 'POS': 'noun', 'selected': false},
    {'english': 'position', 'japanese': '位置', 'POS': 'noun', 'selected': false},
    {
      'english': 'near',
      'japanese': '近く',
      'POS': 'preposition',
      'selected': false
    },
    {
      'english': 'human',
      'japanese': '人',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'computer',
      'japanese': 'コンピューター',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'situation',
      'japanese': '状況',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'staff', 'japanese': 'スタッフ', 'POS': 'noun', 'selected': false},
    {'english': 'activity', 'japanese': '活動', 'POS': 'noun', 'selected': false},
    {'english': 'film', 'japanese': 'フィルム', 'POS': 'noun', 'selected': false},
    {'english': 'morning', 'japanese': '朝', 'POS': 'noun', 'selected': false},
    {'english': 'war', 'japanese': '戦争', 'POS': 'noun', 'selected': false},
    {'english': 'account', 'japanese': '報告', 'POS': 'noun', 'selected': false},
    {'english': 'shop', 'japanese': '店', 'POS': 'noun', 'selected': false},
    {
      'english': 'major',
      'japanese': '主要な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'someone',
      'japanese': 'だれか',
      'POS': 'pronoun',
      'selected': false
    },
    {
      'english': 'above',
      'japanese': '～の上',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'design', 'japanese': '設計する', 'POS': 'verb', 'selected': false},
    {'english': 'event', 'japanese': '行事', 'POS': 'noun', 'selected': false},
    {
      'english': 'special',
      'japanese': '特別',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'sometimes',
      'japanese': 'ときどき',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'condition',
      'japanese': '状況',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'carry', 'japanese': '運ぶ', 'POS': 'verb', 'selected': false},
    {'english': 'choose', 'japanese': '選ぶ', 'POS': 'verb', 'selected': false},
    {'english': 'father', 'japanese': '父親', 'POS': 'noun', 'selected': false},
    {'english': 'decision', 'japanese': '決断', 'POS': 'noun', 'selected': false},
    {'english': 'table', 'japanese': 'テーブル', 'POS': 'noun', 'selected': false},
    {
      'english': 'certain',
      'japanese': '確かな',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'forward',
      'japanese': '前方の',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'main',
      'japanese': '主要な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'die', 'japanese': '死ぬ', 'POS': 'verb', 'selected': false},
    {'english': 'bear', 'japanese': '耐える、負う', 'POS': 'verb', 'selected': false},
    {'english': 'cut', 'japanese': '切る', 'POS': 'verb', 'selected': false},
    {
      'english': 'describe',
      'japanese': '言い表す',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'himself',
      'japanese': '彼自身',
      'POS': 'pronoun',
      'selected': false
    },
    {
      'english': 'available',
      'japanese': '利用できる',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'especially',
      'japanese': '特に',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'strong',
      'japanese': '強い',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'rise', 'japanese': '昇る', 'POS': 'verb', 'selected': false},
    {'english': 'girl', 'japanese': '少女', 'POS': 'noun', 'selected': false},
    {
      'english': 'maybe',
      'japanese': '～かもしれない',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'community',
      'japanese': '社会',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'else',
      'japanese': '他の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'particular',
      'japanese': '特定の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'role', 'japanese': '役', 'POS': 'noun', 'selected': false},
    {'english': 'join', 'japanese': '合わせる', 'POS': 'verb', 'selected': false},
    {
      'english': 'difficult',
      'japanese': '難しい',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'please',
      'japanese': 'どうか',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'detail', 'japanese': '詳細', 'POS': 'noun', 'selected': false},
    {
      'english': 'difference',
      'japanese': '違い',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'action', 'japanese': '行動', 'POS': 'noun', 'selected': false},
    {'english': 'health', 'japanese': '健康', 'POS': 'noun', 'selected': false},
    {'english': 'eat', 'japanese': '食べる', 'POS': 'verb', 'selected': false},
    {'english': 'step', 'japanese': '一歩歩む', 'POS': 'verb', 'selected': false},
    {
      'english': 'true',
      'japanese': '本当の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'phone', 'japanese': '電話', 'POS': 'noun', 'selected': false},
    {
      'english': 'themselves',
      'japanese': '彼ら自身',
      'POS': 'pronoun',
      'selected': false
    },
    {'english': 'draw', 'japanese': '描く', 'POS': 'verb', 'selected': false},
    {
      'english': 'white',
      'japanese': '白',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'date', 'japanese': '日付', 'POS': 'noun', 'selected': false},
    {
      'english': 'practice',
      'japanese': '練習する',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'model', 'japanese': '模型', 'POS': 'noun', 'selected': false},
    {'english': 'raise', 'japanese': '上げる', 'POS': 'verb', 'selected': false},
    {'english': 'customer', 'japanese': '顧客', 'POS': 'noun', 'selected': false},
    {'english': 'front', 'japanese': '前', 'POS': 'noun', 'selected': false},
    {
      'english': 'explain',
      'japanese': '説明する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'door', 'japanese': 'ドア', 'POS': 'noun', 'selected': false},
    {'english': 'outside', 'japanese': '外', 'POS': 'noun', 'selected': false},
    {
      'english': 'behind',
      'japanese': '後ろに',
      'POS': 'preposition',
      'selected': false
    },
    {
      'english': 'economic',
      'japanese': '経済の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'site', 'japanese': '現場', 'POS': 'noun', 'selected': false},
    {
      'english': 'approach',
      'japanese': '近づく',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'teacher', 'japanese': '教師', 'POS': 'noun', 'selected': false},
    {'english': 'land', 'japanese': '陸', 'POS': 'noun', 'selected': false},
    {'english': 'charge', 'japanese': '請求する', 'POS': 'verb', 'selected': false},
    {
      'english': 'finally',
      'japanese': '最後に',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'sign', 'japanese': 'しるし', 'POS': 'noun', 'selected': false},
    {'english': 'claim', 'japanese': '主張する', 'POS': 'noun', 'selected': false},
    {
      'english': 'relationship',
      'japanese': '関係',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'travel', 'japanese': '旅する', 'POS': 'verb', 'selected': false},
    {'english': 'enjoy', 'japanese': '楽しむ', 'POS': 'verb', 'selected': false},
    {'english': 'death', 'japanese': '死', 'POS': 'noun', 'selected': false},
    {
      'english': 'nice',
      'japanese': '素晴らしい',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'amount', 'japanese': '量', 'POS': 'noun', 'selected': false},
    {
      'english': 'improve',
      'japanese': '改善する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'picture',
      'japanese': '写真、絵',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'boy', 'japanese': '男の子', 'POS': 'noun', 'selected': false},
    {'english': 'regard', 'japanese': '顧慮する', 'POS': 'verb', 'selected': false},
    {
      'english': 'organization',
      'japanese': '組織',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'happy',
      'japanese': '幸福な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'couple', 'japanese': '一対', 'POS': 'noun', 'selected': false},
    {'english': 'act', 'japanese': '行動する', 'POS': 'noun', 'selected': false},
    {'english': 'range', 'japanese': '範囲、幅', 'POS': 'noun', 'selected': false},
    {
      'english': 'quality',
      'japanese': '質、品質',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'project', 'japanese': '企画', 'POS': 'noun', 'selected': false},
    {
      'english': 'round',
      'japanese': '丸い',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'opportunity',
      'japanese': '機会',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'road', 'japanese': '道', 'POS': 'noun', 'selected': false},
    {'english': 'accord', 'japanese': '合意', 'POS': 'noun', 'selected': false},
    {
      'english': 'ngslList',
      'japanese': 'リスト',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'wish', 'japanese': '願う', 'POS': 'verb', 'selected': false},
    {
      'english': 'therefore',
      'japanese': '従って、だから',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'wear', 'japanese': '着る', 'POS': 'verb', 'selected': false},
    {'english': 'fund', 'japanese': '資金', 'POS': 'noun', 'selected': false},
    {'english': 'rest', 'japanese': '休憩', 'POS': 'noun', 'selected': false},
    {'english': 'kid', 'japanese': '子供', 'POS': 'noun', 'selected': false},
    {'english': 'industry', 'japanese': '産業', 'POS': 'noun', 'selected': false},
    {
      'english': 'education',
      'japanese': '教育',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'measure', 'japanese': '測る', 'POS': 'verb', 'selected': false},
    {'english': 'kill', 'japanese': '殺す', 'POS': 'verb', 'selected': false},
    {
      'english': 'serve',
      'japanese': '供給する、～を出す',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'likely',
      'japanese': '～しそうだ',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'certainly',
      'japanese': '確実な',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'national',
      'japanese': '国の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'itself',
      'japanese': 'それなり',
      'POS': 'pronoun',
      'selected': false
    },
    {'english': 'teach', 'japanese': '教える', 'POS': 'verb', 'selected': false},
    {'english': 'field', 'japanese': '野原', 'POS': 'noun', 'selected': false},
    {'english': 'security', 'japanese': '警備', 'POS': 'noun', 'selected': false},
    {'english': 'air', 'japanese': '空気', 'POS': 'noun', 'selected': false},
    {
      'english': 'benefit',
      'japanese': '利益、恩恵',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'trade', 'japanese': '交換する', 'POS': 'noun', 'selected': false},
    {'english': 'risk', 'japanese': 'リスク', 'POS': 'noun', 'selected': false},
    {'english': 'news', 'japanese': 'ニュース', 'POS': 'noun', 'selected': false},
    {
      'english': 'standard',
      'japanese': '基準',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'vote', 'japanese': '投票する', 'POS': 'verb', 'selected': false},
    {'english': 'percent', 'japanese': '㌫', 'POS': 'noun', 'selected': false},
    {'english': 'focus', 'japanese': '焦点', 'POS': 'noun', 'selected': false},
    {'english': 'stage', 'japanese': '段階', 'POS': 'noun', 'selected': false},
    {'english': 'space', 'japanese': '場所', 'POS': 'noun', 'selected': false},
    {
      'english': 'instead',
      'japanese': '代わり',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'realize', 'japanese': '気づく', 'POS': 'verb', 'selected': false},
    {
      'english': 'usually',
      'japanese': 'たいてい',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'data', 'japanese': 'データ', 'POS': 'noun', 'selected': false},
    {
      'english': 'single',
      'japanese': '単独',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'address', 'japanese': '住所', 'POS': 'noun', 'selected': false},
    {
      'english': 'performance',
      'japanese': '演技',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'chance', 'japanese': '機会', 'POS': 'noun', 'selected': false},
    {
      'english': 'accept',
      'japanese': '引き受ける',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'society', 'japanese': '社会', 'POS': 'noun', 'selected': false},
    {
      'english': 'technology',
      'japanese': '科学技術、テクノロジー',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'mention',
      'japanese': '言及する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'choice', 'japanese': '選択', 'POS': 'noun', 'selected': false},
    {'english': 'save', 'japanese': '救う', 'POS': 'verb', 'selected': false},
    {
      'english': 'common',
      'japanese': '一般的な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'culture', 'japanese': '文化', 'POS': 'noun', 'selected': false},
    {
      'english': 'total',
      'japanese': '合計',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'demand', 'japanese': '需要', 'POS': 'noun', 'selected': false},
    {'english': 'material', 'japanese': '材料', 'POS': 'noun', 'selected': false},
    {'english': 'limit', 'japanese': '限度', 'POS': 'noun', 'selected': false},
    {'english': 'listen', 'japanese': '聞く', 'POS': 'verb', 'selected': false},
    {'english': 'due', 'japanese': '期限', 'POS': 'adjective', 'selected': false},
    {
      'english': 'wrong',
      'japanese': '悪い、間違いの',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'foot',
      'japanese': '足（くるぶしから下）',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'effort', 'japanese': '努力', 'POS': 'noun', 'selected': false},
    {
      'english': 'attention',
      'japanese': '注意',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'upon',
      'japanese': '～の上に',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'check', 'japanese': '確認する', 'POS': 'verb', 'selected': false},
    {
      'english': 'complete',
      'japanese': '完璧',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'lie', 'japanese': '横になる', 'POS': 'verb', 'selected': false},
    {'english': 'pick', 'japanese': '選ぶ', 'POS': 'verb', 'selected': false},
    {'english': 'reduce', 'japanese': '減らす', 'POS': 'verb', 'selected': false},
    {
      'english': 'personal',
      'japanese': '個人的な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'ground', 'japanese': '地面', 'POS': 'noun', 'selected': false},
    {'english': 'animal', 'japanese': '動物', 'POS': 'noun', 'selected': false},
    {'english': 'arrive', 'japanese': '到着する', 'POS': 'verb', 'selected': false},
    {
      'english': 'patient',
      'japanese': '忍耐強い',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'current',
      'japanese': '現在の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'century', 'japanese': '世紀', 'POS': 'noun', 'selected': false},
    {'english': 'evidence', 'japanese': '証拠', 'POS': 'noun', 'selected': false},
    {'english': 'exist', 'japanese': '存在する', 'POS': 'verb', 'selected': false},
    {
      'english': 'similar',
      'japanese': '似ている',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'fight', 'japanese': '戦う', 'POS': 'verb', 'selected': false},
    {'english': 'leader', 'japanese': 'リーダー', 'POS': 'noun', 'selected': false},
    {
      'english': 'fine',
      'japanese': 'よい',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'street', 'japanese': '街路', 'POS': 'noun', 'selected': false},
    {
      'english': 'former',
      'japanese': '前の',
      'POS': 'determiner',
      'selected': false
    },
    {'english': 'contact', 'japanese': '接触', 'POS': 'noun', 'selected': false},
    {
      'english': 'particularly',
      'japanese': '特に',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'wife', 'japanese': '妻', 'POS': 'noun', 'selected': false},
    {'english': 'sport', 'japanese': 'スポーツ', 'POS': 'noun', 'selected': false},
    {
      'english': 'prepare',
      'japanese': '用意する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'discuss',
      'japanese': '議論する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'response', 'japanese': '応答', 'POS': 'noun', 'selected': false},
    {'english': 'voice', 'japanese': '声', 'POS': 'noun', 'selected': false},
    {'english': 'piece', 'japanese': '一切れ', 'POS': 'noun', 'selected': false},
    {'english': 'finish', 'japanese': '終り', 'POS': 'verb', 'selected': false},
    {
      'english': 'suppose',
      'japanese': '想定する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'apply', 'japanese': '申し込む', 'POS': 'verb', 'selected': false},
    {
      'english': 'president',
      'japanese': '大統領',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'fire', 'japanese': '火', 'POS': 'noun', 'selected': false},
    {'english': 'compare', 'japanese': '比べる', 'POS': 'verb', 'selected': false},
    {'english': 'court', 'japanese': '裁判所', 'POS': 'noun', 'selected': false},
    {'english': 'police', 'japanese': '警察', 'POS': 'noun', 'selected': false},
    {'english': 'store', 'japanese': '店', 'POS': 'noun', 'selected': false},
    {
      'english': 'poor',
      'japanese': '貧しい',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'knowledge',
      'japanese': '知識',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'laugh', 'japanese': '笑う', 'POS': 'verb', 'selected': false},
    {'english': 'arm', 'japanese': '腕', 'POS': 'noun', 'selected': false},
    {'english': 'heart', 'japanese': '心', 'POS': 'noun', 'selected': false},
    {'english': 'source', 'japanese': '源', 'POS': 'noun', 'selected': false},
    {
      'english': 'employee',
      'japanese': '従業員',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'manage', 'japanese': '管理する', 'POS': 'verb', 'selected': false},
    {
      'english': 'simply',
      'japanese': '簡単に',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'bank', 'japanese': '堤防', 'POS': 'noun', 'selected': false},
    {
      'english': 'firm',
      'japanese': '堅い',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'cell', 'japanese': '細胞', 'POS': 'noun', 'selected': false},
    {'english': 'article', 'japanese': '記事', 'POS': 'noun', 'selected': false},
    {
      'english': 'fast',
      'japanese': '速い',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'attack', 'japanese': '攻撃する', 'POS': 'noun', 'selected': false},
    {
      'english': 'foreign',
      'japanese': '異国（の）',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'surprise', 'japanese': '驚く', 'POS': 'noun', 'selected': false},
    {'english': 'feature', 'japanese': '特徴', 'POS': 'noun', 'selected': false},
    {'english': 'factor', 'japanese': '要因', 'POS': 'noun', 'selected': false},
    {
      'english': 'pretty',
      'japanese': 'かなりの、すてきな',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'recently',
      'japanese': '最近',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'affect',
      'japanese': '影響を与える',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'drop', 'japanese': '落とす', 'POS': 'verb', 'selected': false},
    {
      'english': 'recent',
      'japanese': '最近',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'relate',
      'japanese': '関連付ける',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'official',
      'japanese': '職務上の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'financial',
      'japanese': '財政的な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'miss', 'japanese': '外す、逃す', 'POS': 'verb', 'selected': false},
    {'english': 'art', 'japanese': '芸術', 'POS': 'noun', 'selected': false},
    {
      'english': 'campaign',
      'japanese': 'キャンペーン',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'private',
      'japanese': '私的な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'pause', 'japanese': '一時停止', 'POS': 'noun', 'selected': false},
    {
      'english': 'everyone',
      'japanese': '全員',
      'POS': 'pronoun',
      'selected': false
    },
    {'english': 'forget', 'japanese': '忘れる', 'POS': 'verb', 'selected': false},
    {'english': 'page', 'japanese': 'ページ', 'POS': 'noun', 'selected': false},
    {'english': 'worry', 'japanese': '心配する', 'POS': 'verb', 'selected': false},
    {'english': 'summer', 'japanese': '夏', 'POS': 'noun', 'selected': false},
    {'english': 'drink', 'japanese': '飲む', 'POS': 'verb', 'selected': false},
    {'english': 'opinion', 'japanese': '意見', 'POS': 'noun', 'selected': false},
    {'english': 'park', 'japanese': '公園', 'POS': 'noun', 'selected': false},
    {
      'english': 'represent',
      'japanese': '代表を務める',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'key', 'japanese': '鍵', 'POS': 'noun', 'selected': false},
    {
      'english': 'inside',
      'japanese': '内側',
      'POS': 'preposition',
      'selected': false
    },
    {
      'english': 'manager',
      'japanese': '経営者、管理者、部長',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'international',
      'japanese': '国際的な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'contain', 'japanese': '含む', 'POS': 'verb', 'selected': false},
    {'english': 'notice', 'japanese': '気づく', 'POS': 'noun', 'selected': false},
    {
      'english': 'wonder',
      'japanese': '驚くべきこと',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'nature', 'japanese': '物質界', 'POS': 'noun', 'selected': false},
    {
      'english': 'structure',
      'japanese': '構造',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'section', 'japanese': '部分', 'POS': 'noun', 'selected': false},
    {
      'english': 'myself',
      'japanese': '自分自身',
      'POS': 'pronoun',
      'selected': false
    },
    {
      'english': 'exactly',
      'japanese': 'まさに',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'plant', 'japanese': '植物', 'POS': 'noun', 'selected': false},
    {'english': 'paint', 'japanese': 'ペンキ', 'POS': 'noun', 'selected': false},
    {'english': 'worker', 'japanese': '従業員', 'POS': 'noun', 'selected': false},
    {
      'english': 'press',
      'japanese': '新聞、雑誌、報道機関',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'whatever',
      'japanese': 'なんでも',
      'POS': 'pronoun',
      'selected': false
    },
    {
      'english': 'necessary',
      'japanese': '必要',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'region', 'japanese': '地域', 'POS': 'noun', 'selected': false},
    {'english': 'growth', 'japanese': '成長', 'POS': 'noun', 'selected': false},
    {'english': 'evening', 'japanese': '夕べ', 'POS': 'noun', 'selected': false},
    {
      'english': 'influence',
      'japanese': '影響',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'respect', 'japanese': '尊敬', 'POS': 'noun', 'selected': false},
    {
      'english': 'various',
      'japanese': 'さまざまな',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'catch', 'japanese': '捕まえる', 'POS': 'verb', 'selected': false},
    {
      'english': 'thus',
      'japanese': 'そのように',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'skill', 'japanese': '技術', 'POS': 'noun', 'selected': false},
    {'english': 'attempt', 'japanese': '試みる', 'POS': 'verb', 'selected': false},
    {'english': 'son', 'japanese': '息子', 'POS': 'noun', 'selected': false},
    {
      'english': 'simple',
      'japanese': '易しい、単純な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'medium', 'japanese': '中くらい', 'POS': 'noun', 'selected': false},
    {'english': 'average', 'japanese': '平均', 'POS': 'noun', 'selected': false},
    {'english': 'stock', 'japanese': '在庫', 'POS': 'noun', 'selected': false},
    {
      'english': 'management',
      'japanese': '経営者',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'character',
      'japanese': '性格',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'bed', 'japanese': 'ベッド', 'POS': 'noun', 'selected': false},
    {'english': 'hit', 'japanese': '打つ', 'POS': 'verb', 'selected': false},
    {
      'english': 'establish',
      'japanese': '設立する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'indeed',
      'japanese': '実に、まさに',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'final',
      'japanese': '最終',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'economy', 'japanese': '経済', 'POS': 'noun', 'selected': false},
    {
      'english': 'fit',
      'japanese': '適切である',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'guy', 'japanese': '男', 'POS': 'noun', 'selected': false},
    {'english': 'function', 'japanese': '機能', 'POS': 'noun', 'selected': false},
    {
      'english': 'yesterday',
      'japanese': '昨日',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'image', 'japanese': '絵、像', 'POS': 'noun', 'selected': false},
    {'english': 'size', 'japanese': 'サイズ、寸法', 'POS': 'noun', 'selected': false},
    {
      'english': 'behavior',
      'japanese': '態度、行動',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'addition',
      'japanese': '追加物',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'determine',
      'japanese': '決定する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'station', 'japanese': '駅', 'POS': 'noun', 'selected': false},
    {
      'english': 'population',
      'japanese': '人口',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'fail', 'japanese': '失敗する', 'POS': 'verb', 'selected': false},
    {
      'english': 'environment',
      'japanese': '環境',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'production',
      'japanese': '生産',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'contract', 'japanese': '契約', 'POS': 'noun', 'selected': false},
    {
      'english': 'player',
      'japanese': 'プレーヤー',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'comment',
      'japanese': 'コメントする',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'enter', 'japanese': '入る', 'POS': 'verb', 'selected': false},
    {'english': 'occur', 'japanese': '起こる', 'POS': 'verb', 'selected': false},
    {
      'english': 'alone',
      'japanese': '単独',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'significant',
      'japanese': '著しい',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'drug', 'japanese': '薬', 'POS': 'noun', 'selected': false},
    {'english': 'wall', 'japanese': '壁', 'POS': 'noun', 'selected': false},
    {
      'english': 'series',
      'japanese': '一続き、連続の',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'direct',
      'japanese': '向かわせる',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'success', 'japanese': '成功', 'POS': 'noun', 'selected': false},
    {'english': 'tomorrow', 'japanese': '明日', 'POS': 'noun', 'selected': false},
    {'english': 'director', 'japanese': '監督', 'POS': 'noun', 'selected': false},
    {
      'english': 'clearly',
      'japanese': 'はっきりと',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'lack', 'japanese': '欠けている', 'POS': 'verb', 'selected': false},
    {'english': 'review', 'japanese': '精査', 'POS': 'noun', 'selected': false},
    {'english': 'depend', 'japanese': '頼る', 'POS': 'verb', 'selected': false},
    {'english': 'race', 'japanese': '人種', 'POS': 'noun', 'selected': false},
    {
      'english': 'recognize',
      'japanese': '認識する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'window', 'japanese': '窓', 'POS': 'noun', 'selected': false},
    {'english': 'purpose', 'japanese': '目的', 'POS': 'noun', 'selected': false},
    {
      'english': 'department',
      'japanese': '部門',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'gain', 'japanese': '得る', 'POS': 'verb', 'selected': false},
    {'english': 'tree', 'japanese': '木', 'POS': 'noun', 'selected': false},
    {'english': 'college', 'japanese': '大学', 'POS': 'noun', 'selected': false},
    {'english': 'argue', 'japanese': '主張する', 'POS': 'verb', 'selected': false},
    {'english': 'board', 'japanese': '板', 'POS': 'noun', 'selected': false},
    {'english': 'holiday', 'japanese': '休日', 'POS': 'noun', 'selected': false},
    {'english': 'mark', 'japanese': '印をつける', 'POS': 'verb', 'selected': false},
    {'english': 'church', 'japanese': '教会', 'POS': 'noun', 'selected': false},
    {'english': 'machine', 'japanese': '機械', 'POS': 'noun', 'selected': false},
    {
      'english': 'achieve',
      'japanese': '達成する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'item', 'japanese': '品物', 'POS': 'noun', 'selected': false},
    {'english': 'prove', 'japanese': '証明する', 'POS': 'verb', 'selected': false},
    {'english': 'cent', 'japanese': 'セント', 'POS': 'noun', 'selected': false},
    {'english': 'season', 'japanese': '季節', 'POS': 'noun', 'selected': false},
    {'english': 'floor', 'japanese': '床', 'POS': 'noun', 'selected': false},
    {'english': 'stuff', 'japanese': '材料', 'POS': 'noun', 'selected': false},
    {
      'english': 'wide',
      'japanese': '広い',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'anyone',
      'japanese': 'だれか',
      'POS': 'pronoun',
      'selected': false
    },
    {'english': 'method', 'japanese': '方法', 'POS': 'noun', 'selected': false},
    {'english': 'analysis', 'japanese': '分析', 'POS': 'noun', 'selected': false},
    {'english': 'election', 'japanese': '選挙', 'POS': 'noun', 'selected': false},
    {
      'english': 'military',
      'japanese': '軍の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'hotel', 'japanese': 'ホテル', 'POS': 'noun', 'selected': false},
    {'english': 'club', 'japanese': 'クラブ', 'POS': 'noun', 'selected': false},
    {
      'english': 'below',
      'japanese': '下に',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'movie', 'japanese': '映画', 'POS': 'noun', 'selected': false},
    {'english': 'doctor', 'japanese': '医師', 'POS': 'noun', 'selected': false},
    {
      'english': 'discussion',
      'japanese': '議論',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'sorry',
      'japanese': '気の毒に思う',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'challenge',
      'japanese': '異議を申し立てる',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'nation', 'japanese': '国家', 'POS': 'noun', 'selected': false},
    {
      'english': 'nearly',
      'japanese': 'ほとんど',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'statement',
      'japanese': '声明',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'link', 'japanese': '結びつける', 'POS': 'noun', 'selected': false},
    {
      'english': 'despite',
      'japanese': 'にもかかわらず',
      'POS': 'preposition',
      'selected': false
    },
    {
      'english': 'introduce',
      'japanese': '紹介する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'advantage',
      'japanese': '利点',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'ready',
      'japanese': '準備ができている',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'marry', 'japanese': '結婚する', 'POS': 'verb', 'selected': false},
    {'english': 'strike', 'japanese': '打つ', 'POS': 'verb', 'selected': false},
    {'english': 'mile', 'japanese': 'マイル', 'POS': 'noun', 'selected': false},
    {'english': 'seek', 'japanese': '探し求める', 'POS': 'verb', 'selected': false},
    {'english': 'ability', 'japanese': '能力', 'POS': 'noun', 'selected': false},
    {'english': 'unit', 'japanese': '単位', 'POS': 'noun', 'selected': false},
    {'english': 'card', 'japanese': 'カード', 'POS': 'noun', 'selected': false},
    {'english': 'hospital', 'japanese': '病院', 'POS': 'noun', 'selected': false},
    {
      'english': 'quickly',
      'japanese': '速く',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'interview',
      'japanese': '面接',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'agreement',
      'japanese': '合意',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'release',
      'japanese': '釈放する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'tax', 'japanese': '税金', 'POS': 'noun', 'selected': false},
    {
      'english': 'solution',
      'japanese': '解決策',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'capital', 'japanese': '首都', 'POS': 'noun', 'selected': false},
    {
      'english': 'popular',
      'japanese': '人気がある',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'specific',
      'japanese': '独特な、特に',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'beautiful',
      'japanese': '美しい',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'fear', 'japanese': '恐れ', 'POS': 'noun', 'selected': false},
    {'english': 'aim', 'japanese': '狙う', 'POS': 'noun', 'selected': false},
    {
      'english': 'television',
      'japanese': 'テレビ',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'serious',
      'japanese': '深刻な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'target', 'japanese': '目的', 'POS': 'noun', 'selected': false},
    {'english': 'degree', 'japanese': '度', 'POS': 'noun', 'selected': false},
    {'english': 'pull', 'japanese': '引く', 'POS': 'verb', 'selected': false},
    {'english': 'red', 'japanese': '赤', 'POS': 'adjective', 'selected': false},
    {'english': 'husband', 'japanese': '夫', 'POS': 'noun', 'selected': false},
    {'english': 'access', 'japanese': 'アクセス', 'POS': 'noun', 'selected': false},
    {'english': 'movement', 'japanese': '動き', 'POS': 'noun', 'selected': false},
    {'english': 'treat', 'japanese': '扱う', 'POS': 'verb', 'selected': false},
    {
      'english': 'identify',
      'japanese': '識別する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'loss', 'japanese': '失うこと', 'POS': 'noun', 'selected': false},
    {
      'english': 'shall',
      'japanese': '～となるだろう',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'modern',
      'japanese': '現代的な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'pressure', 'japanese': '圧力', 'POS': 'noun', 'selected': false},
    {'english': 'bus', 'japanese': 'バス', 'POS': 'noun', 'selected': false},
    {
      'english': 'treatment',
      'japanese': '治療',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'yourself',
      'japanese': 'あなた自身',
      'POS': 'pronoun',
      'selected': false
    },
    {'english': 'supply', 'japanese': '供給', 'POS': 'noun', 'selected': false},
    {'english': 'village', 'japanese': '村', 'POS': 'noun', 'selected': false},
    {'english': 'worth', 'japanese': '価値', 'POS': 'noun', 'selected': false},
    {
      'english': 'natural',
      'japanese': '自然',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'express',
      'japanese': '表現する、伝える',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'indicate',
      'japanese': '指し示す',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'attend', 'japanese': '出席する', 'POS': 'verb', 'selected': false},
    {'english': 'brother', 'japanese': '兄弟', 'POS': 'noun', 'selected': false},
    {
      'english': 'investment',
      'japanese': '投資',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'score', 'japanese': 'スコア', 'POS': 'noun', 'selected': false},
    {
      'english': 'organize',
      'japanese': 'まとめる',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'trip', 'japanese': '旅', 'POS': 'noun', 'selected': false},
    {
      'english': 'beyond',
      'japanese': '～を越えて',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'sleep', 'japanese': '寝る', 'POS': 'verb', 'selected': false},
    {'english': 'fish', 'japanese': '魚', 'POS': 'noun', 'selected': false},
    {'english': 'promise', 'japanese': '約束', 'POS': 'noun', 'selected': false},
    {
      'english': 'potential',
      'japanese': '潜在能力',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'energy',
      'japanese': 'エネルギー',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'trouble', 'japanese': '困難', 'POS': 'noun', 'selected': false},
    {'english': 'relation', 'japanese': '関係', 'POS': 'noun', 'selected': false},
    {'english': 'touch', 'japanese': '触る', 'POS': 'verb', 'selected': false},
    {'english': 'file', 'japanese': 'ファイル', 'POS': 'noun', 'selected': false},
    {'english': 'middle', 'japanese': '中間', 'POS': 'noun', 'selected': false},
    {'english': 'bar', 'japanese': '酒場', 'POS': 'noun', 'selected': false},
    {'english': 'suffer', 'japanese': '苦しむ', 'POS': 'verb', 'selected': false},
    {'english': 'strategy', 'japanese': '戦略', 'POS': 'noun', 'selected': false},
    {
      'english': 'deep',
      'japanese': '深い',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'except',
      'japanese': '～以外',
      'POS': 'conjunction',
      'selected': false
    },
    {
      'english': 'clean',
      'japanese': '綺麗にする、きれいな',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'tend', 'japanese': '傾向がある', 'POS': 'verb', 'selected': false},
    {'english': 'advance', 'japanese': '進む', 'POS': 'noun', 'selected': false},
    {'english': 'fill', 'japanese': '満たす', 'POS': 'verb', 'selected': false},
    {'english': 'star', 'japanese': '星', 'POS': 'noun', 'selected': false},
    {
      'english': 'network',
      'japanese': 'ネットワーク',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'generally',
      'japanese': '一般的に',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'operation',
      'japanese': '手術',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'match', 'japanese': '匹敵する', 'POS': 'noun', 'selected': false},
    {'english': 'avoid', 'japanese': '避ける', 'POS': 'verb', 'selected': false},
    {'english': 'seat', 'japanese': '席', 'POS': 'noun', 'selected': false},
    {'english': 'throw', 'japanese': '投げる', 'POS': 'verb', 'selected': false},
    {'english': 'task', 'japanese': '仕事', 'POS': 'noun', 'selected': false},
    {
      'english': 'normal',
      'japanese': '普通',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'goal', 'japanese': '目標', 'POS': 'noun', 'selected': false},
    {
      'english': 'associate',
      'japanese': '関連付ける、連想する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'blue', 'japanese': '青', 'POS': 'adjective', 'selected': false},
    {
      'english': 'positive',
      'japanese': '前向きな',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'option', 'japanese': '選択', 'POS': 'noun', 'selected': false},
    {'english': 'box', 'japanese': '箱', 'POS': 'noun', 'selected': false},
    {
      'english': 'huge',
      'japanese': 'とてつもなく大きい',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'message',
      'japanese': 'メッセージ,伝言',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'instance', 'japanese': '事例', 'POS': 'noun', 'selected': false},
    {'english': 'style', 'japanese': '型', 'POS': 'noun', 'selected': false},
    {'english': 'refer', 'japanese': '言及する', 'POS': 'verb', 'selected': false},
    {
      'english': 'cold',
      'japanese': '冷たい',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'push', 'japanese': '押す', 'POS': 'verb', 'selected': false},
    {
      'english': 'quarter',
      'japanese': '４分の１',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'assume', 'japanese': '負う', 'POS': 'verb', 'selected': false},
    {'english': 'baby', 'japanese': '赤ん坊', 'POS': 'noun', 'selected': false},
    {
      'english': 'successful',
      'japanese': '成功した',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'sing', 'japanese': '歌う', 'POS': 'verb', 'selected': false},
    {'english': 'doubt', 'japanese': '疑う', 'POS': 'verb', 'selected': false},
    {
      'english': 'competition',
      'japanese': '競争',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'theory', 'japanese': '理論', 'POS': 'noun', 'selected': false},
    {
      'english': 'propose',
      'japanese': '提案する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'reference',
      'japanese': '言及する',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'argument', 'japanese': '口論', 'POS': 'noun', 'selected': false},
    {'english': 'adult', 'japanese': '大人', 'POS': 'noun', 'selected': false},
    {'english': 'fly', 'japanese': '飛ぶ', 'POS': 'verb', 'selected': false},
    {'english': 'document', 'japanese': '文書', 'POS': 'noun', 'selected': false},
    {
      'english': 'pattern',
      'japanese': 'パターン',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'application',
      'japanese': '応募書',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'hot', 'japanese': '熱い', 'POS': 'adjective', 'selected': false},
    {
      'english': 'obviously',
      'japanese': '明らかに',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'unclear',
      'japanese': '明確でない',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'bill', 'japanese': '請求書', 'POS': 'noun', 'selected': false},
    {'english': 'search', 'japanese': '探す', 'POS': 'verb', 'selected': false},
    {
      'english': 'separate',
      'japanese': '分かれた',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'central',
      'japanese': '真ん中の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'career', 'japanese': 'キャリア', 'POS': 'noun', 'selected': false},
    {
      'english': 'anyway',
      'japanese': 'とにかく',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'speech', 'japanese': 'スピーチ', 'POS': 'noun', 'selected': false},
    {'english': 'dog', 'japanese': '犬', 'POS': 'noun', 'selected': false},
    {'english': 'officer', 'japanese': '会社員', 'POS': 'noun', 'selected': false},
    {
      'english': 'throughout',
      'japanese': '～にわたって、～を通じて',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'oil', 'japanese': 'オイル,油', 'POS': 'noun', 'selected': false},
    {'english': 'dress', 'japanese': 'ドレス', 'POS': 'noun', 'selected': false},
    {'english': 'profit', 'japanese': '利益', 'POS': 'noun', 'selected': false},
    {'english': 'guess', 'japanese': '推測する', 'POS': 'verb', 'selected': false},
    {
      'english': 'fun',
      'japanese': '楽しい',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'protect', 'japanese': '守る', 'POS': 'verb', 'selected': false},
    {'english': 'resource', 'japanese': '資源', 'POS': 'noun', 'selected': false},
    {'english': 'science', 'japanese': '科学', 'POS': 'noun', 'selected': false},
    {'english': 'disease', 'japanese': '病気', 'POS': 'noun', 'selected': false},
    {
      'english': 'balance',
      'japanese': 'バランス',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'damage', 'japanese': '損傷', 'POS': 'noun', 'selected': false},
    {'english': 'basis', 'japanese': '基礎', 'POS': 'noun', 'selected': false},
    {'english': 'author', 'japanese': '著者', 'POS': 'noun', 'selected': false},
    {
      'english': 'basic',
      'japanese': '基本的な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'encourage',
      'japanese': '勇気づける',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'hair', 'japanese': '毛髪、毛', 'POS': 'noun', 'selected': false},
    {
      'english': 'male',
      'japanese': '男性',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'operate',
      'japanese': '動作する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'reflect',
      'japanese': '反射する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'exercise', 'japanese': '運動', 'POS': 'noun', 'selected': false},
    {
      'english': 'useful',
      'japanese': '便利',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'restaurant',
      'japanese': 'レストラン',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'income', 'japanese': '収入', 'POS': 'noun', 'selected': false},
    {
      'english': 'property',
      'japanese': '所有物',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'previous',
      'japanese': '前の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'dark',
      'japanese': '暗い',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'imagine',
      'japanese': '想像する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'okay',
      'japanese': 'ＯＫ、いいよ',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'earn', 'japanese': '稼ぐ', 'POS': 'verb', 'selected': false},
    {'english': 'daughter', 'japanese': '娘', 'POS': 'noun', 'selected': false},
    {'english': 'post', 'japanese': '郵便物', 'POS': 'noun', 'selected': false},
    {
      'english': 'newspaper',
      'japanese': '新聞',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'define', 'japanese': '定義する', 'POS': 'verb', 'selected': false},
    {
      'english': 'conclusion',
      'japanese': '結論',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'clock', 'japanese': '時計', 'POS': 'noun', 'selected': false},
    {
      'english': 'everybody',
      'japanese': '全員',
      'POS': 'pronoun',
      'selected': false
    },
    {'english': 'weekend', 'japanese': '週末', 'POS': 'noun', 'selected': false},
    {'english': 'perform', 'japanese': '演じる', 'POS': 'verb', 'selected': false},
    {
      'english': 'professional',
      'japanese': '専門の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'mine',
      'japanese': '私のもの',
      'POS': 'pronoun',
      'selected': false
    },
    {'english': 'debate', 'japanese': '討論', 'POS': 'noun', 'selected': false},
    {'english': 'memory', 'japanese': '記憶', 'POS': 'noun', 'selected': false},
    {
      'english': 'green',
      'japanese': '緑',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'song', 'japanese': '歌', 'POS': 'noun', 'selected': false},
    {'english': 'object', 'japanese': '物体', 'POS': 'noun', 'selected': false},
    {
      'english': 'maintain',
      'japanese': '維持する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'credit', 'japanese': '信用', 'POS': 'noun', 'selected': false},
    {'english': 'ring', 'japanese': '指輪', 'POS': 'noun', 'selected': false},
    {
      'english': 'discover',
      'japanese': '発見する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'dead',
      'japanese': '死んでいる',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'afternoon',
      'japanese': '午後',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'prefer',
      'japanese': '～をより好む',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'extend', 'japanese': '伸ばす', 'POS': 'verb', 'selected': false},
    {
      'english': 'possibility',
      'japanese': '可能性',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'direction',
      'japanese': '方向',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'facility', 'japanese': '施設', 'POS': 'noun', 'selected': false},
    {'english': 'variety', 'japanese': '多様な', 'POS': 'noun', 'selected': false},
    {
      'english': 'daily',
      'japanese': '日誌',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'clothes', 'japanese': '衣服', 'POS': 'noun', 'selected': false},
    {'english': 'screen', 'japanese': '画面', 'POS': 'noun', 'selected': false},
    {
      'english': 'track',
      'japanese': '(人・車などの）通った跡',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'dance', 'japanese': '踊る', 'POS': 'verb', 'selected': false},
    {
      'english': 'completely',
      'japanese': '完全に',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'female',
      'japanese': '女性',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'responsibility',
      'japanese': '責任',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'original',
      'japanese': 'オリジナル',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'sister', 'japanese': '姉妹', 'POS': 'noun', 'selected': false},
    {'english': 'rock', 'japanese': '揺れ動く', 'POS': 'noun', 'selected': false},
    {'english': 'dream', 'japanese': '夢', 'POS': 'noun', 'selected': false},
    {
      'english': 'nor',
      'japanese': 'AもBも～でない',
      'POS': 'conjunction',
      'selected': false
    },
    {
      'english': 'university',
      'japanese': '大学',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'easily',
      'japanese': '簡単に',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'agency', 'japanese': '代理店', 'POS': 'noun', 'selected': false},
    {'english': 'dollar', 'japanese': 'ドル', 'POS': 'noun', 'selected': false},
    {'english': 'garden', 'japanese': '庭', 'POS': 'noun', 'selected': false},
    {'english': 'fix', 'japanese': '修理する', 'POS': 'verb', 'selected': false},
    {'english': 'ahead', 'japanese': '前', 'POS': 'adverb', 'selected': false},
    {'english': 'cross', 'japanese': '交差する', 'POS': 'verb', 'selected': false},
    {
      'english': 'yeah',
      'japanese': 'ああ',
      'POS': 'interjection',
      'selected': false
    },
    {'english': 'weight', 'japanese': '重さ', 'POS': 'noun', 'selected': false},
    {
      'english': 'legal',
      'japanese': '法律上の、法的な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'proposal', 'japanese': '提案', 'POS': 'noun', 'selected': false},
    {'english': 'version', 'japanese': '版', 'POS': 'noun', 'selected': false},
    {
      'english': 'conversation',
      'japanese': '会話',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'somebody',
      'japanese': '誰か',
      'POS': 'pronoun',
      'selected': false
    },
    {'english': 'pound', 'japanese': 'ポンド', 'POS': 'noun', 'selected': false},
    {'english': 'magazine', 'japanese': '雑誌', 'POS': 'noun', 'selected': false},
    {'english': 'shape', 'japanese': '形', 'POS': 'noun', 'selected': false},
    {'english': 'sea', 'japanese': '海', 'POS': 'noun', 'selected': false},
    {
      'english': 'immediately',
      'japanese': 'ただちに',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'welcome',
      'japanese': 'ようこそ',
      'POS': 'interjection',
      'selected': false
    },
    {'english': 'smile', 'japanese': '笑顔', 'POS': 'noun', 'selected': false},
    {
      'english': 'communication',
      'japanese': 'コミュニケーション',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'agent', 'japanese': '代理人', 'POS': 'noun', 'selected': false},
    {
      'english': 'traditional',
      'japanese': '伝統的な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'replace',
      'japanese': '取って代わる',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'judge', 'japanese': '審判', 'POS': 'noun', 'selected': false},
    {
      'english': 'herself',
      'japanese': '彼女自身',
      'POS': 'pronoun',
      'selected': false
    },
    {
      'english': 'suddenly',
      'japanese': '突然',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'generation',
      'japanese': '世代',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'estimate', 'japanese': '予算', 'POS': 'noun', 'selected': false},
    {
      'english': 'favorite',
      'japanese': 'お気に入りの',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'difficulty',
      'japanese': '困難',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'purchase',
      'japanese': '購入する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'shoot', 'japanese': '撃つ', 'POS': 'verb', 'selected': false},
    {
      'english': 'announce',
      'japanese': '発表する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'unless',
      'japanese': '～でない限り',
      'POS': 'conjunction',
      'selected': false
    },
    {
      'english': 'independent',
      'japanese': '独立',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'recommend',
      'japanese': '薦める',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'survey', 'japanese': '調査', 'POS': 'noun', 'selected': false},
    {
      'english': 'majority',
      'japanese': '大多数',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'stick', 'japanese': '棒', 'POS': 'noun', 'selected': false},
    {'english': 'request', 'japanese': '要請', 'POS': 'noun', 'selected': false},
    {
      'english': 'rich',
      'japanese': '金持ち',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'wind', 'japanese': '風', 'POS': 'noun', 'selected': false},
    {
      'english': 'none',
      'japanese': '誰も・何も～ない',
      'POS': 'pronoun',
      'selected': false
    },
    {'english': 'exchange', 'japanese': '交換', 'POS': 'noun', 'selected': false},
    {'english': 'budget', 'japanese': '予算', 'POS': 'noun', 'selected': false},
    {
      'english': 'famous',
      'japanese': '有名',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'blood', 'japanese': '血液', 'POS': 'noun', 'selected': false},
    {
      'english': 'appropriate',
      'japanese': '適切な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'block', 'japanese': 'ブロック', 'POS': 'noun', 'selected': false},
    {
      'english': 'warm',
      'japanese': '暖かい',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'count', 'japanese': '数える', 'POS': 'verb', 'selected': false},
    {'english': 'scene', 'japanese': '場面', 'POS': 'noun', 'selected': false},
    {'english': 'writer', 'japanese': '作家', 'POS': 'noun', 'selected': false},
    {'english': 'content', 'japanese': '内容', 'POS': 'noun', 'selected': false},
    {'english': 'prevent', 'japanese': '防ぐ', 'POS': 'verb', 'selected': false},
    {
      'english': 'safe',
      'japanese': '安全な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'invite', 'japanese': '誘う', 'POS': 'verb', 'selected': false},
    {'english': 'mix', 'japanese': '混ぜる', 'POS': 'verb', 'selected': false},
    {'english': 'element', 'japanese': '要素', 'POS': 'noun', 'selected': false},
    {
      'english': 'effective',
      'japanese': '効果的な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'correct',
      'japanese': '正しい',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'medical',
      'japanese': '医療の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'admit', 'japanese': '認める', 'POS': 'verb', 'selected': false},
    {'english': 'beat', 'japanese': '打つ', 'POS': 'verb', 'selected': false},
    {
      'english': 'telephone',
      'japanese': '電話',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'copy', 'japanese': 'うり二つ', 'POS': 'noun', 'selected': false},
    {
      'english': 'committee',
      'japanese': '委員会',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'aware',
      'japanese': '気づく',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'advice',
      'japanese': 'アドバイス、助言',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'handle', 'japanese': 'ハンドル', 'POS': 'noun', 'selected': false},
    {'english': 'glass', 'japanese': 'ガラス', 'POS': 'noun', 'selected': false},
    {'english': 'trial', 'japanese': '裁判', 'POS': 'noun', 'selected': false},
    {'english': 'stress', 'japanese': 'ストレス', 'POS': 'noun', 'selected': false},
    {
      'english': 'radio',
      'japanese': 'ラジオ、無線',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'administration',
      'japanese': '経営管理',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'complex',
      'japanese': '複雑な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'text', 'japanese': '本文', 'POS': 'noun', 'selected': false},
    {'english': 'context', 'japanese': '事情', 'POS': 'noun', 'selected': false},
    {'english': 'ride', 'japanese': '乗る', 'POS': 'verb', 'selected': false},
    {
      'english': 'directly',
      'japanese': '直接',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'heavy',
      'japanese': '重い',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'remove', 'japanese': '取り除く', 'POS': 'verb', 'selected': false},
    {'english': 'conduct', 'japanese': '導く', 'POS': 'verb', 'selected': false},
    {
      'english': 'equipment',
      'japanese': '設備',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'otherwise',
      'japanese': 'さもなければ',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'title', 'japanese': '題名', 'POS': 'noun', 'selected': false},
    {
      'english': 'extra',
      'japanese': '余計な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'executive',
      'japanese': '幹部',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'chair', 'japanese': 'いす', 'POS': 'noun', 'selected': false},
    {
      'english': 'expensive',
      'japanese': '高い',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'sample', 'japanese': '見本', 'POS': 'noun', 'selected': false},
    {'english': 'sex', 'japanese': '性別', 'POS': 'noun', 'selected': false},
    {'english': 'deliver', 'japanese': '届ける', 'POS': 'verb', 'selected': false},
    {'english': 'video', 'japanese': 'ビデオ', 'POS': 'noun', 'selected': false},
    {
      'english': 'connection',
      'japanese': '接続',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'primary',
      'japanese': '主要な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'weather', 'japanese': '天気', 'POS': 'noun', 'selected': false},
    {'english': 'collect', 'japanese': '集める', 'POS': 'verb', 'selected': false},
    {'english': 'inform', 'japanese': '知らせる', 'POS': 'verb', 'selected': false},
    {
      'english': 'principle',
      'japanese': '原理、原則',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'straight',
      'japanese': '真っすぐな',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'appeal',
      'japanese': '訴え、要請',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'highly',
      'japanese': '非常に、高く',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'trust', 'japanese': '信頼', 'POS': 'noun', 'selected': false},
    {
      'english': 'wonderful',
      'japanese': '素晴らしい',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'flat',
      'japanese': '平らな',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'absolutely',
      'japanese': '全く',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'flow', 'japanese': '流れる', 'POS': 'verb', 'selected': false},
    {
      'english': 'fair',
      'japanese': '公平',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'additional',
      'japanese': '追加の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'responsible',
      'japanese': '責任のある',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'farm', 'japanese': '農場', 'POS': 'noun', 'selected': false},
    {
      'english': 'collection',
      'japanese': '収集',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'hang', 'japanese': '吊るす', 'POS': 'verb', 'selected': false},
    {
      'english': 'negative',
      'japanese': '否定的な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'band', 'japanese': 'バンド', 'POS': 'noun', 'selected': false},
    {
      'english': 'relative',
      'japanese': '関係性のある',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'tour', 'japanese': '旅行', 'POS': 'noun', 'selected': false},
    {
      'english': 'alternative',
      'japanese': '選択肢',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'software',
      'japanese': 'ソフトウェア',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'pair', 'japanese': '一組、一対', 'POS': 'noun', 'selected': false},
    {'english': 'ship', 'japanese': '船', 'POS': 'noun', 'selected': false},
    {'english': 'attitude', 'japanese': '態度', 'POS': 'noun', 'selected': false},
    {
      'english': 'cheap',
      'japanese': '安い',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'double',
      'japanese': '二重の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'leg', 'japanese': '脚', 'POS': 'noun', 'selected': false},
    {
      'english': 'observe',
      'japanese': '観察する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'sentence', 'japanese': '文', 'POS': 'noun', 'selected': false},
    {'english': 'print', 'japanese': '印刷する', 'POS': 'verb', 'selected': false},
    {'english': 'progress', 'japanese': '前進', 'POS': 'noun', 'selected': false},
    {'english': 'truth', 'japanese': '真実', 'POS': 'noun', 'selected': false},
    {
      'english': 'nobody',
      'japanese': 'だれも～ない',
      'POS': 'pronoun',
      'selected': false
    },
    {'english': 'examine', 'japanese': '調べる', 'POS': 'verb', 'selected': false},
    {'english': 'lay', 'japanese': '敷く、置く', 'POS': 'verb', 'selected': false},
    {'english': 'speed', 'japanese': '速度', 'POS': 'noun', 'selected': false},
    {'english': 'politics', 'japanese': '政治', 'POS': 'noun', 'selected': false},
    {'english': 'reply', 'japanese': '返事をする', 'POS': 'verb', 'selected': false},
    {
      'english': 'display',
      'japanese': '展示する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'transfer',
      'japanese': '移動する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'perfect',
      'japanese': '完璧',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'slightly',
      'japanese': 'わずかに',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'overall',
      'japanese': '全体の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'intend',
      'japanese': '～するつもりだ',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'user', 'japanese': '使用者', 'POS': 'noun', 'selected': false},
    {
      'english': 'respond',
      'japanese': '返事をする',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'dinner', 'japanese': '夕食', 'POS': 'noun', 'selected': false},
    {
      'english': 'slow',
      'japanese': '遅い',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'regular',
      'japanese': '定期的な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'physical',
      'japanese': '身体の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'apart', 'japanese': '離れた', 'POS': 'adverb', 'selected': false},
    {'english': 'suit', 'japanese': 'スーツ', 'POS': 'noun', 'selected': false},
    {
      'english': 'federal',
      'japanese': '連邦の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'reveal', 'japanese': '明かす', 'POS': 'verb', 'selected': false},
    {
      'english': 'percentage',
      'japanese': '割合',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'peace', 'japanese': '平和', 'POS': 'noun', 'selected': false},
    {'english': 'status', 'japanese': '地位', 'POS': 'noun', 'selected': false},
    {'english': 'crime', 'japanese': '犯罪', 'POS': 'noun', 'selected': false},
    {
      'english': 'decline',
      'japanese': '下降する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'decade', 'japanese': '１０年', 'POS': 'noun', 'selected': false},
    {
      'english': 'launch',
      'japanese': '発射する、進水させる、発売する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'warn', 'japanese': '警告する', 'POS': 'verb', 'selected': false},
    {
      'english': 'consumer',
      'japanese': '消費者',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'favor', 'japanese': '恩恵、世話', 'POS': 'noun', 'selected': false},
    {'english': 'dry', 'japanese': '乾く', 'POS': 'adjective', 'selected': false},
    {'english': 'partner', 'japanese': '相棒', 'POS': 'noun', 'selected': false},
    {
      'english': 'institution',
      'japanese': '機関',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'spot', 'japanese': '場所', 'POS': 'noun', 'selected': false},
    {'english': 'horse', 'japanese': '馬', 'POS': 'noun', 'selected': false},
    {
      'english': 'eventually',
      'japanese': '最終的に',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'heat', 'japanese': '熱', 'POS': 'noun', 'selected': false},
    {
      'english': 'excite',
      'japanese': '興奮させる',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'reader', 'japanese': '先導者', 'POS': 'noun', 'selected': false},
    {
      'english': 'importance',
      'japanese': '重要性',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'distance', 'japanese': '距離', 'POS': 'noun', 'selected': false},
    {'english': 'guide', 'japanese': '案内人', 'POS': 'noun', 'selected': false},
    {
      'english': 'grant',
      'japanese': '許諾する、与える',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'taxi', 'japanese': 'タクシー', 'POS': 'noun', 'selected': false},
    {'english': 'feed', 'japanese': '食物を与える', 'POS': 'verb', 'selected': false},
    {'english': 'pain', 'japanese': '痛み', 'POS': 'noun', 'selected': false},
    {'english': 'sector', 'japanese': '課', 'POS': 'noun', 'selected': false},
    {'english': 'mistake', 'japanese': '誤り', 'POS': 'noun', 'selected': false},
    {'english': 'ensure', 'japanese': '確保する', 'POS': 'verb', 'selected': false},
    {
      'english': 'satisfy',
      'japanese': '満足させる',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'chief', 'japanese': '長、主任', 'POS': 'noun', 'selected': false},
    {
      'english': 'cool',
      'japanese': '冷たい、涼しい',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'expert', 'japanese': '専門家', 'POS': 'noun', 'selected': false},
    {'english': 'wave', 'japanese': '波', 'POS': 'noun', 'selected': false},
    {'english': 'south', 'japanese': '南', 'POS': 'noun', 'selected': false},
    {'english': 'labor', 'japanese': '労働', 'POS': 'noun', 'selected': false},
    {'english': 'surface', 'japanese': '表面', 'POS': 'noun', 'selected': false},
    {'english': 'library', 'japanese': '図書館', 'POS': 'noun', 'selected': false},
    {
      'english': 'excellent',
      'japanese': 'すばらしい',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'edge', 'japanese': '端', 'POS': 'noun', 'selected': false},
    {'english': 'camp', 'japanese': 'キャンプ', 'POS': 'noun', 'selected': false},
    {'english': 'audience', 'japanese': '観衆', 'POS': 'noun', 'selected': false},
    {'english': 'lift', 'japanese': '持ち上げる', 'POS': 'verb', 'selected': false},
    {
      'english': 'procedure',
      'japanese': '手続き',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'email', 'japanese': 'e-メール', 'POS': 'verb', 'selected': false},
    {
      'english': 'global',
      'japanese': 'グローバル',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'struggle',
      'japanese': '奮闘する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'advertise',
      'japanese': '宣伝する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'select', 'japanese': '選択する', 'POS': 'verb', 'selected': false},
    {'english': 'surround', 'japanese': '周り', 'POS': 'verb', 'selected': false},
    {'english': 'extent', 'japanese': '規模', 'POS': 'noun', 'selected': false},
    {'english': 'river', 'japanese': '川', 'POS': 'noun', 'selected': false},
    {
      'english': 'annual',
      'japanese': '年に一度',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'fully', 'japanese': '完全に', 'POS': 'adverb', 'selected': false},
    {
      'english': 'contrast',
      'japanese': '対比する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'roll', 'japanese': '転がる', 'POS': 'verb', 'selected': false},
    {'english': 'reality', 'japanese': '現実', 'POS': 'noun', 'selected': false},
    {
      'english': 'photograph',
      'japanese': '写真',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'artist', 'japanese': '芸術家', 'POS': 'noun', 'selected': false},
    {'english': 'conflict', 'japanese': '闘争', 'POS': 'noun', 'selected': false},
    {
      'english': 'entire',
      'japanese': '全体の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'presence', 'japanese': '存在', 'POS': 'noun', 'selected': false},
    {'english': 'crowd', 'japanese': '人混み', 'POS': 'noun', 'selected': false},
    {'english': 'corner', 'japanese': '角', 'POS': 'noun', 'selected': false},
    {'english': 'gas', 'japanese': 'ガソリン', 'POS': 'noun', 'selected': false},
    {'english': 'shift', 'japanese': '移す', 'POS': 'verb', 'selected': false},
    {'english': 'net', 'japanese': '網', 'POS': 'adjective', 'selected': false},
    {'english': 'category', 'japanese': '分類', 'POS': 'noun', 'selected': false},
    {
      'english': 'secretary',
      'japanese': '秘書',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'defense', 'japanese': '防御', 'POS': 'noun', 'selected': false},
    {
      'english': 'quick',
      'japanese': '早い',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'cook', 'japanese': '料理人', 'POS': 'noun', 'selected': false},
    {'english': 'spread', 'japanese': '広がる', 'POS': 'verb', 'selected': false},
    {
      'english': 'nuclear',
      'japanese': '核',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'scale', 'japanese': '規模', 'POS': 'noun', 'selected': false},
    {'english': 'driver', 'japanese': '運転手', 'POS': 'noun', 'selected': false},
    {'english': 'ball', 'japanese': 'ボール', 'POS': 'noun', 'selected': false},
    {'english': 'cry', 'japanese': '泣く', 'POS': 'verb', 'selected': false},
    {
      'english': 'introduction',
      'japanese': '導入',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'requirement',
      'japanese': '要件',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'north', 'japanese': '北', 'POS': 'noun', 'selected': false},
    {
      'english': 'confirm',
      'japanese': '確認する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'senior',
      'japanese': '上級の、年上の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'photo', 'japanese': '写真', 'POS': 'noun', 'selected': false},
    {'english': 'refuse', 'japanese': '拒む', 'POS': 'verb', 'selected': false},
    {
      'english': 'transport',
      'japanese': '運ぶ',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'emerge', 'japanese': '出現する', 'POS': 'verb', 'selected': false},
    {'english': 'map', 'japanese': '地図', 'POS': 'noun', 'selected': false},
    {
      'english': 'concept',
      'japanese': '概念・発想',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'island', 'japanese': '島', 'POS': 'noun', 'selected': false},
    {'english': 'reform', 'japanese': '改革', 'POS': 'noun', 'selected': false},
    {
      'english': 'neither',
      'japanese': 'どちらも～ない',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'football',
      'japanese': 'サッカー',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'survive',
      'japanese': '生き残る',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'flight', 'japanese': '飛行', 'POS': 'noun', 'selected': false},
    {'english': 'left', 'japanese': '左', 'POS': 'adjective', 'selected': false},
    {'english': 'solve', 'japanese': '解決する', 'POS': 'verb', 'selected': false},
    {'english': 'neighbor', 'japanese': '隣の', 'POS': 'noun', 'selected': false},
    {
      'english': 'background',
      'japanese': '背景',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'technique',
      'japanese': '技術',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'traffic', 'japanese': '交通', 'POS': 'noun', 'selected': false},
    {
      'english': 'improvement',
      'japanese': '改善',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'tool', 'japanese': '道具', 'POS': 'noun', 'selected': false},
    {
      'english': 'consequence',
      'japanese': '結果',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'circumstance',
      'japanese': '取り巻く環境',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'smoke', 'japanese': '煙', 'POS': 'noun', 'selected': false},
    {'english': 'reaction', 'japanese': '反応', 'POS': 'noun', 'selected': false},
    {'english': 'rain', 'japanese': '雨', 'POS': 'noun', 'selected': false},
    {
      'english': 'busy',
      'japanese': '忙しい',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'lesson', 'japanese': '授業', 'POS': 'noun', 'selected': false},
    {'english': 'brain', 'japanese': '脳', 'POS': 'noun', 'selected': false},
    {'english': 'mass', 'japanese': '巨大', 'POS': 'noun', 'selected': false},
    {
      'english': 'funny',
      'japanese': 'おかしい',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'contribute',
      'japanese': '貢献する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'failure', 'japanese': '失敗', 'POS': 'noun', 'selected': false},
    {'english': 'schedule', 'japanese': '日程', 'POS': 'noun', 'selected': false},
    {
      'english': 'speaker',
      'japanese': 'スピーカー',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'bottom', 'japanese': '底', 'POS': 'noun', 'selected': false},
    {'english': 'adopt', 'japanese': '採用する', 'POS': 'verb', 'selected': false},
    {
      'english': 'combine',
      'japanese': '組み合わせる',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'mountain', 'japanese': '山', 'POS': 'noun', 'selected': false},
    {'english': 'waste', 'japanese': '無駄にする', 'POS': 'verb', 'selected': false},
    {'english': 'hide', 'japanese': '隠れる', 'POS': 'verb', 'selected': false},
    {'english': 'marriage', 'japanese': '結婚', 'POS': 'noun', 'selected': false},
    {'english': 'ticket', 'japanese': 'チケット', 'POS': 'noun', 'selected': false},
    {'english': 'meal', 'japanese': 'ご飯', 'POS': 'noun', 'selected': false},
    {
      'english': 'colleague',
      'japanese': '同僚',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'bag', 'japanese': 'バッグ', 'POS': 'noun', 'selected': false},
    {'english': 'repeat', 'japanese': '繰り返す', 'POS': 'verb', 'selected': false},
    {
      'english': 'equal',
      'japanese': '等しい',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'expression',
      'japanese': '表現',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'plus',
      'japanese': 'プラス',
      'POS': 'preposition',
      'selected': false
    },
    {
      'english': 'extremely',
      'japanese': '極めて',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'owner', 'japanese': '持ち主', 'POS': 'noun', 'selected': false},
    {'english': 'plane', 'japanese': '飛行機', 'POS': 'noun', 'selected': false},
    {
      'english': 'commercial',
      'japanese': '商業の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'lady', 'japanese': '女性', 'POS': 'noun', 'selected': false},
    {'english': 'duty', 'japanese': '業務', 'POS': 'noun', 'selected': false},
    {'english': 'strength', 'japanese': '体力', 'POS': 'noun', 'selected': false},
    {'english': 'connect', 'japanese': 'つなぐ', 'POS': 'verb', 'selected': false},
    {
      'english': 'cultural',
      'japanese': '文化の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'arrange', 'japanese': '並べる', 'POS': 'verb', 'selected': false},
    {'english': 'scheme', 'japanese': '計画', 'POS': 'noun', 'selected': false},
    {'english': 'payment', 'japanese': '支払い', 'POS': 'noun', 'selected': false},
    {
      'english': 'unfortunately',
      'japanese': '残念ながら',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'brief',
      'japanese': '短時間の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'bird', 'japanese': '鳥', 'POS': 'noun', 'selected': false},
    {
      'english': 'demonstrate',
      'japanese': '実演する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'contribution',
      'japanese': '貢献',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'appreciate',
      'japanese': '感謝する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'chapter', 'japanese': '章', 'POS': 'noun', 'selected': false},
    {
      'english': 'secret',
      'japanese': '秘密な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'apparently',
      'japanese': '～そうだ、～らしい',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'novel', 'japanese': '小説', 'POS': 'noun', 'selected': false},
    {'english': 'union', 'japanese': '組合', 'POS': 'noun', 'selected': false},
    {'english': 'burn', 'japanese': '燃える', 'POS': 'verb', 'selected': false},
    {'english': 'trend', 'japanese': '傾向、動向', 'POS': 'noun', 'selected': false},
    {
      'english': 'initial',
      'japanese': '最初の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'pleasure', 'japanese': '喜び', 'POS': 'noun', 'selected': false},
    {
      'english': 'suggestion',
      'japanese': '提案',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'critical',
      'japanese': '批判的な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'gather', 'japanese': '集合', 'POS': 'verb', 'selected': false},
    {
      'english': 'mostly',
      'japanese': 'たいていは',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'earth', 'japanese': '地球', 'POS': 'noun', 'selected': false},
    {
      'english': 'pop',
      'japanese': 'ポンと音を立てる、破裂させる',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'essential',
      'japanese': '不可欠な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'desire', 'japanese': '望む', 'POS': 'verb', 'selected': false},
    {
      'english': 'promote',
      'japanese': '昇進させる',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'currently',
      'japanese': '現在',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'employ', 'japanese': '雇う', 'POS': 'verb', 'selected': false},
    {'english': 'path', 'japanese': '小道', 'POS': 'noun', 'selected': false},
    {'english': 'topic', 'japanese': '題', 'POS': 'noun', 'selected': false},
    {'english': 'beach', 'japanese': '海辺', 'POS': 'noun', 'selected': false},
    {
      'english': 'attract',
      'japanese': 'ひきつける',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'engage',
      'japanese': '関心を引き付ける',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'powerful',
      'japanese': '強力な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'flower', 'japanese': '花', 'POS': 'noun', 'selected': false},
    {'english': 'crisis', 'japanese': '危機', 'POS': 'noun', 'selected': false},
    {
      'english': 'settle',
      'japanese': '決着をつける',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'boat', 'japanese': 'ボート', 'POS': 'noun', 'selected': false},
    {'english': 'aid', 'japanese': '援助する', 'POS': 'verb', 'selected': false},
    {'english': 'fan', 'japanese': '扇風機', 'POS': 'noun', 'selected': false},
    {'english': 'kitchen', 'japanese': '台所', 'POS': 'noun', 'selected': false},
    {'english': 'twice', 'japanese': '2回', 'POS': 'adverb', 'selected': false},
    {
      'english': 'fresh',
      'japanese': '新鮮な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'delay', 'japanese': '遅れる', 'POS': 'noun', 'selected': false},
    {'english': 'safety', 'japanese': '安全', 'POS': 'noun', 'selected': false},
    {
      'english': 'engineer',
      'japanese': '技術者',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'quiet',
      'japanese': '静か',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'insurance',
      'japanese': '保険',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'nurse', 'japanese': '看護師', 'POS': 'noun', 'selected': false},
    {'english': 'divide', 'japanese': '分ける', 'POS': 'verb', 'selected': false},
    {'english': 'length', 'japanese': '長さ', 'POS': 'noun', 'selected': false},
    {
      'english': 'investigation',
      'japanese': '調査',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'package',
      'japanese': 'パッケージ',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'somewhere',
      'japanese': 'どこか',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'expand', 'japanese': '拡大する', 'POS': 'verb', 'selected': false},
    {
      'english': 'commit',
      'japanese': 'ささげる、専念する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'obvious',
      'japanese': '明らかな',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'jump', 'japanese': '跳ぶ', 'POS': 'verb', 'selected': false},
    {'english': 'weapon', 'japanese': '武器', 'POS': 'noun', 'selected': false},
    {
      'english': 'relatively',
      'japanese': '比較的に',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'host',
      'japanese': '主催者、（客をもてなす）主人',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'winter', 'japanese': '冬', 'POS': 'noun', 'selected': false},
    {'english': 'district', 'japanese': '区', 'POS': 'noun', 'selected': false},
    {
      'english': 'broad',
      'japanese': '幅広い',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'tire', 'japanese': '疲れる', 'POS': 'verb', 'selected': false},
    {'english': 'spring', 'japanese': '春', 'POS': 'noun', 'selected': false},
    {'english': 'spirit', 'japanese': '魂', 'POS': 'noun', 'selected': false},
    {'english': 'lunch', 'japanese': '昼食', 'POS': 'noun', 'selected': false},
    {
      'english': 'actual',
      'japanese': '現実の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'pool', 'japanese': '水たまり', 'POS': 'noun', 'selected': false},
    {'english': 'battle', 'japanese': '戦い', 'POS': 'noun', 'selected': false},
    {
      'english': 'tradition',
      'japanese': '伝統',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'cash', 'japanese': '現金', 'POS': 'noun', 'selected': false},
    {
      'english': 'hardly',
      'japanese': 'ほとんど～ない',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'award', 'japanese': '賞', 'POS': 'noun', 'selected': false},
    {'english': 'coach', 'japanese': 'コーチ', 'POS': 'noun', 'selected': false},
    {
      'english': 'experiment',
      'japanese': '実験',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'consideration',
      'japanese': '考慮',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'strange',
      'japanese': '変な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'code', 'japanese': '暗号', 'POS': 'noun', 'selected': false},
    {
      'english': 'possibly',
      'japanese': 'もしかしたら',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'threat',
      'japanese': '脅かす人・もの',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'accident', 'japanese': '事故', 'POS': 'noun', 'selected': false},
    {
      'english': 'impossible',
      'japanese': '不可能',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'revenue', 'japanese': '収益', 'POS': 'noun', 'selected': false},
    {
      'english': 'enable',
      'japanese': '～を可能にする',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'afraid',
      'japanese': '怖がる',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'active',
      'japanese': '積極的',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'conclude',
      'japanese': '終える',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'religious',
      'japanese': '宗教の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'cancer', 'japanese': '癌', 'POS': 'noun', 'selected': false},
    {
      'english': 'convince',
      'japanese': '納得させる',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'vary', 'japanese': '変わる', 'POS': 'verb', 'selected': false},
    {
      'english': 'environmental',
      'japanese': '環境の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'sun', 'japanese': '太陽', 'POS': 'noun', 'selected': false},
    {
      'english': 'healthy',
      'japanese': '健康な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'blow', 'japanese': '吹く', 'POS': 'verb', 'selected': false},
    {'english': 'volume', 'japanese': '音量、巻', 'POS': 'noun', 'selected': false},
    {'english': 'location', 'japanese': '位置', 'POS': 'noun', 'selected': false},
    {'english': 'invest', 'japanese': '投資する', 'POS': 'verb', 'selected': false},
    {'english': 'proceed', 'japanese': '進める', 'POS': 'verb', 'selected': false},
    {'english': 'wash', 'japanese': '洗う', 'POS': 'verb', 'selected': false},
    {'english': 'actor', 'japanese': '俳優', 'POS': 'noun', 'selected': false},
    {
      'english': 'glad',
      'japanese': '喜び',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'tape', 'japanese': 'テープ', 'POS': 'noun', 'selected': false},
    {
      'english': 'whereas',
      'japanese': 'その一方で',
      'POS': 'conjunction',
      'selected': false
    },
    {
      'english': 'opposite',
      'japanese': '反対',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'stone', 'japanese': '石', 'POS': 'noun', 'selected': false},
    {'english': 'sum', 'japanese': '合計', 'POS': 'noun', 'selected': false},
    {'english': 'murder', 'japanese': '殺人犯', 'POS': 'noun', 'selected': false},
    {
      'english': 'monitor',
      'japanese': '監視する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'soldier', 'japanese': '軍人', 'POS': 'noun', 'selected': false},
    {'english': 'finance', 'japanese': '財務', 'POS': 'noun', 'selected': false},
    {
      'english': 'hate',
      'japanese': '～をひどく嫌う',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'egg', 'japanese': '卵', 'POS': 'noun', 'selected': false},
    {
      'english': 'concert',
      'japanese': 'コンサート',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'shock', 'japanese': '衝撃', 'POS': 'noun', 'selected': false},
    {
      'english': 'comfortable',
      'japanese': '心地よい',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'usual',
      'japanese': '通常',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'carefully',
      'japanese': '慎重に',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'pack', 'japanese': '詰める', 'POS': 'verb', 'selected': false},
    {'english': 'recall', 'japanese': '思い出す', 'POS': 'verb', 'selected': false},
    {'english': 'wine', 'japanese': 'ワイン', 'POS': 'noun', 'selected': false},
    {'english': 'camera', 'japanese': 'カメラ', 'POS': 'noun', 'selected': false},
    {'english': 'swim', 'japanese': '泳ぐ', 'POS': 'verb', 'selected': false},
    {
      'english': 'manufacture',
      'japanese': '製造する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'theater', 'japanese': '劇場', 'POS': 'noun', 'selected': false},
    {'english': 'cycle', 'japanese': '循環', 'POS': 'noun', 'selected': false},
    {'english': 'coffee', 'japanese': 'コーヒー', 'POS': 'noun', 'selected': false},
    {
      'english': 'totally',
      'japanese': '完全に',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'museum', 'japanese': '美術館', 'POS': 'noun', 'selected': false},
    {'english': 'visitor', 'japanese': '訪問者', 'POS': 'noun', 'selected': false},
    {'english': 'freedom', 'japanese': '自由', 'POS': 'noun', 'selected': false},
    {
      'english': 'construction',
      'japanese': '建設',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'dear',
      'japanese': '親愛なる',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'objective',
      'japanese': '客観的',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'moreover',
      'japanese': 'そのうえに',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'onto',
      'japanese': '～の上に',
      'POS': 'preposition',
      'selected': false
    },
    {
      'english': 'historical',
      'japanese': '歴史的な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'oppose', 'japanese': '反対する', 'POS': 'verb', 'selected': false},
    {'english': 'branch', 'japanese': '枝', 'POS': 'noun', 'selected': false},
    {'english': 'vehicle', 'japanese': '乗り物', 'POS': 'noun', 'selected': false},
    {
      'english': 'scientist',
      'japanese': '科学者',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'route', 'japanese': '道', 'POS': 'noun', 'selected': false},
    {'english': 'bind', 'japanese': '縛る', 'POS': 'verb', 'selected': false},
    {'english': 'belong', 'japanese': '所属する', 'POS': 'verb', 'selected': false},
    {'english': 'taste', 'japanese': '味', 'POS': 'noun', 'selected': false},
    {'english': 'tonight', 'japanese': '今夜', 'POS': 'noun', 'selected': false},
    {'english': 'fashion', 'japanese': '流行', 'POS': 'noun', 'selected': false},
    {'english': 'danger', 'japanese': '危険', 'POS': 'noun', 'selected': false},
    {'english': 'bomb', 'japanese': '爆弾', 'POS': 'noun', 'selected': false},
    {'english': 'army', 'japanese': '陸軍', 'POS': 'noun', 'selected': false},
    {
      'english': 'dangerous',
      'japanese': '危険',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'decrease', 'japanese': '減少', 'POS': 'verb', 'selected': false},
    {'english': 'hurt', 'japanese': '傷つける', 'POS': 'verb', 'selected': false},
    {'english': 'council', 'japanese': '評議会', 'POS': 'noun', 'selected': false},
    {'english': 'editor', 'japanese': '編集者', 'POS': 'noun', 'selected': false},
    {
      'english': 'normally',
      'japanese': '通常',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'sight', 'japanese': '視力', 'POS': 'noun', 'selected': false},
    {
      'english': 'generate',
      'japanese': '生成する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'gift', 'japanese': '贈り物', 'POS': 'noun', 'selected': false},
    {'english': 'delivery', 'japanese': '宅配', 'POS': 'noun', 'selected': false},
    {'english': 'deny', 'japanese': '否定する', 'POS': 'verb', 'selected': false},
    {'english': 'guest', 'japanese': 'ゲスト', 'POS': 'noun', 'selected': false},
    {
      'english': 'anybody',
      'japanese': 'だれか',
      'POS': 'pronoun',
      'selected': false
    },
    {'english': 'bedroom', 'japanese': '寝室', 'POS': 'noun', 'selected': false},
    {'english': 'quote', 'japanese': '引用する', 'POS': 'verb', 'selected': false},
    {'english': 'climb', 'japanese': '登る', 'POS': 'verb', 'selected': false},
    {
      'english': 'basically',
      'japanese': '基本的に',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'violence', 'japanese': '暴力', 'POS': 'noun', 'selected': false},
    {'english': 'minister', 'japanese': '大臣', 'POS': 'noun', 'selected': false},
    {
      'english': 'mainly',
      'japanese': '投票者、有権者',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'mouth', 'japanese': '口', 'POS': 'noun', 'selected': false},
    {'english': 'noise', 'japanese': '騒音', 'POS': 'noun', 'selected': false},
    {'english': 'manner', 'japanese': '方法', 'POS': 'noun', 'selected': false},
    {'english': 'gun', 'japanese': 'ピストル、鉄砲', 'POS': 'noun', 'selected': false},
    {'english': 'square', 'japanese': '四角形', 'POS': 'noun', 'selected': false},
    {'english': 'occasion', 'japanese': '機会', 'POS': 'noun', 'selected': false},
    {
      'english': 'familiar',
      'japanese': '親しい',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'ignore', 'japanese': '無視する', 'POS': 'verb', 'selected': false},
    {
      'english': 'destroy',
      'japanese': '破壊する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'affair', 'japanese': '業務', 'POS': 'noun', 'selected': false},
    {
      'english': 'civil',
      'japanese': '市民の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'locate',
      'japanese': '（場所を）見つける',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'citizen', 'japanese': '市民', 'POS': 'noun', 'selected': false},
    {
      'english': 'temperature',
      'japanese': '温度',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'gold', 'japanese': '金', 'POS': 'noun', 'selected': false},
    {
      'english': 'domestic',
      'japanese': '家庭の、国内の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'load', 'japanese': '積載貨物', 'POS': 'noun', 'selected': false},
    {'english': 'belief', 'japanese': '信念', 'POS': 'noun', 'selected': false},
    {'english': 'troop', 'japanese': '一団、軍隊', 'POS': 'noun', 'selected': false},
    {
      'english': 'technical',
      'japanese': '技術の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'remind',
      'japanese': '思い出させる',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'arrangement',
      'japanese': '合意、取り決め',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'skin', 'japanese': '肌', 'POS': 'noun', 'selected': false},
    {'english': 'prison', 'japanese': '牢獄', 'POS': 'noun', 'selected': false},
    {
      'english': 'switch',
      'japanese': '切り替える',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'acquire', 'japanese': '得る', 'POS': 'verb', 'selected': false},
    {
      'english': 'corporate',
      'japanese': '法人の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'fairly',
      'japanese': 'かなり',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'wood', 'japanese': '木', 'POS': 'noun', 'selected': false},
    {
      'english': 'participate',
      'japanese': '参加する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'tough',
      'japanese': 'とても難しい',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'tear', 'japanese': '涙', 'POS': 'noun', 'selected': false},
    {
      'english': 'representative',
      'japanese': '代表',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'capacity',
      'japanese': '許容量',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'border', 'japanese': '国境', 'POS': 'noun', 'selected': false},
    {'english': 'shake', 'japanese': '振る', 'POS': 'verb', 'selected': false},
    {
      'english': 'assessment',
      'japanese': '査定、評価',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'shoe', 'japanese': 'くつ', 'POS': 'noun', 'selected': false},
    {'english': 'ought', 'japanese': '～すべき', 'POS': 'verb', 'selected': false},
    {'english': 'ad', 'japanese': '広告', 'POS': 'adverb', 'selected': false},
    {'english': 'fee', 'japanese': '謝礼金', 'POS': 'noun', 'selected': false},
    {'english': 'hall', 'japanese': 'ホール', 'POS': 'noun', 'selected': false},
    {
      'english': 'regulation',
      'japanese': '規制',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'escape', 'japanese': '逃げる', 'POS': 'verb', 'selected': false},
    {'english': 'studio', 'japanese': 'スタジオ', 'POS': 'noun', 'selected': false},
    {
      'english': 'proper',
      'japanese': '適切な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'relax', 'japanese': 'くつろぐ', 'POS': 'verb', 'selected': false},
    {'english': 'tourist', 'japanese': '旅行者', 'POS': 'noun', 'selected': false},
    {
      'english': 'component',
      'japanese': '構成要素、部品',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'afford',
      'japanese': '買うことができる',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'lawyer', 'japanese': '弁護士', 'POS': 'noun', 'selected': false},
    {'english': 'suspect', 'japanese': '疑う', 'POS': 'verb', 'selected': false},
    {'english': 'cup', 'japanese': 'カップ', 'POS': 'noun', 'selected': false},
    {
      'english': 'description',
      'japanese': '描写',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'confidence',
      'japanese': '自信',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'industrial',
      'japanese': '産業の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'complain',
      'japanese': '不平を言う',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'perspective',
      'japanese': '観点',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'error',
      'japanese': '誤り、エラー',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'arrest', 'japanese': '逮捕する', 'POS': 'noun', 'selected': false},
    {'english': 'assess', 'japanese': '評価する', 'POS': 'verb', 'selected': false},
    {
      'english': 'register',
      'japanese': '登録簿',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'asset',
      'japanese': '貴重な人材、資産',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'signal', 'japanese': '信号', 'POS': 'noun', 'selected': false},
    {'english': 'finger', 'japanese': '指', 'POS': 'noun', 'selected': false},
    {
      'english': 'relevant',
      'japanese': '関係のある',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'explore', 'japanese': '探る', 'POS': 'verb', 'selected': false},
    {
      'english': 'leadership',
      'japanese': '指導権',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'commitment',
      'japanese': '約束、義務',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'wake', 'japanese': '起こす', 'POS': 'verb', 'selected': false},
    {
      'english': 'necessarily',
      'japanese': '必ずしも',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'bright',
      'japanese': '輝く',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'frame',
      'japanese': '骨組み、体格',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'slowly',
      'japanese': 'ゆっくりと',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'bond', 'japanese': '絆', 'POS': 'noun', 'selected': false},
    {'english': 'hire', 'japanese': '雇う', 'POS': 'verb', 'selected': false},
    {'english': 'hole', 'japanese': '穴', 'POS': 'noun', 'selected': false},
    {'english': 'tie', 'japanese': 'つなげる', 'POS': 'verb', 'selected': false},
    {
      'english': 'internal',
      'japanese': '内部の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'chain', 'japanese': '鎖', 'POS': 'noun', 'selected': false},
    {
      'english': 'literature',
      'japanese': '文学',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'victim', 'japanese': '犠牲者', 'POS': 'noun', 'selected': false},
    {
      'english': 'threaten',
      'japanese': '脅かす',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'division', 'japanese': '分割', 'POS': 'noun', 'selected': false},
    {'english': 'secure', 'japanese': '確保する', 'POS': 'verb', 'selected': false},
    {'english': 'amaze', 'japanese': '驚かす', 'POS': 'verb', 'selected': false},
    {'english': 'device', 'japanese': '装置', 'POS': 'noun', 'selected': false},
    {'english': 'birth', 'japanese': '誕生', 'POS': 'noun', 'selected': false},
    {'english': 'forest', 'japanese': '森', 'POS': 'noun', 'selected': false},
    {'english': 'label', 'japanese': 'ラベル', 'POS': 'noun', 'selected': false},
    {'english': 'root', 'japanese': '根', 'POS': 'noun', 'selected': false},
    {'english': 'factory', 'japanese': '工場', 'POS': 'noun', 'selected': false},
    {'english': 'expense', 'japanese': '費用', 'POS': 'noun', 'selected': false},
    {
      'english': 'channel',
      'japanese': 'チャンネル',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'investigate',
      'japanese': '調査する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'recommendation',
      'japanese': '推薦',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'rank', 'japanese': '階級、地位', 'POS': 'noun', 'selected': false},
    {
      'english': 'typical',
      'japanese': '典型的な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'west', 'japanese': '西', 'POS': 'noun', 'selected': false},
    {
      'english': 'friendly',
      'japanese': '友好的',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'resident',
      'japanese': '居住者',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'provision',
      'japanese': '規定',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'concentrate',
      'japanese': '集中する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'plenty',
      'japanese': 'たくさんの',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'export', 'japanese': '輸出する', 'POS': 'verb', 'selected': false},
    {
      'english': 'entirely',
      'japanese': '完全に',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'strongly',
      'japanese': '強く',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'bridge', 'japanese': '橋', 'POS': 'noun', 'selected': false},
    {'english': 'consist', 'japanese': '成る', 'POS': 'verb', 'selected': false},
    {
      'english': 'graduate',
      'japanese': '卒業する',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'brand', 'japanese': '商標', 'POS': 'noun', 'selected': false},
    {
      'english': 'moral',
      'japanese': '道義をわきまえた',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'insist', 'japanese': '主張する', 'POS': 'verb', 'selected': false},
    {
      'english': 'combination',
      'japanese': '組み合わせ',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'abuse', 'japanese': '乱用する', 'POS': 'noun', 'selected': false},
    {'english': 'ice', 'japanese': '氷', 'POS': 'noun', 'selected': false},
    {
      'english': 'principal',
      'japanese': '長',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'master', 'japanese': '管理人', 'POS': 'noun', 'selected': false},
    {
      'english': 'definitely',
      'japanese': '間違いなく',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'session', 'japanese': '期間', 'POS': 'noun', 'selected': false},
    {'english': 'grade', 'japanese': '成績', 'POS': 'noun', 'selected': false},
    {
      'english': 'nevertheless',
      'japanese': 'それにもかかわらず',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'predict',
      'japanese': '予想する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'previously',
      'japanese': '以前に',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'protection',
      'japanese': '保護',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'largely',
      'japanese': 'だいたいは',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'wed', 'japanese': '結婚する', 'POS': 'verb', 'selected': false},
    {'english': 'rent', 'japanese': '賃借りする', 'POS': 'verb', 'selected': false},
    {'english': 'shot', 'japanese': '打つ', 'POS': 'noun', 'selected': false},
    {
      'english': 'appearance',
      'japanese': '外見',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'reasonable',
      'japanese': '程よい',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'guarantee',
      'japanese': '保障する',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'till',
      'japanese': 'まで',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'theme', 'japanese': 'テーマ', 'POS': 'noun', 'selected': false},
    {'english': 'judgment', 'japanese': '判決', 'POS': 'noun', 'selected': false},
    {'english': 'odd', 'japanese': '変な', 'POS': 'adjective', 'selected': false},
    {
      'english': 'approve',
      'japanese': '承認する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'loan', 'japanese': 'ローン', 'POS': 'noun', 'selected': false},
    {
      'english': 'definition',
      'japanese': '定義',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'elect', 'japanese': '選ぶ', 'POS': 'verb', 'selected': false},
    {
      'english': 'atmosphere',
      'japanese': '雰囲気',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'farmer', 'japanese': '農夫', 'POS': 'noun', 'selected': false},
    {
      'english': 'comparison',
      'japanese': '比較',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'characteristic',
      'japanese': '特徴',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'license', 'japanese': '免許', 'POS': 'noun', 'selected': false},
    {'english': 'rely', 'japanese': '頼る', 'POS': 'verb', 'selected': false},
    {
      'english': 'narrow',
      'japanese': '狭い',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'succeed',
      'japanese': '成功する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'identity',
      'japanese': '身元、独自性',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'desk', 'japanese': '机', 'POS': 'noun', 'selected': false},
    {'english': 'permit', 'japanese': '許可する', 'POS': 'verb', 'selected': false},
    {
      'english': 'seriously',
      'japanese': '深刻に',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'wild',
      'japanese': '野生の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'empty',
      'japanese': '空の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'commission',
      'japanese': '任務',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'unique',
      'japanese': 'ユニークな、独特な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'association',
      'japanese': '協会、組合',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'instrument',
      'japanese': '器具、楽器',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'investor',
      'japanese': '投資家',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'practical',
      'japanese': '実際の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'tea', 'japanese': '茶', 'POS': 'noun', 'selected': false},
    {
      'english': 'lovely',
      'japanese': '美しい・素晴らしい',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'soft',
      'japanese': '柔らかい',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'row', 'japanese': '列', 'POS': 'noun', 'selected': false},
    {
      'english': 'youth',
      'japanese': '青年時代、若いころ',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'lock', 'japanese': '錠前', 'POS': 'noun', 'selected': false},
    {'english': 'fuel', 'japanese': '燃料', 'POS': 'noun', 'selected': false},
    {
      'english': 'expectation',
      'japanese': '期待',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'employment',
      'japanese': '雇用',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'celebrate',
      'japanese': '祝う',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'sexual',
      'japanese': '性的な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'shoulder', 'japanese': '肩', 'POS': 'noun', 'selected': false},
    {'english': 'breath', 'japanese': '息', 'POS': 'noun', 'selected': false},
    {
      'english': 'increasingly',
      'japanese': 'ますます',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'import', 'japanese': '輸入する', 'POS': 'verb', 'selected': false},
    {'english': 'bottle', 'japanese': 'ボトル', 'POS': 'noun', 'selected': false},
    {
      'english': 'ourselves',
      'japanese': '私たち自身',
      'POS': 'pronoun',
      'selected': false
    },
    {'english': 'sheet', 'japanese': 'シーツ', 'POS': 'noun', 'selected': false},
    {'english': 'engine', 'japanese': 'エンジン', 'POS': 'noun', 'selected': false},
    {'english': 'cast', 'japanese': '配役する', 'POS': 'verb', 'selected': false},
    {'english': 'notion', 'japanese': '考え', 'POS': 'noun', 'selected': false},
    {
      'english': 'conservative',
      'japanese': '保守的な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'journey', 'japanese': '旅', 'POS': 'noun', 'selected': false},
    {
      'english': 'opposition',
      'japanese': '反対',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'relief', 'japanese': '安堵', 'POS': 'noun', 'selected': false},
    {'english': 'debt', 'japanese': '借金', 'POS': 'noun', 'selected': false},
    {'english': 'honor', 'japanese': '名誉', 'POS': 'noun', 'selected': false},
    {'english': 'outcome', 'japanese': '結果', 'POS': 'noun', 'selected': false},
    {'english': 'blame', 'japanese': '責める', 'POS': 'verb', 'selected': false},
    {
      'english': 'explanation',
      'japanese': '説明',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'arise', 'japanese': '発生する', 'POS': 'verb', 'selected': false},
    {
      'english': 'musical',
      'japanese': '音楽の、音楽の才能がある',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'recover',
      'japanese': '回復する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'dad', 'japanese': 'パパ', 'POS': 'noun', 'selected': false},
    {'english': 'stretch', 'japanese': '伸ばす', 'POS': 'verb', 'selected': false},
    {
      'english': 'declare',
      'japanese': '宣言する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'retire',
      'japanese': '退職する、引退する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'tiny',
      'japanese': 'とても小さい',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'careful',
      'japanese': '気を付ける',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'suitable',
      'japanese': 'ふさわしい',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'native',
      'japanese': '母国',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'fruit', 'japanese': 'くだもの', 'POS': 'noun', 'selected': false},
    {
      'english': 'analyze',
      'japanese': '分析する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'witness', 'japanese': '証人', 'POS': 'noun', 'selected': false},
    {'english': 'mail', 'japanese': '郵便', 'POS': 'noun', 'selected': false},
    {
      'english': 'terrible',
      'japanese': 'ひどい',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'researcher',
      'japanese': '研究者',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'ordinary',
      'japanese': '通常の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'selection',
      'japanese': '選択',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'anywhere',
      'japanese': 'どこでも、どこにも',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'mental',
      'japanese': '精神',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'participant',
      'japanese': '参加者',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'vision', 'japanese': '視覚', 'POS': 'noun', 'selected': false},
    {
      'english': 'personality',
      'japanese': '人柄',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'specifically',
      'japanese': '具体的に',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'fat', 'japanese': '太い', 'POS': 'adjective', 'selected': false},
    {'english': 'entry', 'japanese': '入場', 'POS': 'noun', 'selected': false},
    {'english': 'fellow', 'japanese': '仲間', 'POS': 'noun', 'selected': false},
    {
      'english': 'chemical',
      'japanese': '化学的な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'capture',
      'japanese': '捕らえる',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'tip', 'japanese': '先端', 'POS': 'noun', 'selected': false},
    {
      'english': 'discount',
      'japanese': '値引き',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'peak', 'japanese': '頂点', 'POS': 'noun', 'selected': false},
    {'english': 'chairman', 'japanese': '議長', 'POS': 'noun', 'selected': false},
    {
      'english': 'proportion',
      'japanese': '割合',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'ear', 'japanese': '耳', 'POS': 'noun', 'selected': false},
    {
      'english': 'disappear',
      'japanese': '消える',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'shout', 'japanese': '叫ぶ', 'POS': 'verb', 'selected': false},
    {'english': 'yard', 'japanese': '庭', 'POS': 'noun', 'selected': false},
    {
      'english': 'constant',
      'japanese': '一定の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'significantly',
      'japanese': '著しく、かなり',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'hill', 'japanese': '丘', 'POS': 'noun', 'selected': false},
    {
      'english': 'considerable',
      'japanese': 'かなりの',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'instruction',
      'japanese': '指示',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'intelligence',
      'japanese': '知能',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'ideal',
      'japanese': '理想',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'folk', 'japanese': '人々', 'POS': 'noun', 'selected': false},
    {
      'english': 'surely',
      'japanese': 'まさか',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'guard', 'japanese': '護衛する', 'POS': 'noun', 'selected': false},
    {'english': 'cat', 'japanese': '猫', 'POS': 'noun', 'selected': false},
    {
      'english': 'somewhat',
      'japanese': 'いくらか、やや',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'kiss', 'japanese': 'キス', 'POS': 'verb', 'selected': false},
    {
      'english': 'presentation',
      'japanese': 'プレゼンテーション',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'joint', 'japanese': '関節', 'POS': 'noun', 'selected': false},
    {
      'english': 'compete',
      'japanese': '競争する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'poll', 'japanese': '世論調査', 'POS': 'noun', 'selected': false},
    {
      'english': 'weak',
      'japanese': '弱い',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'faith', 'japanese': '信仰、信条', 'POS': 'noun', 'selected': false},
    {
      'english': 'reduction',
      'japanese': '縮小',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'reserve',
      'japanese': '予約する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'complaint',
      'japanese': '不平',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'bore', 'japanese': '退屈させる', 'POS': 'verb', 'selected': false},
    {'english': 'mission', 'japanese': '任務', 'POS': 'noun', 'selected': false},
    {
      'english': 'somehow',
      'japanese': 'なんとなく',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'tone', 'japanese': '音質', 'POS': 'noun', 'selected': false},
    {
      'english': 'neighborhood',
      'japanese': '隣人',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'passenger',
      'japanese': '乗客',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'justice',
      'japanese': '裁判、裁き',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'phase', 'japanese': '段階', 'POS': 'noun', 'selected': false},
    {
      'english': 'thin',
      'japanese': '薄い',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'rush', 'japanese': '急ぐ', 'POS': 'verb', 'selected': false},
    {
      'english': 'formal',
      'japanese': '形式的な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'religion', 'japanese': '宗教', 'POS': 'noun', 'selected': false},
    {
      'english': 'employer',
      'japanese': '雇用者',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'reject', 'japanese': '断る', 'POS': 'verb', 'selected': false},
    {
      'english': 'latter',
      'japanese': '後ろのほうの',
      'POS': 'determiner',
      'selected': false
    },
    {'english': 'plate', 'japanese': '皿', 'POS': 'noun', 'selected': false},
    {'english': 'ban', 'japanese': '禁止する', 'POS': 'verb', 'selected': false},
    {'english': 'steal', 'japanese': '盗む', 'POS': 'verb', 'selected': false},
    {'english': 'protest', 'japanese': '抗議', 'POS': 'noun', 'selected': false},
    {'english': 'index', 'japanese': '索引', 'POS': 'noun', 'selected': false},
    {
      'english': 'sad',
      'japanese': '悲しい',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'frequently',
      'japanese': '頻繁に',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'circle', 'japanese': '丸い', 'POS': 'noun', 'selected': false},
    {
      'english': 'helpful',
      'japanese': '役立つ',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'command',
      'japanese': '命令する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'attractive',
      'japanese': '魅力的な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'sick',
      'japanese': '病気',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'impression',
      'japanese': '印象',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'unable',
      'japanese': 'できない',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'joke', 'japanese': '冗談', 'POS': 'noun', 'selected': false},
    {'english': 'sky', 'japanese': '空', 'POS': 'noun', 'selected': false},
    {'english': 'column', 'japanese': '欄', 'POS': 'noun', 'selected': false},
    {
      'english': 'electronic',
      'japanese': '電子の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'impose', 'japanese': '課す', 'POS': 'verb', 'selected': false},
    {
      'english': 'criminal',
      'japanese': '犯罪者、犯罪の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'besides',
      'japanese': '～以外に、加えて、',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'properly',
      'japanese': '適切に',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'ancient',
      'japanese': '古代な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'coast', 'japanese': '海岸', 'POS': 'noun', 'selected': false},
    {'english': 'ill', 'japanese': '病気', 'POS': 'adjective', 'selected': false},
    {'english': 'kick', 'japanese': '蹴る', 'POS': 'verb', 'selected': false},
    {
      'english': 'closely',
      'japanese': 'じっくりと、注意深く',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'multiple',
      'japanese': '複合的な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'yield', 'japanese': '産出する', 'POS': 'verb', 'selected': false},
    {
      'english': 'via',
      'japanese': '経由で',
      'POS': 'preposition',
      'selected': false
    },
    {
      'english': 'legislation',
      'japanese': '法律',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'county', 'japanese': '州', 'POS': 'noun', 'selected': false},
    {
      'english': 'unlike',
      'japanese': '～とは違って',
      'POS': 'preposition',
      'selected': false
    },
    {
      'english': 'mobile',
      'japanese': '可動の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'assistant',
      'japanese': '助手、補佐',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'implement',
      'japanese': '実施する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'chart', 'japanese': 'チャート', 'POS': 'noun', 'selected': false},
    {'english': 'attach', 'japanese': '付随する', 'POS': 'verb', 'selected': false},
    {'english': 'hell', 'japanese': '地獄', 'POS': 'noun', 'selected': false},
    {
      'english': 'everywhere',
      'japanese': 'どこでも',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'advise',
      'japanese': 'アドバイスする',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'household',
      'japanese': '世帯',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'acknowledge',
      'japanese': '認める',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'reward', 'japanese': '報酬', 'POS': 'noun', 'selected': false},
    {'english': 'east', 'japanese': '東', 'POS': 'noun', 'selected': false},
    {'english': 'hat', 'japanese': '帽子', 'POS': 'noun', 'selected': false},
    {
      'english': 'academic',
      'japanese': '学問的な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'voter', 'japanese': '有権者', 'POS': 'noun', 'selected': false},
    {
      'english': 'meanwhile',
      'japanese': 'その間に',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'furthermore',
      'japanese': 'さらに',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'accuse', 'japanese': '責める', 'POS': 'verb', 'selected': false},
    {
      'english': 'scientific',
      'japanese': '科学の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'wage', 'japanese': '賃金', 'POS': 'noun', 'selected': false},
    {'english': 'absence', 'japanese': '欠如', 'POS': 'noun', 'selected': false},
    {
      'english': 'construct',
      'japanese': '建築する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'remark', 'japanese': '発言', 'POS': 'noun', 'selected': false},
    {'english': 'medicine', 'japanese': '薬', 'POS': 'noun', 'selected': false},
    {
      'english': 'professor',
      'japanese': '教授',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'rare',
      'japanese': '珍しい、まれな',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'intention',
      'japanese': '意図',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'dozen', 'japanese': 'ダース', 'POS': 'noun', 'selected': false},
    {
      'english': 'settlement',
      'japanese': '和解',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'gap', 'japanese': '差', 'POS': 'noun', 'selected': false},
    {'english': 'widely', 'japanese': '広く', 'POS': 'adverb', 'selected': false},
    {
      'english': 'minimum',
      'japanese': '最小限',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'northern',
      'japanese': '北の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'estate', 'japanese': '私有地', 'POS': 'noun', 'selected': false},
    {
      'english': 'equally',
      'japanese': '等しく',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'expose', 'japanese': 'さらす', 'POS': 'verb', 'selected': false},
    {
      'english': 'alive',
      'japanese': '生きている',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'shut', 'japanese': '閉める', 'POS': 'verb', 'selected': false},
    {'english': 'victory', 'japanese': '勝利', 'POS': 'noun', 'selected': false},
    {
      'english': 'resolve',
      'japanese': '解決する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'critic', 'japanese': '批評家', 'POS': 'noun', 'selected': false},
    {
      'english': 'variable',
      'japanese': '変わりやすい',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'enormous',
      'japanese': '巨大な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'sweet',
      'japanese': '甘い',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'permanent',
      'japanese': '永久的な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'emotion', 'japanese': '感情', 'POS': 'noun', 'selected': false},
    {'english': 'pursue', 'japanese': '追求する', 'POS': 'verb', 'selected': false},
    {
      'english': 'tall',
      'japanese': '高い',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'urge', 'japanese': '駆り立てる', 'POS': 'verb', 'selected': false},
    {'english': 'enemy', 'japanese': '敵', 'POS': 'noun', 'selected': false},
    {
      'english': 'appoint',
      'japanese': '任命する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'milk', 'japanese': '牛乳,ミルク', 'POS': 'noun', 'selected': false},
    {'english': 'talent', 'japanese': '才能', 'POS': 'noun', 'selected': false},
    {'english': 'smell', 'japanese': 'におい', 'POS': 'noun', 'selected': false},
    {
      'english': 'prior',
      'japanese': '前の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'priority', 'japanese': '優先', 'POS': 'noun', 'selected': false},
    {
      'english': 'online',
      'japanese': 'オンライン',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'phrase', 'japanese': 'フレーズ', 'POS': 'noun', 'selected': false},
    {'english': 'pilot', 'japanese': 'パイロット', 'POS': 'noun', 'selected': false},
    {
      'english': 'stable',
      'japanese': '安定した',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'merely',
      'japanese': '～にすぎない',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'resolution',
      'japanese': '決議',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'communicate',
      'japanese': 'やりとりする',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'injury', 'japanese': 'けが', 'POS': 'noun', 'selected': false},
    {
      'english': 'vast',
      'japanese': '広大',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'exhibition',
      'japanese': '展示会',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'producer',
      'japanese': '生産者',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'regional',
      'japanese': '地域の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'immediate',
      'japanese': '即時の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'incident', 'japanese': '事件', 'POS': 'noun', 'selected': false},
    {
      'english': 'childhood',
      'japanese': '子どもの頃',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'draft',
      'japanese': '原稿、原案、下絵',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'slip', 'japanese': '滑り落ちる', 'POS': 'verb', 'selected': false},
    {
      'english': 'accompany',
      'japanese': '同行する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'politician',
      'japanese': '政治家',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'angry',
      'japanese': '怒る',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'knock', 'japanese': 'ノックする', 'POS': 'verb', 'selected': false},
    {'english': 'seed', 'japanese': '種', 'POS': 'noun', 'selected': false},
    {'english': 'salary', 'japanese': '給料', 'POS': 'noun', 'selected': false},
    {
      'english': 'illustrate',
      'japanese': '解説する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'imply', 'japanese': '暗示する', 'POS': 'verb', 'selected': false},
    {
      'english': 'breakfast',
      'japanese': '朝食',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'temporary',
      'japanese': '一時的な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'liberal',
      'japanese': '自由主義の、リベラルな',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'lake', 'japanese': '湖', 'POS': 'noun', 'selected': false},
    {
      'english': 'qualify',
      'japanese': '資格を与える',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'competitive',
      'japanese': '競争心の強い',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'truly', 'japanese': '本当に', 'POS': 'adverb', 'selected': false},
    {
      'english': 'hi',
      'japanese': 'こんちゃ',
      'POS': 'interjection',
      'selected': false
    },
    {
      'english': 'yellow',
      'japanese': '黄色',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'habit', 'japanese': '癖、習慣', 'POS': 'noun', 'selected': false},
    {'english': 'disk', 'japanese': 'ディスク', 'POS': 'noun', 'selected': false},
    {'english': 'core', 'japanese': '核', 'POS': 'noun', 'selected': false},
    {
      'english': 'emotional',
      'japanese': '感情的な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'aircraft',
      'japanese': '飛行機',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'self', 'japanese': '自身、自我', 'POS': 'noun', 'selected': false},
    {'english': 'metal', 'japanese': '金属', 'POS': 'noun', 'selected': false},
    {
      'english': 'existence',
      'japanese': '存在',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'bone', 'japanese': '骨', 'POS': 'noun', 'selected': false},
    {'english': 'panel', 'japanese': 'パネル', 'POS': 'noun', 'selected': false},
    {
      'english': 'prime',
      'japanese': '主要な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'appointment',
      'japanese': '予約',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'emphasize',
      'japanese': '強調する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'maximum',
      'japanese': '最大限',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'effectively',
      'japanese': '効率的な',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'elsewhere',
      'japanese': '他の所で',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'bother', 'japanese': '悩ます', 'POS': 'verb', 'selected': false},
    {
      'english': 'initiative',
      'japanese': '取り組み',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'sharp',
      'japanese': '鋭い',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'diet',
      'japanese': '食事、ダイエット',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'motion', 'japanese': '動き', 'POS': 'noun', 'selected': false},
    {'english': 'gray', 'japanese': '灰色', 'POS': 'noun', 'selected': false},
    {
      'english': 'plastic',
      'japanese': 'プラスチック',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'complicate',
      'japanese': '複雑にする',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'discipline',
      'japanese': '訓練、しつけ、折檻',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'disappoint',
      'japanese': 'がっかりさせる',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'boss', 'japanese': '社長', 'POS': 'noun', 'selected': false},
    {
      'english': 'assumption',
      'japanese': '思い込み',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'freeze', 'japanese': '凍る', 'POS': 'verb', 'selected': false},
    {
      'english': 'extreme',
      'japanese': '極度の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'passage', 'japanese': '通路', 'POS': 'noun', 'selected': false},
    {
      'english': 'reputation',
      'japanese': '評判',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'forth', 'japanese': '前へ', 'POS': 'adverb', 'selected': false},
    {
      'english': 'negotiation',
      'japanese': '交渉',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'mechanism',
      'japanese': 'メカニズム',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'coat', 'japanese': 'コート', 'POS': 'noun', 'selected': false},
    {
      'english': 'democracy',
      'japanese': '民主主義',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'pocket', 'japanese': 'ポケット', 'POS': 'noun', 'selected': false},
    {
      'english': 'lucky',
      'japanese': '幸運な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'crash', 'japanese': '衝突する', 'POS': 'verb', 'selected': false},
    {
      'english': 'observation',
      'japanese': '観察',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'meat', 'japanese': '肉', 'POS': 'noun', 'selected': false},
    {
      'english': 'concentration',
      'japanese': '集中力',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'implication',
      'japanese': '暗示、影響',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'deserve',
      'japanese': '～にふさわしい',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'unusual',
      'japanese': '珍しい',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'defend', 'japanese': '防御する', 'POS': 'verb', 'selected': false},
    {
      'english': 'classic',
      'japanese': 'クラシック、古典',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'king', 'japanese': '王様', 'POS': 'noun', 'selected': false},
    {
      'english': 'interaction',
      'japanese': '交流',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'repair', 'japanese': '修理する', 'POS': 'verb', 'selected': false},
    {
      'english': 'collapse',
      'japanese': '倒壊する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'borrow', 'japanese': '借りる', 'POS': 'verb', 'selected': false},
    {
      'english': 'fundamental',
      'japanese': '基本',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'dish', 'japanese': '皿', 'POS': 'noun', 'selected': false},
    {'english': 'abroad', 'japanese': '外国', 'POS': 'adverb', 'selected': false},
    {'english': 'soul', 'japanese': '魂', 'POS': 'noun', 'selected': false},
    {
      'english': 'capable',
      'japanese': '～する能力がある',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'defeat', 'japanese': '負かす', 'POS': 'noun', 'selected': false},
    {
      'english': 'presidential',
      'japanese': '大統領の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'perfectly',
      'japanese': '完全に',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'enhance',
      'japanese': '向上させる',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'proud',
      'japanese': '誇りに思う',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'emergency',
      'japanese': '緊急',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'educational',
      'japanese': '教育的な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'distinguish',
      'japanese': '見分ける',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'substantial',
      'japanese': 'かなりの',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'nearby',
      'japanese': '近くの',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'manufacturer',
      'japanese': '製造業者',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'slide', 'japanese': '滑る', 'POS': 'verb', 'selected': false},
    {
      'english': 'valuable',
      'japanese': '価値のある',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'personally',
      'japanese': '個人的に',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'breast', 'japanese': '乳房', 'POS': 'noun', 'selected': false},
    {'english': 'cope', 'japanese': '対処する', 'POS': 'verb', 'selected': false},
    {
      'english': 'approximately',
      'japanese': 'およそ',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'accommodation',
      'japanese': '宿泊施設',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'highlight',
      'japanese': 'ハイライト、ヤマ場',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'reporter',
      'japanese': 'レポーター',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'climate', 'japanese': '気候', 'POS': 'noun', 'selected': false},
    {'english': 'shirt', 'japanese': 'シャツ', 'POS': 'noun', 'selected': false},
    {
      'english': 'exception',
      'japanese': '例外',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'corporation',
      'japanese': '企業',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'chip',
      'japanese': 'ポテトチップ、チップ',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'winner', 'japanese': '勝者', 'POS': 'noun', 'selected': false},
    {
      'english': 'encounter',
      'japanese': '出会う',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'brown',
      'japanese': '茶色',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'breathe',
      'japanese': '息をする',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'excuse', 'japanese': '許す', 'POS': 'verb', 'selected': false},
    {
      'english': 'partly',
      'japanese': '部分的に',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'tennis', 'japanese': 'テニス', 'POS': 'noun', 'selected': false},
    {
      'english': 'urban',
      'japanese': '都会の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'confuse',
      'japanese': '混乱させる',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'southern',
      'japanese': '南の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'output', 'japanese': '生産高', 'POS': 'noun', 'selected': false},
    {'english': 'beauty', 'japanese': '美', 'POS': 'noun', 'selected': false},
    {
      'english': 'massive',
      'japanese': '巨大な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'install',
      'japanese': 'インストール、設置する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'calculate',
      'japanese': '計算する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'mouse', 'japanese': '鼠', 'POS': 'noun', 'selected': false},
    {
      'english': 'mathematics',
      'japanese': '数学',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'upper',
      'japanese': '上の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'creation',
      'japanese': '創作、作品',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'occupy', 'japanese': '占める', 'POS': 'verb', 'selected': false},
    {'english': 'outline', 'japanese': '概要', 'POS': 'noun', 'selected': false},
    {
      'english': 'sufficient',
      'japanese': '十分な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'update', 'japanese': '更新する', 'POS': 'verb', 'selected': false},
    {'english': 'luck', 'japanese': '運', 'POS': 'noun', 'selected': false},
    {
      'english': 'preserve',
      'japanese': '保存する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'split', 'japanese': '分ける', 'POS': 'verb', 'selected': false},
    {'english': 'swing', 'japanese': '揺れる', 'POS': 'verb', 'selected': false},
    {'english': 'illness', 'japanese': '病気', 'POS': 'noun', 'selected': false},
    {
      'english': 'journalist',
      'japanese': 'ジャーナリスト',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'sudden',
      'japanese': '突然',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'advertisement',
      'japanese': '広告',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'consistent',
      'japanese': '一貫した',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'originally',
      'japanese': 'もともと',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'aside', 'japanese': 'わきへ', 'POS': 'adverb', 'selected': false},
    {
      'english': 'comfort',
      'japanese': '心地よい',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'secondly',
      'japanese': '第二に',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'severe',
      'japanese': '深刻',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'gene', 'japanese': '遺伝子', 'POS': 'noun', 'selected': false},
    {
      'english': 'prospect',
      'japanese': '見込み',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'snow', 'japanese': 'ゆき', 'POS': 'noun', 'selected': false},
    {'english': 'plot', 'japanese': '構想、陰謀', 'POS': 'noun', 'selected': false},
    {'english': 'neck', 'japanese': '首', 'POS': 'noun', 'selected': false},
    {
      'english': 'criterion',
      'japanese': '判断基準',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'primarily',
      'japanese': '主に',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'integrate',
      'japanese': 'まとめる',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'criticism',
      'japanese': '批評',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'convention',
      'japanese': '会議、大会',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'bet', 'japanese': '賭ける', 'POS': 'verb', 'selected': false},
    {'english': 'retain', 'japanese': '維持する', 'POS': 'verb', 'selected': false},
    {'english': 'sequence', 'japanese': '順序', 'POS': 'noun', 'selected': false},
    {
      'english': 'plain',
      'japanese': '無地の、平易な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'volunteer',
      'japanese': 'ボランティア',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'rural',
      'japanese': '田舎の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'calm',
      'japanese': '落ち着いた',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'abandon',
      'japanese': '断念する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'examination',
      'japanese': '試験、検査',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'silence', 'japanese': '静けさ', 'POS': 'noun', 'selected': false},
    {
      'english': 'rapidly',
      'japanese': '急速に',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'efficient',
      'japanese': '有能な、敏腕な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'revolution',
      'japanese': '革命',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'delight', 'japanese': '歓喜', 'POS': 'noun', 'selected': false},
    {'english': 'spell', 'japanese': 'つづる', 'POS': 'verb', 'selected': false},
    {'english': 'premise', 'japanese': '前提', 'POS': 'noun', 'selected': false},
    {'english': 'lean', 'japanese': '傾く', 'POS': 'verb', 'selected': false},
    {
      'english': 'dramatic',
      'japanese': '劇的な、ドラマチックな',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'differ', 'japanese': '異なる', 'POS': 'verb', 'selected': false},
    {
      'english': 'grateful',
      'japanese': '感謝する',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'protein',
      'japanese': 'タンパク質',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'bike',
      'japanese': 'バイク、自転車',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'distribute',
      'japanese': '配る',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'intellectual',
      'japanese': '知性の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'derive', 'japanese': '得る', 'POS': 'verb', 'selected': false},
    {
      'english': 'crucial',
      'japanese': '極めて重要な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'unemployment',
      'japanese': '失業',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'wheel', 'japanese': 'タイヤ', 'POS': 'noun', 'selected': false},
    {'english': 'crop', 'japanese': '農作物', 'POS': 'noun', 'selected': false},
    {
      'english': 'minority',
      'japanese': '少数派',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'origin', 'japanese': '起源', 'POS': 'noun', 'selected': false},
    {
      'english': 'interpretation',
      'japanese': '解説',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'gentleman',
      'japanese': '紳士',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'drama', 'japanese': 'ドラマ', 'POS': 'noun', 'selected': false},
    {
      'english': 'landscape',
      'japanese': '地形',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'educate',
      'japanese': '教育する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'toy', 'japanese': 'おもちゃ', 'POS': 'noun', 'selected': false},
    {'english': 'fault', 'japanese': '責任', 'POS': 'noun', 'selected': false},
    {
      'english': 'exhibit',
      'japanese': '展示する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'minor',
      'japanese': '小さな、ささいな',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'hunt', 'japanese': '狩る', 'POS': 'verb', 'selected': false},
    {'english': 'storm', 'japanese': '嵐', 'POS': 'noun', 'selected': false},
    {
      'english': 'thick',
      'japanese': '厚い',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'achievement',
      'japanese': '達成',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'negotiate',
      'japanese': '交渉する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'dominate',
      'japanese': '支配する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'supplier',
      'japanese': '供給者',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'prize', 'japanese': '賞', 'POS': 'noun', 'selected': false},
    {
      'english': 'typically',
      'japanese': '典型的に',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'peer', 'japanese': '同級生、同僚', 'POS': 'noun', 'selected': false},
    {'english': 'pension', 'japanese': '年金', 'POS': 'noun', 'selected': false},
    {'english': 'wing', 'japanese': '羽', 'POS': 'noun', 'selected': false},
    {
      'english': 'acquisition',
      'japanese': '取得、獲得',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'laughter', 'japanese': '笑い', 'POS': 'noun', 'selected': false},
    {'english': 'deeply', 'japanese': '深く', 'POS': 'adverb', 'selected': false},
    {
      'english': 'recognition',
      'japanese': '認識',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'electricity',
      'japanese': '電気',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'assistance',
      'japanese': '援助',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'roof', 'japanese': '屋根', 'POS': 'noun', 'selected': false},
    {
      'english': 'retirement',
      'japanese': '引退',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'respectively',
      'japanese': 'それぞれ',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'variation',
      'japanese': '差異',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'ultimately',
      'japanese': '最終的に',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'proof', 'japanese': '誇り', 'POS': 'noun', 'selected': false},
    {'english': 'soil', 'japanese': '土', 'POS': 'noun', 'selected': false},
    {
      'english': 'smart',
      'japanese': '賢い',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'layer', 'japanese': '層', 'POS': 'noun', 'selected': false},
    {
      'english': 'upset',
      'japanese': '取り乱す',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'tooth', 'japanese': '歯', 'POS': 'noun', 'selected': false},
    {
      'english': 'representation',
      'japanese': '代表',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'preparation',
      'japanese': '準備',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'dispute', 'japanese': '論争', 'POS': 'noun', 'selected': false},
    {
      'english': 'agenda',
      'japanese': 'するべきこと',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'emphasis', 'japanese': '強調', 'POS': 'noun', 'selected': false},
    {'english': 'edition', 'japanese': '版', 'POS': 'noun', 'selected': false},
    {'english': 'silver', 'japanese': '銀', 'POS': 'noun', 'selected': false},
    {
      'english': 'entertainment',
      'japanese': '娯楽',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'honest',
      'japanese': '正直な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'undertake',
      'japanese': '着手する、取り組む',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'retail',
      'japanese': '小売り',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'wire', 'japanese': 'ワイヤー', 'POS': 'noun', 'selected': false},
    {
      'english': 'unlikely',
      'japanese': 'なさそうな',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'gay',
      'japanese': '同性愛者',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'publication',
      'japanese': '出版',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'slight',
      'japanese': 'わずかな',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'unknown',
      'japanese': '未知の、無名の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'framework',
      'japanese': '枠組み',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'zone', 'japanese': '地帯', 'POS': 'noun', 'selected': false},
    {
      'english': 'restrict',
      'japanese': '制限する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'trace', 'japanese': '突き止める', 'POS': 'verb', 'selected': false},
    {'english': 'inch', 'japanese': 'インチ', 'POS': 'noun', 'selected': false},
    {
      'english': 'equivalent',
      'japanese': '同等の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'solid',
      'japanese': '固体',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'enterprise',
      'japanese': '企業',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'elderly',
      'japanese': '高齢者',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'owe',
      'japanese': '支払う義務がある、借りがある',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'governor', 'japanese': '知事', 'POS': 'noun', 'selected': false},
    {
      'english': 'uniform',
      'japanese': 'ユニフォーム',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'port', 'japanese': '港', 'POS': 'noun', 'selected': false},
    {
      'english': 'pitch',
      'japanese': '投げる、売り込む',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'arrival', 'japanese': '到着', 'POS': 'noun', 'selected': false},
    {
      'english': 'contemporary',
      'japanese': '現代の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'gate', 'japanese': '門', 'POS': 'noun', 'selected': false},
    {
      'english': 'ease',
      'japanese': '緩和、楽であること',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'beer', 'japanese': 'ビール', 'POS': 'noun', 'selected': false},
    {
      'english': 'specialist',
      'japanese': '専門家',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'assure', 'japanese': '保証する', 'POS': 'verb', 'selected': false},
    {
      'english': 'profile',
      'japanese': 'プロフィール',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'mood', 'japanese': '気分', 'POS': 'noun', 'selected': false},
    {
      'english': 'episode',
      'japanese': 'エピソード',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'crack', 'japanese': 'ひびが入る', 'POS': 'verb', 'selected': false},
    {
      'english': 'numerous',
      'japanese': '夥しい数の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'submit', 'japanese': '提出する', 'POS': 'verb', 'selected': false},
    {'english': 'symptom', 'japanese': '症状', 'POS': 'noun', 'selected': false},
    {
      'english': 'virtually',
      'japanese': '実質的に',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'era', 'japanese': '時代', 'POS': 'noun', 'selected': false},
    {'english': 'coverage', 'japanese': '報道', 'POS': 'noun', 'selected': false},
    {'english': 'tension', 'japanese': '緊張', 'POS': 'noun', 'selected': false},
    {'english': 'cable', 'japanese': 'ケーブル', 'POS': 'noun', 'selected': false},
    {
      'english': 'sensitive',
      'japanese': '繊細な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'nervous',
      'japanese': '緊張する',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'input',
      'japanese': '情報などを入れる',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'isolate',
      'japanese': '隔離する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'prisoner', 'japanese': '囚人', 'POS': 'noun', 'selected': false},
    {
      'english': 'eliminate',
      'japanese': '取り除く',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'tight',
      'japanese': 'きつい',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'wet',
      'japanese': '濡れた',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'secondary',
      'japanese': '第2の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'welfare', 'japanese': '福祉', 'POS': 'noun', 'selected': false},
    {
      'english': 'recruit',
      'japanese': '新規採用する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'exclude',
      'japanese': '排除する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'string', 'japanese': '紐', 'POS': 'noun', 'selected': false},
    {'english': 'cloud', 'japanese': '雲', 'POS': 'noun', 'selected': false},
    {
      'english': 'persuade',
      'japanese': '説得する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'inspire',
      'japanese': '鼓舞する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'grand',
      'japanese': '壮大な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'hence',
      'japanese': '今から、この先',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'crew', 'japanese': '乗員', 'POS': 'noun', 'selected': false},
    {
      'english': 'phenomenon',
      'japanese': '現象',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'pupil', 'japanese': '生徒', 'POS': 'noun', 'selected': false},
    {
      'english': 'false',
      'japanese': '偽の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'assist', 'japanese': '支援する', 'POS': 'verb', 'selected': false},
    {
      'english': 'restore',
      'japanese': '修復する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'formula', 'japanese': '公式', 'POS': 'noun', 'selected': false},
    {'english': 'alter', 'japanese': '変える', 'POS': 'verb', 'selected': false},
    {
      'english': 'perceive',
      'japanese': '気づく',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'routine',
      'japanese': '毎日の決まった仕事',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'sink', 'japanese': '沈む', 'POS': 'verb', 'selected': false},
    {'english': 'stare', 'japanese': '見つめる', 'POS': 'verb', 'selected': false},
    {
      'english': 'anymore',
      'japanese': 'これ以上～ない',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'hero', 'japanese': 'ヒーロー', 'POS': 'noun', 'selected': false},
    {
      'english': 'supporter',
      'japanese': '支持者',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'convert',
      'japanese': '変換する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'steady',
      'japanese': '固定した、安定した',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'meter', 'japanese': 'メーター', 'POS': 'noun', 'selected': false},
    {'english': 'truck', 'japanese': 'トラック', 'POS': 'noun', 'selected': false},
    {'english': 'nose', 'japanese': '鼻', 'POS': 'noun', 'selected': false},
    {
      'english': 'beside',
      'japanese': '隣の、近くの',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'sail', 'japanese': '航海する', 'POS': 'verb', 'selected': false},
    {'english': 'disaster', 'japanese': '災害', 'POS': 'noun', 'selected': false},
    {'english': 'pace', 'japanese': 'ペース', 'POS': 'noun', 'selected': false},
    {
      'english': 'heavily',
      'japanese': '激しく',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'devote',
      'japanese': 'ささげる、充てる',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'terrorist',
      'japanese': 'テロリスト',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'justify',
      'japanese': '正当だと理由づける',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'vital',
      'japanese': '必要不可欠な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'fascinate',
      'japanese': '魅了する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'external',
      'japanese': '外部',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'spare',
      'japanese': '予備、スペア',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'whenever',
      'japanese': 'いつでも',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'depression',
      'japanese': '落ち込み、鬱病',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'guilty',
      'japanese': '有罪な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'underlie',
      'japanese': '下に横たわる',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'mom', 'japanese': 'まま', 'POS': 'noun', 'selected': false},
    {
      'english': 'distinction',
      'japanese': '違い',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'satisfaction',
      'japanese': '満足',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'incorporate',
      'japanese': '組み込む',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'pour', 'japanese': '注ぐ', 'POS': 'verb', 'selected': false},
    {'english': 'sweep', 'japanese': '掃く', 'POS': 'verb', 'selected': false},
    {
      'english': 'obligation',
      'japanese': '義務',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'sir',
      'japanese': '（男性への丁寧な呼び掛け）旦那様、お客様',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'evaluate',
      'japanese': '評価する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'anger', 'japanese': '怒り', 'POS': 'noun', 'selected': false},
    {'english': 'pub', 'japanese': 'パブ', 'POS': 'noun', 'selected': false},
    {
      'english': 'perception',
      'japanese': '見識',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'naturally',
      'japanese': '自然に',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'currency', 'japanese': '通貨', 'POS': 'noun', 'selected': false},
    {
      'english': 'database',
      'japanese': 'データベース',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'initially',
      'japanese': '初めは',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'territory',
      'japanese': '領土',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'stream', 'japanese': '小川', 'POS': 'noun', 'selected': false},
    {
      'english': 'rarely',
      'japanese': 'ほとんどない',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'height', 'japanese': '身長', 'POS': 'noun', 'selected': false},
    {
      'english': 'apparent',
      'japanese': '明らかな',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'western',
      'japanese': '西部の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'expansion',
      'japanese': '拡大',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'constantly',
      'japanese': '常に',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'muscle', 'japanese': '筋肉', 'POS': 'noun', 'selected': false},
    {'english': 'scare', 'japanese': '怖がらせる', 'POS': 'verb', 'selected': false},
    {'english': 'badly', 'japanese': 'ひどく', 'POS': 'adverb', 'selected': false},
    {
      'english': 'everyday',
      'japanese': '普段の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'boundary', 'japanese': '境界', 'POS': 'noun', 'selected': false},
    {'english': 'ratio', 'japanese': '比率', 'POS': 'noun', 'selected': false},
    {'english': 'essay', 'japanese': 'エッセイ', 'POS': 'noun', 'selected': false},
    {'english': 'scream', 'japanese': '絶叫する', 'POS': 'verb', 'selected': false},
    {
      'english': 'withdraw',
      'japanese': 'お金を引き出す、身を引く',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'pollution',
      'japanese': '汚染',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'disorder',
      'japanese': '疾患、騒動',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'furniture',
      'japanese': '家具',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'symbol', 'japanese': '象徴', 'POS': 'noun', 'selected': false},
    {
      'english': 'apartment',
      'japanese': 'アパート',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'demonstration',
      'japanese': 'デモ、実演',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'analyst',
      'japanese': 'アナリスト',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'platform',
      'japanese': '演壇、プラットホーム',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'steel', 'japanese': '鋼', 'POS': 'noun', 'selected': false},
    {'english': 'cake', 'japanese': 'ケーキ', 'POS': 'noun', 'selected': false},
    {
      'english': 'transform',
      'japanese': '変形する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'wound', 'japanese': '傷', 'POS': 'noun', 'selected': false},
    {
      'english': 'restriction',
      'japanese': '制限',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'foundation',
      'japanese': '設立',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'designer',
      'japanese': 'デザイナー、設計者',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'strain',
      'japanese': '緊張、体の一部を痛めること',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'innovation',
      'japanese': '革新',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'album', 'japanese': 'アルバム', 'POS': 'noun', 'selected': false},
    {'english': 'singer', 'japanese': '歌手', 'POS': 'noun', 'selected': false},
    {'english': 'trail', 'japanese': '小道', 'POS': 'noun', 'selected': false},
    {'english': 'trap', 'japanese': '罠、仕掛け', 'POS': 'noun', 'selected': false},
    {
      'english': 'loose',
      'japanese': '緩い',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'extension',
      'japanese': '拡張',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'wealth', 'japanese': '裕福', 'POS': 'noun', 'selected': false},
    {
      'english': 'gradually',
      'japanese': 'しだいに',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'tank', 'japanese': 'タンク', 'POS': 'noun', 'selected': false},
    {
      'english': 'evil',
      'japanese': '邪悪な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'remarkable',
      'japanese': '注目すべき',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'tune', 'japanese': '旋律', 'POS': 'noun', 'selected': false},
    {'english': 'grass', 'japanese': '草', 'POS': 'noun', 'selected': false},
    {
      'english': 'invitation',
      'japanese': '招待',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'transition',
      'japanese': '推移',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'frighten',
      'japanese': '怖がらせる',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'bid', 'japanese': '努力、入札', 'POS': 'noun', 'selected': false},
    {
      'english': 'breed',
      'japanese': '（動物の）種類',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'extraordinary',
      'japanese': '並外れた',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'brilliant',
      'japanese': '素晴らしい',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'adviser',
      'japanese': 'アドバイザー',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'stem', 'japanese': '茎', 'POS': 'noun', 'selected': false},
    {
      'english': 'reverse',
      'japanese': '逆にする',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'mode', 'japanese': '方法', 'POS': 'noun', 'selected': false},
    {'english': 'mirror', 'japanese': '鏡', 'POS': 'noun', 'selected': false},
    {
      'english': 'awful',
      'japanese': 'ひどい',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'pose', 'japanese': 'ポーズをとる', 'POS': 'verb', 'selected': false},
    {'english': 'adjust', 'japanese': '調節する', 'POS': 'verb', 'selected': false},
    {
      'english': 'creative',
      'japanese': '創造力がある',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'nowadays',
      'japanese': '最近は',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'poem', 'japanese': '詩', 'POS': 'noun', 'selected': false},
    {
      'english': 'agricultural',
      'japanese': '農業の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'competitor',
      'japanese': '競争相手',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'alcohol',
      'japanese': 'アルコール',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'festival', 'japanese': '祭り', 'POS': 'noun', 'selected': false},
    {
      'english': 'vegetable',
      'japanese': '野菜',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'van', 'japanese': 'バン', 'POS': 'noun', 'selected': false},
    {
      'english': 'confident',
      'japanese': '自信',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'planet', 'japanese': '惑星', 'POS': 'noun', 'selected': false},
    {'english': 'curve', 'japanese': '曲線', 'POS': 'noun', 'selected': false},
    {'english': 'knee', 'japanese': '膝', 'POS': 'noun', 'selected': false},
    {
      'english': 'overcome',
      'japanese': '打ち勝つ',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'web', 'japanese': 'ウェブ', 'POS': 'noun', 'selected': false},
    {'english': 'depth', 'japanese': '深さ', 'POS': 'noun', 'selected': false},
    {'english': 'entrance', 'japanese': '入口', 'POS': 'noun', 'selected': false},
    {'english': 'log', 'japanese': '丸太', 'POS': 'noun', 'selected': false},
    {
      'english': 'giant',
      'japanese': '巨大な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'god', 'japanese': '神様', 'POS': 'noun', 'selected': false},
    {'english': 'portion', 'japanese': '部分', 'POS': 'noun', 'selected': false},
    {
      'english': 'substance',
      'japanese': '物質',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'extensive',
      'japanese': '広範な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'interpret',
      'japanese': '解釈する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'independence',
      'japanese': '独立',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'sugar', 'japanese': '砂糖', 'POS': 'noun', 'selected': false},
    {
      'english': 'inner',
      'japanese': '内部の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'harm', 'japanese': '害', 'POS': 'noun', 'selected': false},
    {
      'english': 'consult',
      'japanese': '相談する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'pink',
      'japanese': 'ピンク',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'shadow', 'japanese': '影', 'POS': 'noun', 'selected': false},
    {'english': 'strip', 'japanese': '脱ぐ', 'POS': 'verb', 'selected': false},
    {
      'english': 'smooth',
      'japanese': '滑らかな',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'intervention',
      'japanese': '介入',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'impress',
      'japanese': '好印象を与える',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'exam', 'japanese': '試験', 'POS': 'noun', 'selected': false},
    {'english': 'vice', 'japanese': '悪徳', 'POS': 'noun', 'selected': false},
    {
      'english': 'radical',
      'japanese': '過激な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'similarly',
      'japanese': '同様に',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'behave',
      'japanese': '行儀よくする',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'loud',
      'japanese': 'うるさい',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'dimension',
      'japanese': '寸法',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'subsequent',
      'japanese': 'その後の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'infection',
      'japanese': '感染症',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'jacket',
      'japanese': 'ジャケット',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'efficiency',
      'japanese': '効率',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'dirty',
      'japanese': '汚い',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'statistic',
      'japanese': '統計',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'regularly',
      'japanese': '定期的に',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'resort', 'japanese': 'リゾート', 'POS': 'noun', 'selected': false},
    {'english': 'iron', 'japanese': '鉄分、鉄', 'POS': 'noun', 'selected': false},
    {
      'english': 'broadcast',
      'japanese': '放送する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'membership',
      'japanese': '会員',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'bread', 'japanese': 'パン', 'POS': 'noun', 'selected': false},
    {
      'english': 'blind',
      'japanese': '盲目',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'pure',
      'japanese': '純粋な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'bloody',
      'japanese': '血まみれの',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'ally', 'japanese': '同盟', 'POS': 'noun', 'selected': false},
    {'english': 'quantity', 'japanese': '量', 'POS': 'noun', 'selected': false},
    {'english': 'bend', 'japanese': '曲げる', 'POS': 'verb', 'selected': false},
    {
      'english': 'mature',
      'japanese': '成長した・熟慮した',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'briefly',
      'japanese': 'ちょっとの間',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'alarm', 'japanese': 'アラーム', 'POS': 'noun', 'selected': false},
    {
      'english': 'disturb',
      'japanese': '邪魔をする',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'sustain',
      'japanese': '維持する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'flood', 'japanese': '洪水', 'POS': 'noun', 'selected': false},
    {'english': 'poverty', 'japanese': '貧困', 'POS': 'noun', 'selected': false},
    {
      'english': 'crazy',
      'japanese': '気が狂った',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'cite', 'japanese': '引用する', 'POS': 'verb', 'selected': false},
    {'english': 'newly', 'japanese': '新たに', 'POS': 'adverb', 'selected': false},
    {
      'english': 'parallel',
      'japanese': '類似した、同時に起きる',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'gender', 'japanese': '性別', 'POS': 'noun', 'selected': false},
    {
      'english': 'sponsor',
      'japanese': 'スポンサーを務める',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'boot', 'japanese': 'ブーツ', 'POS': 'noun', 'selected': false},
    {
      'english': 'accurate',
      'japanese': '正確',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'dealer', 'japanese': '販売業者', 'POS': 'noun', 'selected': false},
    {'english': 'button', 'japanese': 'ボタン', 'POS': 'noun', 'selected': false},
    {'english': 'burden', 'japanese': '負担', 'POS': 'noun', 'selected': false},
    {'english': 'desert', 'japanese': '砂漠', 'POS': 'noun', 'selected': false},
    {'english': 'mate', 'japanese': '仲間', 'POS': 'noun', 'selected': false},
    {
      'english': 'occasionally',
      'japanese': 'たまに',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'shareholder',
      'japanese': '株主',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'bowl', 'japanese': '丼', 'POS': 'noun', 'selected': false},
    {
      'english': 'discovery',
      'japanese': '発見',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'resistance',
      'japanese': '抵抗',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'bath', 'japanese': '入浴', 'POS': 'noun', 'selected': false},
    {
      'english': 'frequency',
      'japanese': '頻発',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'criticize',
      'japanese': '批判する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'tap', 'japanese': '軽くたたく', 'POS': 'noun', 'selected': false},
    {
      'english': 'philosophy',
      'japanese': '哲学',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'lip', 'japanese': '唇', 'POS': 'noun', 'selected': false},
    {
      'english': 'attribute',
      'japanese': '～のせいにする',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'apologize',
      'japanese': '謝る',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'approval', 'japanese': '承認', 'POS': 'noun', 'selected': false},
    {'english': 'grab', 'japanese': 'つかむ', 'POS': 'verb', 'selected': false},
    {
      'english': 'entitle',
      'japanese': '権利を与える',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'lend', 'japanese': '貸す', 'POS': 'verb', 'selected': false},
    {
      'english': 'involvement',
      'japanese': '関与',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'exposure',
      'japanese': '（社会などに）触れること',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'conventional',
      'japanese': '伝統的な、従来の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'digital',
      'japanese': 'デジタル',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'translate',
      'japanese': '翻訳する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'edit', 'japanese': '編集する', 'POS': 'verb', 'selected': false},
    {
      'english': 'formation',
      'japanese': '形成',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'deposit', 'japanese': '預金', 'POS': 'noun', 'selected': false},
    {
      'english': 'pleasant',
      'japanese': '心地良い、楽しい',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'overseas',
      'japanese': '海外',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'advocate',
      'japanese': '主張する',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'establishment',
      'japanese': '機関、設立',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'summary', 'japanese': '要約', 'POS': 'noun', 'selected': false},
    {
      'english': 'rough',
      'japanese': 'ざらざらした',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'pen', 'japanese': 'ペン', 'POS': 'noun', 'selected': false},
    {'english': 'recovery', 'japanese': '回復', 'POS': 'noun', 'selected': false},
    {
      'english': 'seal',
      'japanese': 'アシカ、アザラシ',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'tube', 'japanese': '筒', 'POS': 'noun', 'selected': false},
    {'english': 'tower', 'japanese': 'タワー', 'POS': 'noun', 'selected': false},
    {
      'english': 'characterize',
      'japanese': '特徴づける、描写する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'specify',
      'japanese': '明記する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'exact',
      'japanese': '正確な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'spin', 'japanese': '回転する', 'POS': 'verb', 'selected': false},
    {
      'english': 'operator',
      'japanese': 'オペレーター',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'infant', 'japanese': '幼児', 'POS': 'noun', 'selected': false},
    {'english': 'dig', 'japanese': '掘る', 'POS': 'verb', 'selected': false},
    {'english': 'drag', 'japanese': '引きずる', 'POS': 'verb', 'selected': false},
    {'english': 'mount', 'japanese': '上がる', 'POS': 'noun', 'selected': false},
    {'english': 'wrap', 'japanese': '包む', 'POS': 'verb', 'selected': false},
    {
      'english': 'anticipate',
      'japanese': '予測する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'dependent',
      'japanese': '依存している',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'specialize',
      'japanese': '専門とする',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'angle', 'japanese': '角', 'POS': 'noun', 'selected': false},
    {'english': 'chicken', 'japanese': '鶏肉', 'POS': 'noun', 'selected': false},
    {'english': 'anxiety', 'japanese': '不安', 'POS': 'noun', 'selected': false},
    {'english': 'virus', 'japanese': 'ウイルス', 'POS': 'noun', 'selected': false},
    {
      'english': 'precisely',
      'japanese': '正確に',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'rival', 'japanese': '好敵手', 'POS': 'noun', 'selected': false},
    {'english': 'offense', 'japanese': '犯行', 'POS': 'noun', 'selected': false},
    {'english': 'detect', 'japanese': '検出する', 'POS': 'verb', 'selected': false},
    {
      'english': 'teenager',
      'japanese': '１０代の',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'admire', 'japanese': '称賛する', 'POS': 'verb', 'selected': false},
    {
      'english': 'moderate',
      'japanese': '適度の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'surgery', 'japanese': '手術', 'POS': 'noun', 'selected': false},
    {
      'english': 'musician',
      'japanese': 'ミュージシャン',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'significance',
      'japanese': '意義、重要性',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'shower', 'japanese': 'シャワー', 'POS': 'noun', 'selected': false},
    {
      'english': 'illegal',
      'japanese': '非合法の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'charity', 'japanese': '慈善', 'POS': 'noun', 'selected': false},
    {
      'english': 'universal',
      'japanese': '普遍的な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'cigarette',
      'japanese': 'たばこ',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'constitute',
      'japanese': '構成する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'adequate',
      'japanese': '十分な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'consultant',
      'japanese': 'コンサルタント',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'historian',
      'japanese': '歴史家',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'cousin', 'japanese': 'いとこ', 'POS': 'noun', 'selected': false},
    {
      'english': 'visual',
      'japanese': '視覚',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'stupid',
      'japanese': '頭が悪い',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'keen',
      'japanese': '熱心な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'ethnic',
      'japanese': '民族',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'twin', 'japanese': '双子', 'POS': 'noun', 'selected': false},
    {
      'english': 'clinical',
      'japanese': '臨床の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'eastern',
      'japanese': '東部の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'forecast', 'japanese': '予測', 'POS': 'noun', 'selected': false},
    {'english': 'segment', 'japanese': '部分', 'POS': 'noun', 'selected': false},
    {'english': 'custom', 'japanese': '慣習', 'POS': 'noun', 'selected': false},
    {'english': 'adapt', 'japanese': '適応する', 'POS': 'verb', 'selected': false},
    {'english': 'sand', 'japanese': '砂', 'POS': 'noun', 'selected': false},
    {'english': 'cap', 'japanese': '帽子', 'POS': 'noun', 'selected': false},
    {
      'english': 'prompt',
      'japanese': '促す',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'charm', 'japanese': '魅力', 'POS': 'noun', 'selected': false},
    {'english': 'react', 'japanese': '反応する', 'POS': 'verb', 'selected': false},
    {'english': 'lecture', 'japanese': '講義', 'POS': 'noun', 'selected': false},
    {'english': 'venture', 'japanese': '冒険', 'POS': 'noun', 'selected': false},
    {
      'english': 'compound',
      'japanese': '調合する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'rescue', 'japanese': '救う', 'POS': 'verb', 'selected': false},
    {'english': 'mess', 'japanese': '乱雑、混乱', 'POS': 'noun', 'selected': false},
    {
      'english': 'preference',
      'japanese': '好み',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'comprehensive',
      'japanese': '包括的な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'incentive',
      'japanese': 'やる気、動機付け',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'league', 'japanese': 'リーグ', 'POS': 'noun', 'selected': false},
    {'english': 'dialog', 'japanese': '対話', 'POS': 'noun', 'selected': false},
    {'english': 'cream', 'japanese': 'クリーム', 'POS': 'noun', 'selected': false},
    {
      'english': 'rapid',
      'japanese': '急速に',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'cancel',
      'japanese': '中止、キャンセルする',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'regret',
      'japanese': '後悔する、残念に思う',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'dismiss',
      'japanese': '解雇する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'margin', 'japanese': '余白', 'POS': 'noun', 'selected': false},
    {
      'english': 'beneath',
      'japanese': '～の下で',
      'POS': 'preposition',
      'selected': false
    },
    {
      'english': 'opponent',
      'japanese': '対戦相手、反対者',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'resist', 'japanese': '抵抗する', 'POS': 'verb', 'selected': false},
    {
      'english': 'capability',
      'japanese': '能力',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'absolute',
      'japanese': '絶対的な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'correspond',
      'japanese': '相当する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'stroke', 'japanese': '脳卒中', 'POS': 'noun', 'selected': false},
    {'english': 'dare', 'japanese': '勇気がある', 'POS': 'verb', 'selected': false},
    {'english': 'barrier', 'japanese': '障害', 'POS': 'noun', 'selected': false},
    {'english': 'rid', 'japanese': '取り除く', 'POS': 'verb', 'selected': false},
    {
      'english': 'divorce',
      'japanese': '離婚する',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'ruin', 'japanese': '台無しにする', 'POS': 'verb', 'selected': false},
    {'english': 'bury', 'japanese': '埋葬する', 'POS': 'verb', 'selected': false},
    {
      'english': 'counsel',
      'japanese': '弁護士、助言',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'tendency', 'japanese': '傾向', 'POS': 'noun', 'selected': false},
    {
      'english': 'frequent',
      'japanese': '頻繁に',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'motor', 'japanese': 'モーター', 'POS': 'noun', 'selected': false},
    {
      'english': 'survival',
      'japanese': '生き残ること',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'counter',
      'japanese': '対抗する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'possess',
      'japanese': '所有する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'permission',
      'japanese': '許可',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'valley', 'japanese': '谷', 'POS': 'noun', 'selected': false},
    {'english': 'float', 'japanese': '浮く', 'POS': 'verb', 'selected': false},
    {
      'english': 'mad',
      'japanese': '怒り狂ってる',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'greatly',
      'japanese': '大いに',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'visible',
      'japanese': '目に見える',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'electric',
      'japanese': '電気の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'impressive',
      'japanese': '印象的な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'evolution',
      'japanese': '進化',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'awareness',
      'japanese': '意識',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'violent',
      'japanese': '暴力',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'slave', 'japanese': '奴隷', 'POS': 'noun', 'selected': false},
    {
      'english': 'wealthy',
      'japanese': '豊か',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'architecture',
      'japanese': '建築',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'acceptable',
      'japanese': '容認できる、受諾可能な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'journal', 'japanese': '日記', 'POS': 'noun', 'selected': false},
    {'english': 'coal', 'japanese': '石炭', 'POS': 'noun', 'selected': false},
    {
      'english': 'measurement',
      'japanese': '測定、寸法',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'random',
      'japanese': 'ランダムな',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'successfully',
      'japanese': 'うまく',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'depress',
      'japanese': '落ち込ませる',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'illustration',
      'japanese': 'イラスト、例',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'burst', 'japanese': '爆発', 'POS': 'verb', 'selected': false},
    {
      'english': 'privilege',
      'japanese': '特権',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'buyer', 'japanese': '買い手', 'POS': 'noun', 'selected': false},
    {
      'english': 'mutual',
      'japanese': '共有の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'rail',
      'japanese': '手すり、（電車の）レール',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'motivate',
      'japanese': 'やる気にさせる',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'laboratory',
      'japanese': '研究室',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'mortgage', 'japanese': '抵当', 'POS': 'noun', 'selected': false},
    {
      'english': 'promotion',
      'japanese': '促進、昇進',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'passion', 'japanese': '情熱', 'POS': 'noun', 'selected': false},
    {
      'english': 'champion',
      'japanese': 'チャンピオン',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'fulfill',
      'japanese': '遂行する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'dust', 'japanese': '埃', 'POS': 'noun', 'selected': false},
    {
      'english': 'dedicate',
      'japanese': '専念する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'roughly',
      'japanese': 'およそ',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'skirt', 'japanese': 'スカート', 'POS': 'noun', 'selected': false},
    {'english': 'province', 'japanese': '州', 'POS': 'noun', 'selected': false},
    {'english': 'march', 'japanese': '行進', 'POS': 'verb', 'selected': false},
    {
      'english': 'evaluation',
      'japanese': '評価',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'compromise',
      'japanese': '妥協する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'accomplish',
      'japanese': '成し遂げる',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'weakness', 'japanese': '弱点', 'POS': 'noun', 'selected': false},
    {
      'english': 'announcement',
      'japanese': '発表、告知',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'salt', 'japanese': '塩', 'POS': 'noun', 'selected': false},
    {
      'english': 'glance',
      'japanese': 'ちらりと見る',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'opera', 'japanese': '歌劇', 'POS': 'noun', 'selected': false},
    {
      'english': 'contest',
      'japanese': 'コンテスト',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'brush', 'japanese': '刷毛', 'POS': 'noun', 'selected': false},
    {
      'english': 'embarrass',
      'japanese': '恥をかかせる',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'gallery', 'japanese': '画廊', 'POS': 'noun', 'selected': false},
    {
      'english': 'genetic',
      'japanese': '遺伝的な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'aggressive',
      'japanese': '積極的',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'chest', 'japanese': '腰', 'POS': 'noun', 'selected': false},
    {
      'english': 'format',
      'japanese': '書式、形式',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'literary',
      'japanese': '文学の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'govern', 'japanese': '支配する', 'POS': 'verb', 'selected': false},
    {
      'english': 'embrace',
      'japanese': '抱き締める、受け入れる',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'praise', 'japanese': '称賛する', 'POS': 'verb', 'selected': false},
    {
      'english': 'silent',
      'japanese': '静かな',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'pump', 'japanese': 'ポンプ', 'POS': 'noun', 'selected': false},
    {
      'english': 'publisher',
      'japanese': '出版社',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'celebration',
      'japanese': 'お祝い',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'golf', 'japanese': 'ゴルフ', 'POS': 'noun', 'selected': false},
    {
      'english': 'compensation',
      'japanese': '賠償',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'classical',
      'japanese': '古典的な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'weigh', 'japanese': '量る', 'POS': 'verb', 'selected': false},
    {
      'english': 'versus',
      'japanese': '対',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'deficit', 'japanese': '赤字', 'POS': 'noun', 'selected': false},
    {'english': 'modify', 'japanese': '修正する', 'POS': 'verb', 'selected': false},
    {
      'english': 'flash',
      'japanese': 'ひらめき、閃光',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'friendship',
      'japanese': '友情',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'profession',
      'japanese': '専門',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'literally',
      'japanese': '文字通りに',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'equation',
      'japanese': '方程式',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'gesture',
      'japanese': 'ジェスチャー',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'entertain',
      'japanese': '楽しませる',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'fantastic',
      'japanese': 'すばらしい',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'assign',
      'japanese': '割り当てる',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'inflation',
      'japanese': 'インフレ',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'historic',
      'japanese': '歴史的な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'injure',
      'japanese': 'にけがをさせる',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'remote',
      'japanese': '遠隔',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'therapy', 'japanese': '治療', 'POS': 'noun', 'selected': false},
    {'english': 'orange', 'japanese': 'オレンジ', 'POS': 'noun', 'selected': false},
    {'english': 'twist', 'japanese': 'ひねる', 'POS': 'verb', 'selected': false},
    {
      'english': 'personnel',
      'japanese': '職員',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'imagination',
      'japanese': '想像',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'disagree',
      'japanese': '反対する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'throat', 'japanese': '喉', 'POS': 'noun', 'selected': false},
    {'english': 'insight', 'japanese': '洞察力', 'POS': 'noun', 'selected': false},
    {
      'english': 'tackle',
      'japanese': '取り組む、タックルする',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'forever',
      'japanese': '永遠に',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'exceed', 'japanese': '超える', 'POS': 'verb', 'selected': false},
    {
      'english': 'expenditure',
      'japanese': '出費',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'joy', 'japanese': '楽しさ', 'POS': 'noun', 'selected': false},
    {
      'english': 'pregnant',
      'japanese': '妊娠した',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'reliable',
      'japanese': '信頼できる',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'gear', 'japanese': 'ギア、衣服', 'POS': 'noun', 'selected': false},
    {'english': 'poet', 'japanese': '詩人', 'POS': 'noun', 'selected': false},
    {'english': 'fortune', 'japanese': '大金', 'POS': 'noun', 'selected': false},
    {'english': 'ceremony', 'japanese': '式典', 'POS': 'noun', 'selected': false},
    {
      'english': 'pile',
      'japanese': '山（積み重ね）',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'pig', 'japanese': '豚', 'POS': 'noun', 'selected': false},
    {'english': 'mixture', 'japanese': '混合物', 'POS': 'noun', 'selected': false},
    {
      'english': 'automatically',
      'japanese': '自動的に',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'scholar', 'japanese': '学者', 'POS': 'noun', 'selected': false},
    {
      'english': 'psychological',
      'japanese': '心理的な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'dramatically',
      'japanese': 'ドラマチックに、劇的に',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'stake',
      'japanese': '賭ける、出資金',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'creature',
      'japanese': '生き物',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'partnership',
      'japanese': '連携',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'participation',
      'japanese': '参加',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'clause', 'japanese': '主節', 'POS': 'noun', 'selected': false},
    {'english': 'penalty', 'japanese': '罪', 'POS': 'noun', 'selected': false},
    {'english': 'chamber', 'japanese': '部屋', 'POS': 'noun', 'selected': false},
    {
      'english': 'fancy',
      'japanese': '～したい気分だ',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'poetry', 'japanese': '詩', 'POS': 'noun', 'selected': false},
    {'english': 'chat', 'japanese': 'お喋り', 'POS': 'verb', 'selected': false},
    {'english': 'clothing', 'japanese': '衣類', 'POS': 'noun', 'selected': false},
    {'english': 'evolve', 'japanese': '進化する', 'POS': 'verb', 'selected': false},
    {
      'english': 'sake',
      'japanese': '利益、～のため',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'shelf', 'japanese': '棚', 'POS': 'noun', 'selected': false},
    {'english': 'boost', 'japanese': '後押し', 'POS': 'noun', 'selected': false},
    {'english': 'tail', 'japanese': 'しっぽ', 'POS': 'noun', 'selected': false},
    {
      'english': 'possession',
      'japanese': '所有物',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'abortion', 'japanese': '中絶', 'POS': 'noun', 'selected': false},
    {
      'english': 'curious',
      'japanese': '好奇心旺盛な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'wooden',
      'japanese': '木製の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'boom',
      'japanese': '好況、ブーンとなる音',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'tale',
      'japanese': '(事実・伝説・架空の）話、物語',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'democratic',
      'japanese': '民主主義の、民主的な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'maintenance',
      'japanese': '保守',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'consequently',
      'japanese': '結果的に',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'pot', 'japanese': 'ポット', 'POS': 'noun', 'selected': false},
    {'english': 'cow', 'japanese': '牛', 'POS': 'noun', 'selected': false},
    {
      'english': 'strengthen',
      'japanese': '強化する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'whilst',
      'japanese': 'の間に、一方で',
      'POS': 'conjunction',
      'selected': false
    },
    {
      'english': 'constraint',
      'japanese': '制約',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'fold', 'japanese': '折る', 'POS': 'noun', 'selected': false},
    {'english': 'bin', 'japanese': 'ごみ箱', 'POS': 'noun', 'selected': false},
    {
      'english': 'undergo',
      'japanese': '経験する、耐える、受ける',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'potentially',
      'japanese': '潜在的に',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'scope', 'japanese': '範囲、領域', 'POS': 'noun', 'selected': false},
    {
      'english': 'pretend',
      'japanese': 'ふりをする',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'diversity',
      'japanese': '多様性',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'allege',
      'japanese': '申し立てる',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'pride', 'japanese': '誇り', 'POS': 'noun', 'selected': false},
    {
      'english': 'intense',
      'japanese': '激しい',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'inquiry', 'japanese': '照会', 'POS': 'noun', 'selected': false},
    {'english': 'resign', 'japanese': '辞める', 'POS': 'verb', 'selected': false},
    {'english': 'craft', 'japanese': '工作', 'POS': 'noun', 'selected': false},
    {
      'english': 'strict',
      'japanese': '厳しい',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'concrete',
      'japanese': 'コンクリート',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'shell', 'japanese': '殻', 'POS': 'noun', 'selected': false},
    {
      'english': 'damn',
      'japanese': 'くそっ',
      'POS': 'interjection',
      'selected': false
    },
    {
      'english': 'distinct',
      'japanese': '区別できる',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'humor', 'japanese': 'ユーモア', 'POS': 'noun', 'selected': false},
    {
      'english': 'limitation',
      'japanese': '制限',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'indication',
      'japanese': '兆候、印',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'stability',
      'japanese': '安定性',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'wise',
      'japanese': '賢い',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'neglect', 'japanese': '怠る', 'POS': 'verb', 'selected': false},
    {
      'english': 'compose',
      'japanese': '構成する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'jail', 'japanese': '牢屋', 'POS': 'noun', 'selected': false},
    {'english': 'shelter', 'japanese': '避難所', 'POS': 'noun', 'selected': false},
    {
      'english': 'mere',
      'japanese': 'ほんの',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'carbon', 'japanese': '炭素', 'POS': 'noun', 'selected': false},
    {
      'english': 'regulate',
      'japanese': '調節する、規制する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'cheese', 'japanese': 'チーズ', 'POS': 'noun', 'selected': false},
    {'english': 'trigger', 'japanese': '引き金', 'POS': 'noun', 'selected': false},
    {'english': 'pipe', 'japanese': 'パイプ', 'POS': 'noun', 'selected': false},
    {
      'english': 'destruction',
      'japanese': '破壊',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'guitar', 'japanese': 'ギター', 'POS': 'noun', 'selected': false},
    {'english': 'flag', 'japanese': '旗', 'POS': 'noun', 'selected': false},
    {'english': 'piano', 'japanese': 'ピアノ', 'POS': 'noun', 'selected': false},
    {'english': 'magic', 'japanese': '魔法', 'POS': 'noun', 'selected': false},
    {'english': 'mystery', 'japanese': '謎', 'POS': 'noun', 'selected': false},
    {'english': 'ski', 'japanese': 'スキー', 'POS': 'noun', 'selected': false},
    {
      'english': 'whisper',
      'japanese': 'ささやく',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'rear',
      'japanese': '後ろ',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'menu', 'japanese': 'お品書き', 'POS': 'noun', 'selected': false},
    {'english': 'species', 'japanese': '種', 'POS': 'noun', 'selected': false},
    {'english': 'moon', 'japanese': '月', 'POS': 'noun', 'selected': false},
    {
      'english': 'presumably',
      'japanese': 'おそらく',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'bless', 'japanese': '神聖にする', 'POS': 'verb', 'selected': false},
    {'english': 'airline', 'japanese': '航空', 'POS': 'noun', 'selected': false},
    {
      'english': 'amendment',
      'japanese': '改正',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'grandmother',
      'japanese': '祖母',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'jury', 'japanese': '陪審', 'POS': 'noun', 'selected': false},
    {
      'english': 'cooperation',
      'japanese': '協力',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'civilian',
      'japanese': '民間人',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'composition',
      'japanese': '構成',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'coin', 'japanese': '硬貨', 'POS': 'noun', 'selected': false},
    {
      'english': 'regardless',
      'japanese': '～にかかわらず',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'scan', 'japanese': 'スキャン', 'POS': 'verb', 'selected': false},
    {'english': 'bunch', 'japanese': '房', 'POS': 'noun', 'selected': false},
    {
      'english': 'racial',
      'japanese': '人種の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'greet', 'japanese': '挨拶する', 'POS': 'verb', 'selected': false},
    {
      'english': 'hopefully',
      'japanese': '願わくは',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'sanction', 'japanese': '制裁', 'POS': 'noun', 'selected': false},
    {'english': 'trick', 'japanese': '巧妙な技', 'POS': 'noun', 'selected': false},
    {
      'english': 'paragraph',
      'japanese': '段落',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'maker', 'japanese': '製作者', 'POS': 'noun', 'selected': false},
    {
      'english': 'chocolate',
      'japanese': 'チョコレート',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'stimulate',
      'japanese': '促す、刺激する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'belt', 'japanese': 'ベルト', 'POS': 'noun', 'selected': false},
    {
      'english': 'potato',
      'japanese': 'じゃがいも',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'narrative',
      'japanese': '物語',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'tissue',
      'japanese': 'ティッシュペーパー、組織',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'barely',
      'japanese': 'かろうじて',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'invent', 'japanese': '発明する', 'POS': 'verb', 'selected': false},
    {
      'english': 'tourism',
      'japanese': '観光事業',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'pro', 'japanese': 'プロ', 'POS': 'noun', 'selected': false},
    {'english': 'stair', 'japanese': '階段', 'POS': 'noun', 'selected': false},
    {
      'english': 'hesitate',
      'japanese': 'ためらう',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'shine', 'japanese': '輝く', 'POS': 'verb', 'selected': false},
    {
      'english': 'motivation',
      'japanese': '意欲、動機',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'romantic',
      'japanese': 'ロマンティック',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'firmly',
      'japanese': 'しっかりと',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'interior', 'japanese': '内側', 'POS': 'noun', 'selected': false},
    {'english': 'stomach', 'japanese': '胃', 'POS': 'noun', 'selected': false},
    {
      'english': 'nowhere',
      'japanese': 'どこにも～ない',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'pray', 'japanese': '祈る', 'POS': 'verb', 'selected': false},
    {
      'english': 'championship',
      'japanese': '選手権',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'servant', 'japanese': '使用人', 'POS': 'noun', 'selected': false},
    {
      'english': 'immigrant',
      'japanese': '移民',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'excess', 'japanese': '余分', 'POS': 'noun', 'selected': false},
    {
      'english': 'complexity',
      'japanese': '複雑さ',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'liability',
      'japanese': '法的責任、債務',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'surprisingly',
      'japanese': '驚くべき',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'extract',
      'japanese': '引き抜く',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'implementation',
      'japanese': '実施、実装',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'bias', 'japanese': '偏見', 'POS': 'noun', 'selected': false},
    {
      'english': 'differently',
      'japanese': '異なって',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'catalog',
      'japanese': 'カタログ',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'continuous',
      'japanese': '連続的な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'golden',
      'japanese': '金の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'stamp', 'japanese': '切手', 'POS': 'noun', 'selected': false},
    {
      'english': 'guideline',
      'japanese': '指針',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'envelope', 'japanese': '封筒', 'POS': 'noun', 'selected': false},
    {'english': 'knife', 'japanese': 'ナイフ', 'POS': 'noun', 'selected': false},
    {
      'english': 'biological',
      'japanese': '生物学的',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'consume',
      'japanese': '消費する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'luxury',
      'japanese': '贅沢な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'weekly',
      'japanese': '週１',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'wherever',
      'japanese': 'どこでも',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'bite', 'japanese': 'かむ', 'POS': 'verb', 'selected': false},
    {'english': 'printer', 'japanese': '印刷機', 'POS': 'noun', 'selected': false},
    {
      'english': 'firstly',
      'japanese': '初めに',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'anxious',
      'japanese': '心配する',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'adventure',
      'japanese': '冒険',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'fence', 'japanese': 'フェンス', 'POS': 'noun', 'selected': false},
    {
      'english': 'exhaust',
      'japanese': '疲れ果てさせる、使い果たす',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'attraction',
      'japanese': 'ひきつけるもの',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'ocean', 'japanese': '海洋', 'POS': 'noun', 'selected': false},
    {
      'english': 'quietly',
      'japanese': '静かに',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'castle', 'japanese': '城', 'POS': 'noun', 'selected': false},
    {
      'english': 'veteran',
      'japanese': 'ベテラン',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'reflection',
      'japanese': '反射',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'nerve', 'japanese': '神経', 'POS': 'noun', 'selected': false},
    {
      'english': 'determination',
      'japanese': '決意',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'altogether',
      'japanese': '完全に',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'fiction',
      'japanese': 'フィクション',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'carpet',
      'japanese': 'カーペット',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'cluster', 'japanese': '群', 'POS': 'noun', 'selected': false},
    {
      'english': 'confusion',
      'japanese': '混乱',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'hurry', 'japanese': '急ぐ', 'POS': 'verb', 'selected': false},
    {'english': 'logic', 'japanese': '論理', 'POS': 'noun', 'selected': false},
    {
      'english': 'controversial',
      'japanese': '議論を呼ぶ',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'raw',
      'japanese': '生の、未加工の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'grammar', 'japanese': '文法', 'POS': 'noun', 'selected': false},
    {'english': 'revise', 'japanese': '修正する', 'POS': 'verb', 'selected': false},
    {
      'english': 'hint',
      'japanese': 'ほのめかす、ヒント',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'hook', 'japanese': '鉤', 'POS': 'noun', 'selected': false},
    {'english': 'bell', 'japanese': 'ベル', 'POS': 'noun', 'selected': false},
    {'english': 'liquid', 'japanese': '液体', 'POS': 'noun', 'selected': false},
    {'english': 'panic', 'japanese': 'パニック', 'POS': 'noun', 'selected': false},
    {'english': 'uncle', 'japanese': '叔父', 'POS': 'noun', 'selected': false},
    {'english': 'rice', 'japanese': 'おこめ', 'POS': 'noun', 'selected': false},
    {'english': 'slope', 'japanese': '坂', 'POS': 'noun', 'selected': false},
    {
      'english': 'happiness',
      'japanese': '幸せ',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'genuine',
      'japanese': '正真正銘の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'vessel', 'japanese': '貨物船', 'POS': 'noun', 'selected': false},
    {'english': 'verb', 'japanese': '動詞', 'POS': 'noun', 'selected': false},
    {
      'english': 'reckon',
      'japanese': '～だと思う',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'silly',
      'japanese': '愚か',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'transportation',
      'japanese': '交通',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'harbor', 'japanese': '湾', 'POS': 'noun', 'selected': false},
    {'english': 'comedy', 'japanese': 'コメディ', 'POS': 'noun', 'selected': false},
    {'english': 'chase', 'japanese': '追いかける', 'POS': 'noun', 'selected': false},
    {
      'english': 'storage',
      'japanese': '保管場所',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'universe', 'japanese': '宇宙', 'POS': 'noun', 'selected': false},
    {
      'english': 'horrible',
      'japanese': 'ひどい',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'sheep', 'japanese': '羊', 'POS': 'noun', 'selected': false},
    {'english': 'lover', 'japanese': '恋人', 'POS': 'noun', 'selected': false},
    {'english': 'rat', 'japanese': 'ラット', 'POS': 'noun', 'selected': false},
    {'english': 'portrait', 'japanese': '肖像', 'POS': 'noun', 'selected': false},
    {
      'english': 'innocent',
      'japanese': '潔白な、無実な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'substitute',
      'japanese': '控え',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'supplement',
      'japanese': '補足',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'adjustment',
      'japanese': '調整',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'reasonably',
      'japanese': '合理的に',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'filter',
      'japanese': 'フィルター',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'flexible',
      'japanese': '曲げやすい',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'abstract',
      'japanese': '抽象的な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'tent', 'japanese': 'テント', 'POS': 'noun', 'selected': false},
    {
      'english': 'precise',
      'japanese': '正確な、精密な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'distant',
      'japanese': '遠い',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'stranger',
      'japanese': '初対面の人、知らない人',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'shade', 'japanese': '影', 'POS': 'noun', 'selected': false},
    {'english': 'grain', 'japanese': '穀物', 'POS': 'noun', 'selected': false},
    {
      'english': 'situate',
      'japanese': '～に置く',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'summarize',
      'japanese': '要約する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'leap', 'japanese': '跳ねる', 'POS': 'verb', 'selected': false},
    {
      'english': 'snap',
      'japanese': 'バキっ！　ばしん！、折る',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'probability',
      'japanese': '見込み',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'leather', 'japanese': '革', 'POS': 'noun', 'selected': false},
    {
      'english': 'uncertainty',
      'japanese': '不確実なこと',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'swear', 'japanese': '誓う', 'POS': 'verb', 'selected': false},
    {'english': 'refugee', 'japanese': '難民', 'POS': 'noun', 'selected': false},
    {'english': 'shore', 'japanese': '岸', 'POS': 'noun', 'selected': false},
    {
      'english': 'monthly',
      'japanese': '月１',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'comprise',
      'japanese': '構成する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'stir', 'japanese': 'かき混ぜる', 'POS': 'verb', 'selected': false},
    {
      'english': 'excitement',
      'japanese': '興奮',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'sigh', 'japanese': 'ため息をつく', 'POS': 'verb', 'selected': false},
    {
      'english': 'pregnancy',
      'japanese': '妊娠',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'experimental',
      'japanese': '実験の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'institutional',
      'japanese': '機関の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'slice', 'japanese': '一切れ', 'POS': 'noun', 'selected': false},
    {'english': 'wander', 'japanese': 'さまよう', 'POS': 'verb', 'selected': false},
    {'english': 'empire', 'japanese': '帝国', 'POS': 'noun', 'selected': false},
    {
      'english': 'subsequently',
      'japanese': 'その後に',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'gentle',
      'japanese': '優しい、穏やかな',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'attendance',
      'japanese': '出席者数',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'ownership',
      'japanese': '所有権',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'qualification',
      'japanese': '資格',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'suspend',
      'japanese': '一時停止する',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'functional',
      'japanese': '機能的な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'voluntary',
      'japanese': '自由意志による',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'pale',
      'japanese': '淡い',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'stain', 'japanese': '汚す', 'POS': 'verb', 'selected': false},
    {
      'english': 'athlete',
      'japanese': 'アスリート',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'organic',
      'japanese': '有機栽培の',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'tongue', 'japanese': '舌', 'POS': 'noun', 'selected': false},
    {'english': 'server', 'japanese': 'サーバー', 'POS': 'noun', 'selected': false},
    {
      'english': 'structural',
      'japanese': '構造的な',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'fool', 'japanese': '馬鹿者', 'POS': 'noun', 'selected': false},
    {
      'english': 'alongside',
      'japanese': '並んで',
      'POS': 'preposition',
      'selected': false
    },
    {'english': 'unite', 'japanese': '団結する', 'POS': 'verb', 'selected': false},
    {
      'english': 'gently',
      'japanese': '優しく',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'compute',
      'japanese': '計算する',
      'POS': 'verb',
      'selected': false
    },
    {'english': 'wipe', 'japanese': '拭く', 'POS': 'verb', 'selected': false},
    {
      'english': 'weird',
      'japanese': '変わった',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'gaze', 'japanese': 'じっと見る', 'POS': 'verb', 'selected': false},
    {'english': 'fade', 'japanese': '弱まる', 'POS': 'verb', 'selected': false},
    {'english': 'cough', 'japanese': '咳をする', 'POS': 'verb', 'selected': false},
    {
      'english': 'hypothesis',
      'japanese': '仮説',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'royal',
      'japanese': '王族の',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'theoretical',
      'japanese': '理論的な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'curtain',
      'japanese': 'カーテン',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'mayor', 'japanese': '市長', 'POS': 'noun', 'selected': false},
    {'english': 'darkness', 'japanese': '暗闇', 'POS': 'noun', 'selected': false},
    {'english': 'aunt', 'japanese': '叔母', 'POS': 'noun', 'selected': false},
    {
      'english': 'tournament',
      'japanese': '大会',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'registration',
      'japanese': '登録',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'fragment', 'japanese': '断片', 'POS': 'noun', 'selected': false},
    {
      'english': 'listener',
      'japanese': '傍聴者',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'tender',
      'japanese': '思いやりのある',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'density', 'japanese': '密度', 'POS': 'noun', 'selected': false},
    {
      'english': 'ugly',
      'japanese': '醜い',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'module',
      'japanese': 'モジュール',
      'POS': 'noun',
      'selected': false
    },
    {
      'english': 'faithfully',
      'japanese': '忠実に',
      'POS': 'adverb',
      'selected': false
    },
    {'english': 'autumn', 'japanese': '秋', 'POS': 'noun', 'selected': false},
    {'english': 'cheek', 'japanese': 'ほお', 'POS': 'noun', 'selected': false},
    {
      'english': 'attachment',
      'japanese': '愛着、添付ファイル',
      'POS': 'noun',
      'selected': false
    },
    {'english': 'holder', 'japanese': '所有者', 'POS': 'noun', 'selected': false},
    {'english': 'grin', 'japanese': 'にっこり笑う', 'POS': 'noun', 'selected': false},
    {'english': 'noun', 'japanese': '名詞', 'POS': 'noun', 'selected': false},
    {
      'english': 'fortunate',
      'japanese': '幸運',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'alright',
      'japanese': '大丈夫',
      'POS': 'adverb',
      'selected': false
    },
    {
      'english': 'lazy',
      'japanese': '怠惰な',
      'POS': 'adjective',
      'selected': false
    },
    {
      'english': 'hello',
      'japanese': 'こんにちは',
      'POS': 'interjection',
      'selected': false
    },
    {'english': 'hunger', 'japanese': '空腹', 'POS': 'noun', 'selected': false},
    {
      'english': 'insure',
      'japanese': '保険を掛ける',
      'POS': 'verb',
      'selected': false
    },
    {
      'english': 'ashamed',
      'japanese': '恥ずかしい',
      'POS': 'adjective',
      'selected': false
    },
    {'english': 'found', 'japanese': '設立する', 'POS': 'verb', 'selected': false},
    {'english': 'thirst', 'japanese': '渇き', 'POS': 'noun', 'selected': false},
    {
      'english': 'No word set.',
      'japanese': '',
      'POS': '単語が設定されていません。',
      'selected': false
    },
  ];
}
