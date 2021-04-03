import 'package:flutter/material.dart';
import 'package:omartry16/audio_player_linear_progress.dart';

void main() {
  runApp(MyApp());
}

//عمر يوسف كمال
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AudioPlayerLinearProgress(),
    );
  }
}
