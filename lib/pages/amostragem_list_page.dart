import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:sms_app/widgets/amostragem/amostragem_list_item_widget.dart';
import 'package:sms_app/widgets/global/alert.dart';
import 'package:sms_app/widgets/global/app_bar_widget.dart';
import '../models/amostragem_model.dart';
import 'home_page.dart';

class AmostragemListPage extends StatefulWidget {
  const AmostragemListPage(
      {Key? key,
      this.paId,
      this.reloaded = false,
      this.type = '',
      this.alert = ''})
      : super(key: key);

  final dynamic paId;
  final bool reloaded;
  final String type;
  final String alert;

  @override
  _AmostragemListPageState createState() => _AmostragemListPageState();
}

class _AmostragemListPageState extends State<AmostragemListPage> {
  bool _isLoading = true;
  _showSnackbar() {
    if (widget.alert.isNotEmpty) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBarWidget.alert(widget.alert, widget.type));
    }

    return;
  }

  @override
  void initState() {
    super.initState();

    if (widget.reloaded) {
      Provider.of<AmostragemModel>(
        context,
        listen: false,
      ).reloadAmostragem().then((value) {
        setState(() {
          _isLoading = false;
        });
      }).then((value) => _showSnackbar());

      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    AmostragemModel amostragemData = Provider.of(context);

    var amostragemByPaId = amostragemData.itemsByPlanoAmostragem(widget.paId);

    Future<bool?> getConnection() async {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        }
      } on SocketException catch (_) {
        return false;
      }
    }

    Future _finishAmostragem() async {
      final internetConnection = await getConnection();

      return showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Atenção'),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 18,
          ),
          content: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.black,
              ),
              text: 'Deseja completar a amostragem? \n\n',
              children: <TextSpan>[
                const TextSpan(
                  text: 'Status Conexão: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: internetConnection! ? "Conectado" : "Sem Conexão",
                  style: TextStyle(
                    color: internetConnection
                        ? Colors.green[800]
                        : Colors.red[800],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Não'),
              onPressed: () => Navigator.of(ctx).pop(false),
            ),
            TextButton(
              child: const Text('Sim'),
              onPressed: () async {
                amostragemData.finishAmostragem(internetConnection);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBarWidget(title: widget.paId.toString()),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: amostragemByPaId.length,
                    itemBuilder: (ctx, index) {
                      return Card(
                        elevation: 4,
                        child: AmostragemListItemWidget(
                          data: amostragemByPaId[index],
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton.icon(
                  icon: const Icon(
                    Icons.done,
                    size: 28,
                  ),
                  label: Text('Concluir Amostragem',
                      style: Theme.of(context).textTheme.headline5),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.primaryVariant,
                    elevation: 0,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    fixedSize: const Size(10, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  onPressed: _finishAmostragem,
                ),
              ],
            ),
    );
  }
}
