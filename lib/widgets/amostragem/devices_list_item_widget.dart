import 'package:flutter/material.dart';

class DevicesListItemWidget extends StatelessWidget {
  DevicesListItemWidget(
      {Key? key,
      required this.device,
      required this.index,
      required this.selectDevice})
      : super(key: key);

  final String device;
  final int index;
  Function selectDevice;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        title: Text(device),
        onTap: () => selectDevice(index),
      ),
    );
  }
}
