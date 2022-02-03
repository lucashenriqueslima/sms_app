import 'package:flutter/material.dart';
import 'package:sms_app/class/plano_amostragem_class.dart';
import 'package:provider/provider.dart';
import 'package:sms_app/models/amostragem_model.dart';

class ListItemWidget extends StatelessWidget {
  ListItemWidget({Key? key, required this.dataPlano}) : super(key: key);

  final PlanoAmostragemClass dataPlano;

  void startAmostragem() {}

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: FittedBox(
            child: Text(
              dataPlano.idPlanoAmostragem!,
            ),
          ),
        ),
      ),
      title: Text(
        "${dataPlano.razaoSocial!} - ${dataPlano.nomeFantasia!}",
        style: Theme.of(context).textTheme.headline3,
      ),
      subtitle: Text(
        "${dataPlano.amostrador} | ${dataPlano.dataPrevista ?? "Sem Informação"}",
        style: Theme.of(context).textTheme.subtitle2,
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: () {
        showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Atenção'),
            content: Text(
                'Deseja inciar a amostragem ${dataPlano.idPlanoAmostragem}?'),
            actions: [
              TextButton(
                child: const Text('Não'),
                onPressed: () => Navigator.of(ctx).pop(false),
              ),
              TextButton(
                child: Text('Sim'),
                onPressed: () => Navigator.of(ctx).pop(true),
              ),
            ],
          ),
        ).then((value) async {
          if (value ?? false) {
            await Provider.of<AmostragemModel>(
              context,
              listen: false,
            ).loadAmostragem(dataPlano.idPlanoAmostragem);
          }
        });
      },
    );
  }
}
