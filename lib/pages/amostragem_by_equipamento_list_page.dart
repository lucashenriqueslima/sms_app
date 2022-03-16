import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_app/class/amostragem_class.dart';
import 'package:sms_app/models/amostragem_model.dart';
import 'package:sms_app/widgets/amostragem/amostragem_by_equipamento_item_list_widget.dart';
import 'package:sms_app/widgets/global/app_bar_widget.dart';

class AmostragemByEquipamentoListPage extends StatefulWidget {
  const AmostragemByEquipamentoListPage(
      {Key? key, required this.idEquipamento, required this.paId})
      : super(key: key);

  final String idEquipamento;
  final int paId;

  @override
  State<AmostragemByEquipamentoListPage> createState() =>
      _AmostragemByEquipamentoListPageState();
}

class _AmostragemByEquipamentoListPageState
    extends State<AmostragemByEquipamentoListPage> {
  @override
  Widget build(BuildContext context) {
    AmostragemModel amostragemData = Provider.of(context);

    List<AmostragemClass> amostragemByEquipamento =
        amostragemData.itemsByEquipamento(widget.idEquipamento, widget.paId);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${amostragemByEquipamento[0].serie} | ${amostragemByEquipamento[0].tag}",
          style: TextStyle(fontFamily: "'RobotoCondensed'"),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: amostragemByEquipamento.length,
        itemBuilder: (ctx, index) {
          return Card(
              elevation: 4,
              child: AmostragemByEquipamentoItemListWidget(
                data: amostragemByEquipamento[index],
              ));
        },
      ),
    );
  }
}
