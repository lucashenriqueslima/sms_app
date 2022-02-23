import 'package:flutter/material.dart';

class DevicesListItemWidget extends StatelessWidget {
  DevicesListItemWidget(
      {Key? key, required this.device, required this.selectDevice})
      : super(key: key);

  final device;
  Function selectDevice;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        title: Text("${device.name}"),
        onTap: () => selectDevice(device),
      ),
    );
  }
}
