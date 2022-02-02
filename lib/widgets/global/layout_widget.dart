import 'package:flutter/material.dart';

class LayoutWidget extends StatelessWidget {
  LayoutWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).colorScheme.background,
      child: child,
    );
  }
}
