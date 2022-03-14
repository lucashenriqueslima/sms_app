import 'package:flutter/material.dart';

class AmostragemByEquipamentoItemListWidget extends StatelessWidget {
  const AmostragemByEquipamentoItemListWidget({Key? key}) : super(key: key);

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
        trailing: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Icon(Icons.arrow_forward_ios_rounded),
        ),
        onTap: () {
          Navigator.pushReplacement(
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
