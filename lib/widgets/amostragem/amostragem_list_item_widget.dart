import 'package:flutter/material.dart';
import 'package:sms_app/class/amostragem_class.dart';
import 'package:provider/provider.dart';
import 'package:sms_app/models/amostragem_model.dart';

class AmostragemListItemWidget extends StatelessWidget {
  AmostragemListItemWidget({Key? key, required this.data}) : super(key: key);

  final AmostragemClass data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.all(15),
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          radius: 40,
          child: const FittedBox(child: Icon(Icons.image_not_supported_sharp)),
        ),
        title: FittedBox(
          child: Text(
            "${data.serie} - ${data.tag ?? "Sem Informação"}",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            " ${data.sub_estacao ?? "Sem Informação"} | ${data.tipo ?? "Sem Informação"}",
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        trailing: const Icon(Icons.offline_bolt_outlined),
        onTap: () {});
  }
}
