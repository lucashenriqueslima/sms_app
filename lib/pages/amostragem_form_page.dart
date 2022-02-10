import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_app/models/amostragem_model.dart';

import 'amostragem_list_page.dart';

class AmostragemFormPage extends StatefulWidget {
  const AmostragemFormPage({
    Key? key,
    required this.localIdAmostragem,
  }) : super(key: key);

  final int localIdAmostragem;

  @override
  State<AmostragemFormPage> createState() => _AmostragemFormPageState();
}

class _AmostragemFormPageState extends State<AmostragemFormPage> {
  final _formKey = GlobalKey<FormState>();

  void submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    Provider.of<AmostragemModel>(
      context,
      listen: false,
    ).updateAmostragemById(2, widget.localIdAmostragem, true).then((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AmostragemListPage(
            reloaded: true,
          ),
        ),
      );
    });

    // _formKey.currentState?.save();
  }

  @override
  Widget build(BuildContext context) {
    AmostragemModel amostragemData = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulário"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: submitForm,
            icon: const Icon(Icons.check),
          )
        ],
        leading: IconButton(
          onPressed: () {
            showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Atenção'),
                content: const Text(
                    'Os dados referente a está amostragem não serão salvos, você tem certeza que deseja prosseguir?'),
                actions: [
                  TextButton(
                    child: const Text('Não'),
                    onPressed: () => Navigator.of(ctx).pop(false),
                  ),
                  TextButton(
                    child: const Text('Sim'),
                    onPressed: () async {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const AmostragemListPage(
                                    reloaded: true,
                                  )),
                          (Route<dynamic> route) => false);
                    },
                  ),
                ],
              ),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextFormField(
                  initialValue: amostragemData
                      .itemByIndex(widget.localIdAmostragem)
                      .temp_amostra,
                  onSaved: (temp_amostra) => amostragemData
                      .items[widget.localIdAmostragem]
                      .temp_amostra = temp_amostra,
                  validator: (_temp_amostra) {
                    final temp_amostra = _temp_amostra ?? '';

                    if (temp_amostra.contains('.')) {
                      return 'Favor não utilizar "."';
                    }

                    return null;
                  },
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: false),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.blue[50],
                    labelText: 'Temp. Amostra',
                    suffixIcon: const Icon(Icons.bloodtype),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextFormField(
                  validator: (_temp_amostra) {
                    final temp_amostra = _temp_amostra ?? '';

                    if (temp_amostra.contains('.')) {
                      return 'Favor não utilizar "."';
                    }

                    return null;
                  },
                  initialValue: amostragemData
                      .itemByIndex(widget.localIdAmostragem)
                      .temp_equipamento,
                  onSaved: (temp_equipamento) => amostragemData
                      .items[widget.localIdAmostragem]
                      .temp_equipamento = temp_equipamento,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: false),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.blue[50],
                    labelText: 'Temp. Equipamento',
                    suffixIcon: const Icon(Icons.takeout_dining_outlined),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: TextFormField(
                  validator: (_temp_amostra) {
                    final temp_amostra = _temp_amostra ?? '';

                    if (temp_amostra.contains('.')) {
                      return 'Favor não utilizar "."';
                    }

                    return null;
                  },
                  initialValue: amostragemData
                      .itemByIndex(widget.localIdAmostragem)
                      .temp_enrolamento,
                  onSaved: (temp_enrolamento) => amostragemData
                      .items[widget.localIdAmostragem]
                      .temp_enrolamento = temp_enrolamento,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: false),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.blue[50],
                    labelText: 'Temp. Enrolamento',
                    suffixIcon: const Icon(Icons.storm_rounded),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextFormField(
                  validator: (_temp_amostra) {
                    final temp_amostra = _temp_amostra ?? '';

                    if (temp_amostra.contains('.')) {
                      return 'Favor não utilizar "."';
                    }

                    return null;
                  },
                  initialValue: amostragemData
                      .itemByIndex(widget.localIdAmostragem)
                      .temp_ambiente,
                  onSaved: (temp_ambiente) => amostragemData
                      .items[widget.localIdAmostragem]
                      .temp_ambiente = temp_ambiente,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: false),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.blue[50],
                    labelText: 'Temp. Ambiente',
                    suffixIcon: const Icon(Icons.air_rounded),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextFormField(
                  validator: (_temp_amostra) {
                    final temp_amostra = _temp_amostra ?? '';

                    if (temp_amostra.contains('.')) {
                      return 'Favor não utilizar "."';
                    }

                    return null;
                  },
                  initialValue: amostragemData
                      .itemByIndex(widget.localIdAmostragem)
                      .umidade_relativa,
                  onSaved: (umidade_relativa) => amostragemData
                      .items[widget.localIdAmostragem]
                      .umidade_relativa = umidade_relativa,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: false),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.blue[50],
                    labelText: 'Umidade Relativa',
                    suffixIcon: const Icon(Icons.water_damage_outlined),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextFormField(
                  initialValue: amostragemData
                      .itemByIndex(widget.localIdAmostragem)
                      .observacao,
                  onSaved: (observacao) => amostragemData
                      .items[widget.localIdAmostragem].observacao = observacao,
                  textInputAction: TextInputAction.done,
                  maxLines: 5,
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    fillColor: Colors.blue[50],
                    labelText: 'Observação',
                    suffixIcon: const Icon(Icons.border_color_outlined),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 20.00),
                child: SwitchListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    value: amostragemData
                        .itemByIndex(widget.localIdAmostragem)
                        .equipamento_energizado!,
                    secondary: const Icon(Icons.battery_unknown_outlined),
                    title: const Text("Equipamento Energizado?"),
                    onChanged: (value) {
                      setState(() {
                        amostragemData
                            .itemByIndex(widget.localIdAmostragem)
                            .equipamento_energizado = value;
                        amostragemData.notifyListeners();
                      });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
