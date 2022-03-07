import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_app/models/amostragem_model.dart';

class DevicesListItemWidget extends StatelessWidget {
  DevicesListItemWidget(
      {Key? key,
      required this.device,
      required this.index,
      required this.selectDevice,
      required this.localIdAmostragem})
      : super(key: key);

  final String device;
  final int index;
  Function selectDevice;
  final localIdAmostragem;

  @override
  Widget build(BuildContext context) {
    AmostragemModel amostragemData = Provider.of(context);
    return Card(
      elevation: 4,
      child: ListTile(
        title: Text(device),
        onTap: () {
          selectDevice(index, amostragemData.itemByIndex(localIdAmostragem));
          Navigator.pop(context);
        },
      ),
    );
  }
}
