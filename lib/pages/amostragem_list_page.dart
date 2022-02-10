import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_app/pages/home_page.dart';
import 'package:sms_app/widgets/amostragem/amostragem_list_item_widget.dart';
import 'package:sms_app/widgets/global/app_bar_widget.dart';
import '../models/amostragem_model.dart';
import 'dart:io';

class AmostragemListPage extends StatefulWidget {
  const AmostragemListPage({Key? key, this.paId, this.reloaded = false})
      : super(key: key);

  final dynamic paId;

  final bool reloaded;

  @override
  _AmostragemListPageState createState() => _AmostragemListPageState();
}

class _AmostragemListPageState extends State<AmostragemListPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    if (widget.reloaded) {
      Provider.of<AmostragemModel>(
        context,
        listen: false,
      ).reloadAmsotragem().then((value) {
        setState(() {
          _isLoading = false;
        });
      });

      return;
    }

    Provider.of<AmostragemModel>(
      context,
      listen: false,
    ).loadAmostragem(widget.paId).then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    AmostragemModel amostragemData = Provider.of(context);

    Future _finishAmostragem() async {
      String internetConnectionText;
      bool internetConnection = false;

      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          internetConnection = true;
          internetConnectionText = "*Conectado*";
        }
      } on SocketException catch (_) {
        internetConnection = false;
        internetConnectionText = "*Desconectado*";
      }

      if (internetConnection) {
        return showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Atenção'),
            content: RichText(
              text: TextSpan(
                text: 'Deseja completar a amostragem? \n\n',
                children: <TextSpan>[
                  TextSpan(
                      text: 'S', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: ' world!'),
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
      }

      // await amostragemData.finishAmostragem();
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const HomePage(),
      //   ),
      // );
    }

    return Scaffold(
      appBar: AppBarWidget(
        title: "Amostragens",
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: amostragemData.itemsCount,
                    itemBuilder: (ctx, index) {
                      return Card(
                        elevation: 4,
                        child: AmostragemListItemWidget(
                          data: amostragemData.items[index],
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
