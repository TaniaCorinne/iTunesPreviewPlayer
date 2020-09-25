import 'package:flutter/material.dart';
import 'package:musicPlayerSearch_flutter/Provider/musicProvider.dart';
import 'package:musicPlayerSearch_flutter/UI/searchScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MusicPlayerApp());
}

class MusicPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MusicProvider>(
      create: (ctx) => MusicProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('YourMusic'),
            backgroundColor: Colors.orangeAccent[100],
          ),
          body: SearchScreen(),
        ),
      ),
    );
  }
}
