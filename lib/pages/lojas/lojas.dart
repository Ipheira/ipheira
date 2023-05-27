import 'package:flutter/material.dart';

class Lojas extends StatefulWidget {
  const Lojas({Key? key}) : super(key: key);

  @override
  State<Lojas> createState() => _LojasState();
}

class _LojasState extends State<Lojas> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Lojas'),
    );
  }
}

