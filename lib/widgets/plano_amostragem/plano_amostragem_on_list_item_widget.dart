import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_app/class/plano_amostragem_class.dart';
import 'package:sms_app/models/amostragem_model.dart';
import 'package:sms_app/pages/amostragem_by_pa_list_page.dart';

class PlanoAmostragemOnListItemWidget extends StatelessWidget {
  const PlanoAmostragemOnListItemWidget({
    Key? key,
    required this.planoOnData,
  }) : super(key: key);

  final PlanoAmostragemOnClass planoOnData;
  @override
  Widget build(BuildContext context) {
    AmostragemModel amostragemData = Provider.of(context);
    return ListTile(
        contentPadding: const EdgeInsets.all(5),
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                planoOnData.idPlanoAmostragem.toString(),
              ),
            ),
          ),
        ),
        title: Text(
          "Subestação: ${planoOnData.subEstacao!}",
          style: Theme.of(context).textTheme.headline3,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            "Equipamentos: ${planoOnData.equipamentoMissing.toString()} | Amostras pendentes: ${amostragemData.items.where((element) => element.idPlanoAmostragem == planoOnData.idPlanoAmostragem && element.statusAmostragemItem != 2).length}",
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AmostragemByPaListPage(
                paId: planoOnData.idPlanoAmostragem,
              ),
            ),
          );
        });
  }
}
