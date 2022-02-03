import 'package:flutter/material.dart';
import 'package:sms_app/class/amostragem_class.dart';
import 'package:provider/provider.dart';
import 'package:sms_app/models/amostragem_model.dart';

class AmostragemListItemWidget extends StatelessWidget {
  AmostragemListItemWidget({Key? key, required this.data}) : super(key: key);

  final AmostragemClass data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: FittedBox(
              child: Text(
                data.cod_barras!,
              ),
            ),
          ),
          title: Text(
            "${data.ensaio}",
            style: Theme.of(context).textTheme.headline3,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              "${data.serie} | ${data.tag ?? "Sem Informação"} | ${data.sub_estacao ?? "Sem Informação"}",
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          trailing: const Icon(Icons.bloodtype_rounded),
          onTap: () {
            showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Atenção'),
                content:
                    Text('Deseja inciar a amostragem ${data.idAmostragem}?'),
                actions: [
                  TextButton(
                    child: const Text('Não'),
                    onPressed: () => Navigator.of(ctx).pop(false),
                  ),
                  TextButton(
                    child: const Text('Sim'),
                    onPressed: () async {
                      await Provider.of<AmostragemModel>(
                        context,
                        listen: false,
                      ).loadAmostragem(data.idAmostragem);
                    },
                  ),
                ],
              ),
            );
          }),
    );
  }
}
