
import 'package:flutter/material.dart';

class MotionContainer extends StatelessWidget {
  const MotionContainer({required this.name, required this.child, Key? key})
      : super(key: key);
  final String name;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(name), child],
      ),
    );
  }
}
