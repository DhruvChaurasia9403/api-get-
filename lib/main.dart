import 'package:api/getApi/apiDartFile_SelfWritten/home2.dart';
import 'package:api/getApi/jsonToDartNotPossible/Home4.dart';
import 'package:api/getApi/NormalApi/home.dart';
import 'package:api/getApi/NormalApi//home3.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home4(),
    );
  }
}