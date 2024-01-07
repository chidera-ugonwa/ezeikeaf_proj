import 'package:ezeikeaf_proj/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBVyD1UHZ-wFGP4Oe0EtqYxtbgxgzJCZdw",
      appId: "1:39993389654:web:f7c6a9682de01979c241f7",
      messagingSenderId: "39993389654",
      projectId: "ezikeaf-8f521",
      storageBucket: "ezikeaf-8f521.appspot.com",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ezikeaf',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
