import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}
//void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();
    return MaterialApp(
      home: RandomWord(),
    );
  }
}

class RandomWord extends StatefulWidget {
  @override
  RandomWordState createState() => RandomWordState();
}

class RandomWordState extends State<RandomWord> {
  final List<WordPair> suggestions = <WordPair>[];
  //final suggestions = <WordPair>[];
  final TextStyle biggerFont = TextStyle(fontSize: 18);
  final Set<WordPair> saved = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    //final WordPair wordPair = WordPair.random();
    //return Text(wordPair.asPascalCase);
    return Scaffold(
      appBar: AppBar(
        title: Text("Generador de palabras!!!"),
        actions: <Widget>[
          IconButton(onPressed: pushSaved, icon: Icon(Icons.article_outlined))
        ],
      ),
      body: buildSuggestions(),
    );
  }

  Widget buildSuggestions() {
    return ListView.builder(
      padding: EdgeInsets.all(12),
      itemBuilder: (BuildContext context, int i) {
        if (i.isOdd) {
          //print(i);
          return Divider();
        }

        final int index = i ~/ 2;
        //print("i: ${i}");
        //print("index: ${index}");
        if (index >= suggestions.length) {
          //print("se cumplio index: ${index}");
          suggestions.addAll(generateWordPairs().take(10));
        }
        return buildRow(suggestions[index]);
      },
    );
  }

  Widget buildRow(WordPair pair) {
    final bool alreadySaved = saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            saved.remove(pair);
          }
          else {
            saved.add(pair);
          }
        });
      },
    );
  }

  void pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = saved.map(
                  (WordPair pair) {
                return ListTile(
                  title: Text(
                    pair.asPascalCase,
                    style: biggerFont,
                  ),
                );
              }
          );
          final List<Widget> divided = ListTile.divideTiles(
              context: context,
              tiles: tiles).toList();
          return Scaffold(
            appBar: AppBar(
              title: Text("Favorites words"),
            ),
            body: ListView(
              children: divided,
            ),
          );
        },
      ),
    );
  }
}