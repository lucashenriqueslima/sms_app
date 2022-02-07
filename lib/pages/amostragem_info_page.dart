import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_app/models/amostragem_model.dart';

class AmostragemInfoPage extends StatelessWidget {
  const AmostragemInfoPage({
    Key? key,
    required this.localIdAmostragem,
  }) : super(key: key);

  final int localIdAmostragem;

  @override
  Widget build(BuildContext context) {
    AmostragemModel amostragemData = Provider.of(context);
    return ListView(
      children: [
        Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: ListTile(
            title: RichText(
              text: TextSpan(
                text: 'Etiqueta(s):  ',
                style: Theme.of(context).textTheme.headline4,
                children: <TextSpan>[
                  TextSpan(
                    text:
                        '${amostragemData.itemByIndex(localIdAmostragem).cod_barras}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: ListTile(
            title: RichText(
              text: TextSpan(
                text: 'Ensaio(s):  ',
                style: Theme.of(context).textTheme.headline4,
                children: <TextSpan>[
                  TextSpan(
                      text:
                          '${amostragemData.itemByIndex(localIdAmostragem).ensaio}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ),
        Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: ListTile(
            title: RichText(
              text: TextSpan(
                text: 'Nº de Série:  ',
                style: Theme.of(context).textTheme.headline4,
                children: <TextSpan>[
                  TextSpan(
                      text:
                          '${amostragemData.itemByIndex(localIdAmostragem).serie}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ),
        Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: ListTile(
            title: RichText(
              text: TextSpan(
                text: 'TAG:  ',
                style: Theme.of(context).textTheme.headline4,
                children: <TextSpan>[
                  TextSpan(
                      text:
                          '${amostragemData.itemByIndex(localIdAmostragem).tag}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ),
        Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: ListTile(
            title: RichText(
              text: TextSpan(
                text: 'Subestação:  ',
                style: Theme.of(context).textTheme.headline4,
                children: <TextSpan>[
                  TextSpan(
                      text:
                          '${amostragemData.itemByIndex(localIdAmostragem).sub_estacao}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ),
        Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: ListTile(
            title: RichText(
              text: TextSpan(
                text: 'Tipo:  ',
                style: Theme.of(context).textTheme.headline4,
                children: <TextSpan>[
                  TextSpan(
                      text:
                          '${amostragemData.itemByIndex(localIdAmostragem).tipo}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ),
        Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: ListTile(
            title: RichText(
              text: TextSpan(
                text: 'Potência:  ',
                style: Theme.of(context).textTheme.headline4,
                children: <TextSpan>[
                  TextSpan(
                      text:
                          '${amostragemData.itemByIndex(localIdAmostragem).potencia!.replaceAll('.', ',')}0 kVA',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ),
        Card(
          elevation: 0,
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          child: ListTile(
            title: RichText(
              text: TextSpan(
                text: 'Tensão:  ',
                style: Theme.of(context).textTheme.headline4,
                children: <TextSpan>[
                  TextSpan(
                      text:
                          '${amostragemData.itemByIndex(localIdAmostragem).tensao!.replaceAll('.', ',')}0 kVA',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
