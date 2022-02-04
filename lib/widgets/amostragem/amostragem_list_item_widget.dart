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
          child: FittedBox(child: Icon(Icons.image_not_supported_sharp)),
        ),
        title: Text(
          "${data.serie} - ${data.cod_barras ?? "Sem Informação"}",
          style: Theme.of(context).textTheme.headline3,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            " ${data.tipo ?? "Sem Informação"} ${data.sub_estacao ?? "Sem Informação"} | ${data.cod_barras ?? "Sem Informação"}",
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        trailing: const Icon(Icons.offline_bolt_outlined),
        onTap: () {
          showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Atenção'),
              content: Text('Deseja inciar a amostragem ${data.idAmostragem}?'),
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
        });
  }
}
