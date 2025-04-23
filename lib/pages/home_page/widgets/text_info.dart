import 'package:flutter/material.dart';

class TextInfo extends StatelessWidget {
  final String text;
  const TextInfo({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 30, color: Colors.white,fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
    );
  }
}
