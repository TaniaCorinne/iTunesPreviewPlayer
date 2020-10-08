import 'package:flutter/material.dart';
import 'package:musicPlayerSearch_flutter/Provider/SongProvider.dart';
import 'package:musicPlayerSearch_flutter/UI/HomeScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MusicPlayerApp());
}

class MusicPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SongProvider>(
      create: (ctx) => SongProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('YourMusic'),
            backgroundColor: Colors.orangeAccent[100],
          ),
          body: HomeScreen(),
        ),
      ),
    );
  }
}
