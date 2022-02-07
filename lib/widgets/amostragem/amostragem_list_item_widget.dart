import 'package:flutter/material.dart';
import 'package:sms_app/class/amostragem_class.dart';
import 'package:provider/provider.dart';
import 'package:sms_app/models/amostragem_model.dart';
import 'package:sms_app/pages/amostragem_main_page.dart';

class AmostragemListItemWidget extends StatelessWidget {
  AmostragemListItemWidget({Key? key, required this.data}) : super(key: key);

  final AmostragemClass data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: const EdgeInsets.all(5),
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          radius: 40,
          child: const FittedBox(child: Icon(Icons.offline_bolt_outlined)),
        ),
        title: Text(
          "${data.serie} - ${data.tag}",
          style: Theme.of(context).textTheme.headline3,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            " ${data.sub_estacao} | ${data.tipo}",
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AmostragemMainPage(
                localIdAmostragem: data.localIdAmostragem,
              ),
            ),
          );
        });
  }
}
