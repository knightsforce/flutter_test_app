part of 'main.dart';
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

const _biggerFont = const TextStyle(fontSize: 18.0);

class RandomWordsState extends State<RandomWords> {

  final _suggestions = List<WordPair>();
  final Set<WordPair> _saved = new Set<WordPair>();

  int index;

  Widget _buildRow(WordPair pair) {
    
    final alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null
      ),
      onTap: () {
        setState(() {
          if(alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      }
    );
  }

  Widget _itemBuilderCallback(context, i) {
    
    if(i.isOdd) return Divider();
    
    index = i ~/ 2;

    if(index >= _suggestions.length) {
      _suggestions.addAll(generateWordPairs().take(10));
    }
    
    return _buildRow(_suggestions[index]);
  }
  
  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: _itemBuilderCallback,
    );
  }

  ListTile createListTitle(WordPair pair) {
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }

  Iterable<ListTile> tiles;
  List<Widget> divided;

  Scaffold builderRoute(BuildContext context) {
    tiles = _saved.map(createListTitle);
    divided = ListTile
      .divideTiles(
        context: context,
        tiles: tiles,
      )
      .toList();
      
      return new Scaffold(         // Add 6 lines from here...
        appBar: new AppBar(
          title: const Text('Saved Suggestions'),
        ),
        body: new ListView(children: divided),
      );  
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(   // Add 20 lines from here...
        builder: builderRoute),                           // ... to here.
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ]
      ),
      body: _buildSuggestions()
    );
  }
}