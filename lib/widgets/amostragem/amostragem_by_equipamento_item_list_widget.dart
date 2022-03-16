import 'package:flutter/material.dart';
import 'package:sms_app/class/amostragem_class.dart';
import 'package:sms_app/pages/amostragem_form_page.dart';
import 'package:sms_app/pages/amostragem_main_page.dart';

class AmostragemByEquipamentoItemListWidget extends StatelessWidget {
  const AmostragemByEquipamentoItemListWidget({Key? key, required this.data})
      : super(key: key);

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
    return ListTile(
        contentPadding: const EdgeInsets.all(5),
        leading: CircleAvatar(
          backgroundColor:
              backgroundColorCircleAvatar(data.statusAmostragemItem),
          radius: 40,
          child: iconCircleAvatar(data.statusAmostragemItem),
        ),
        title: Text(
          "Etiqueta: ${data.cod_barras}",
          style: Theme.of(context).textTheme.headline3,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            "Ensaios: ${data.ensaio}",
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
              builder: (context) => AmostragemMainPage(
                  localIdAmostragem: data.localIdAmostragem!,
                  idPlanoAmostragem: data.idPlanoAmostragem!),
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
