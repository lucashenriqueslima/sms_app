import 'package:flutter/material.dart';
import 'package:sms_app/models/amostragem_model.dart';
import 'package:provider/provider.dart';
import 'package:sms_app/models/plano_amostragem_on_model.dart';
import 'package:sms_app/pages/home_page.dart';
import 'package:sms_app/widgets/plano_amostragem/plano_amostragem_on_list_item_widget.dart';
import 'dart:io';

class PlanoAmostragemOnListPage extends StatefulWidget {
  const PlanoAmostragemOnListPage({Key? key, this.reloaded = false, this.paId})
      : super(key: key);

  final bool reloaded;
  final String? paId;

  @override
  _PlanoAmostragemOnListPageState createState() =>
      _PlanoAmostragemOnListPageState();
}

class _PlanoAmostragemOnListPageState extends State<PlanoAmostragemOnListPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    if (widget.reloaded) {
      Provider.of<PlanoAmostragemOnModel>(
        context,
        listen: false,
      )
          .reloadPlanoAmostragemOn()
          .then((value) {})
          .then((value) => Provider.of<AmostragemModel>(
                context,
                listen: false,
              ).reloadAmostragem())
          .then((value) => setState(() {
                _isLoading = false;
              }));

      return;
    }

    Provider.of<PlanoAmostragemOnModel>(
      context,
      listen: false,
    ).loadPlanoAmostragemOn(widget.paId);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    PlanoAmostragemOnModel planoOnData = Provider.of(context);
    AmostragemModel amostragemData = Provider.of(context);

    Future _finishAmostragem() async {
      final internetConnection = await getConnection();

      return showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Atenção'),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 18,
          ),
          content: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.black,
              ),
              text: '\nDeseja finalizar a amostragem? \n\n\n',
              children: <TextSpan>[
                const TextSpan(
                  text: 'Status Conexão: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: internetConnection!
                      ? "Conectado.\n\n"
                      : "Sem Conexão.\n\n",
                  style: TextStyle(
                    color: internetConnection
                        ? Colors.green[800]
                        : Colors.red[800],
                  ),
                ),
                const TextSpan(
                  text: 'Status Amostragem: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: amostragemData.items
                          .where((element) => element.statusAmostragemItem == 1)
                          .toList()
                          .isEmpty
                      ? "Completa."
                      : "Incompleta.",
                  style: TextStyle(
                    color: amostragemData.items
                            .where(
                                (element) => element.statusAmostragemItem == 1)
                            .toList()
                            .isEmpty
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
      appBar: AppBar(
        title: const Text("Planos de Amostragem"),
        centerTitle: true,
        leading: IconButton(
            onPressed: showDialogOnPop, icon: const Icon(Icons.arrow_back)),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : WillPopScope(
              onWillPop: showDialogOnPop,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(10.0),
                      itemCount: planoOnData.itemsCount,
                      itemBuilder: (ctx, index) {
                        return Card(
                          elevation: 4,
                          child: PlanoAmostragemOnListItemWidget(
                            planoOnData: planoOnData.items[index],
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
            ),
    );
  }

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

  Future<bool> showDialogOnPop() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Atenção'),
            content: const Text(
                'Todos os dados referentes as amostragems serão apagados e você será redirecionado a home \n\n Deseja continuar?'),
            actions: [
              TextButton(
                child: const Text('Não'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: const Text('Sim'),
                onPressed: () async {
                  Provider.of<PlanoAmostragemOnModel>(
                    context,
                    listen: false,
                  ).deletePlanoAmostragemOn().then((_) {
                    Provider.of<AmostragemModel>(
                      context,
                      listen: false,
                    ).deleteAmostragem().then((_) {});
                    Navigator.of(context).pop(true);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  });
                },
              ),
            ],
          );
        }).then((value) => value ?? false);
  }
}
