import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_app/class/amostragem_class.dart';
import 'package:sms_app/widgets/amostragem/amostragem_list_item_widget.dart';
import 'package:sms_app/widgets/global/alert.dart';
import 'package:sms_app/widgets/global/app_bar_widget.dart';
import '../models/amostragem_model.dart';
import 'home_page.dart';

class AmostragemByPaListPage extends StatefulWidget {
  const AmostragemByPaListPage(
      {Key? key, required this.paId, this.type = '', this.alert = ''})
      : super(key: key);

  final dynamic paId;
  final String type;
  final String alert;

  @override
  _AmostragemListPageState createState() => _AmostragemListPageState();
}

class _AmostragemListPageState extends State<AmostragemByPaListPage> {
  @override
  void initState() {
    super.initState();

    // _showSnackbar();

    return;
  }

  bool _isLoading = false;
  _showSnackbar() {
    // if (widget.alert.isNotEmpty) {
    //   return ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBarWidget.alert(widget.alert, widget.type));
    // }

    return;
  }

  @override
  Widget build(BuildContext context) {
    AmostragemModel amostragemData = Provider.of(context);

    List<AmostragemClass> amostragemByPlanoAmostragem =
        amostragemData.itemsByPlanoAmostragem(widget.paId);

    return Scaffold(
      appBar: AppBarWidget(title: "Equipamentos"),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: amostragemByPlanoAmostragem.length,
                    itemBuilder: (ctx, index) {
                      return Card(
                        elevation: 4,
                        child: AmostragemListItemWidget(
                          data: amostragemByPlanoAmostragem[index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
