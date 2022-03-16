import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_app/class/amostragem_class.dart';
import 'package:sms_app/models/amostragem_model.dart';
import 'package:sms_app/pages/amostragem_by_equipamento_list_page.dart';

class AmostragemListItemWidget extends StatelessWidget {
  AmostragemListItemWidget({Key? key, required this.data}) : super(key: key);

  Color? backgroundColorCircleAvatar(statusAmostragem) {
    if (statusAmostragem == 1) {
      return Colors.grey[700];
    }

    return Colors.green[600];
  }

  Icon iconCircleAvatar(statusAmostragem) {
    if (statusAmostragem == 0) {
      return const Icon(
        Icons.warning_amber_rounded,
        size: 28,
      );
    }

    if (statusAmostragem == 1) {
      return const Icon(
        Icons.double_arrow_rounded,
        size: 28,
      );
    }

    return const Icon(
      Icons.check,
      size: 28,
    );
  }

  final AmostragemClass data;

  @override
  Widget build(BuildContext context) {
    AmostragemModel amostragemData = Provider.of(context);
    return ListTile(
        contentPadding: const EdgeInsets.all(5),
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          radius: 40,
          child: Icon(Icons.takeout_dining_outlined),
        ),
        title: Text(
          "${data.serie} - ${data.tag}",
          style: Theme.of(context).textTheme.headline3,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            " ${data.sub_estacao} | Amostras pendentes: ${amostragemData.items.where((element) => element.idEquipamento == data.idEquipamento && element.idPlanoAmostragem == data.idPlanoAmostragem && element.statusAmostragemItem != 2).length}",
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        trailing: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Icon(Icons.arrow_forward_ios_rounded),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AmostragemByEquipamentoListPage(
                idEquipamento: data.idEquipamento!,
                paId: data.idPlanoAmostragem!,
              ),
            ),
          );

          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => AmostragemMainPage(
          //       localIdAmostragem: data.localIdAmostragem!,
          //       idPlanoAmostragem: data.idPlanoAmostragem!,
          //     ),
          //   ),
          // );
        });
  }
}
