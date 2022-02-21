import 'package:flutter/material.dart';

class DevicesListItemWidget extends StatelessWidget {
  const DevicesListItemWidget({Key? key, required this.device})
      : super(key: key);

  final String device;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        title: Text("$device"),
      ),
    );
  }
}
