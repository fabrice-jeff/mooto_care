import 'package:flutter/material.dart';

class ResultScan extends StatelessWidget {
  final text;
  const ResultScan({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('result'),
      ),
      body: Center(
        child: Text(text),
      ),
    );
  }
}
