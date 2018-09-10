import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
part 'RandomWords.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  Key key = new UniqueKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        key: key,
        title: 'Startup Name Generator',
        theme: new ThemeData(          // Add the 3 lines from here... 
          primaryColor: Colors.white,
        ),
        home: RandomWords(),
    );
  }
}
