import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ipheira/pages/home.dart';

import 'config/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firestore.collection("Só pra testar").doc("Testando").set({
    "funcionou?": true
  });
  runApp(const MaterialApp(
    home: MyApp(),
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFF4DA768,
          <int, Color>{
            50: Color(0xFFE5F3E0),
            100: Color(0xFFCCE7C1),
            200: Color(0xFFAEDF9F),
            300: Color(0xFF8FD47C),
            400: Color(0xFF76CB5E),
            500: Color(0xFF4DA768),
            600: Color(0xFF479C61),
            700: Color(0xFF3F8F57),
            800: Color(0xFF37734E),
            900: Color(0xFF235438),
          },
        ),
      ),
      home: const HomePage(),
    );
  }
}
