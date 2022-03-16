import 'package:flutter/material.dart';
import 'package:sms_app/models/amostragem_model.dart';
import 'package:provider/provider.dart';
import 'package:sms_app/models/plano_amostragem_on_model.dart';
import 'package:sms_app/pages/home_page.dart';
import 'package:sms_app/widgets/plano_amostragem/plano_amostragem_on_list_item_widget.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Planos Amostragem"),
        centerTitle: true,
        leading: IconButton(
            onPressed: showDialogOnPop, icon: const Icon(Icons.arrow_back)),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : WillPopScope(
              onWillPop: showDialogOnPop,
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
    );
  }
}
