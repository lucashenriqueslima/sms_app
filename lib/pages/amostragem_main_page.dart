import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_app/models/amostragem_model.dart';
import 'package:sms_app/pages/amostragem_by_equipamento_list_page.dart';
import 'package:sms_app/pages/amostragem_info_page.dart';
import './amostragem_form_page.dart';
import 'amostragem_by_pa_list_page.dart';

class AmostragemMainPage extends StatefulWidget {
  const AmostragemMainPage(
      {Key? key,
      required this.localIdAmostragem,
      required this.idPlanoAmostragem})
      : super(key: key);

  final int localIdAmostragem;
  final int idPlanoAmostragem;

  @override
  _AmostragemMainPageState createState() => _AmostragemMainPageState();
}

class _AmostragemMainPageState extends State<AmostragemMainPage> {
  int? _selectedScreenIndex = 0;

  _selectScreen(int? index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    AmostragemModel amostragemData = Provider.of(context);

    return WillPopScope(
      onWillPop: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Atenção'),
              content: const Text(
                  'Os dados referente a está amostragem serão descartados e seu status ficará como pendente. \n\n Deseja continuar?'),
              actions: [
                TextButton(
                  child: const Text('Não'),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                TextButton(
                  child: const Text('Sim'),
                  onPressed: () {
                    Provider.of<AmostragemModel>(
                      context,
                      listen: false,
                    )
                        .updateAmostragemById(1, widget.localIdAmostragem)
                        .then((_) {
                      Navigator.pop(context);
                      Navigator.pop(context, {
                        'type': "error",
                        'etq': amostragemData
                            .itemByIndex(widget.localIdAmostragem)
                            .cod_barras
                      });
                    });
                  },
                ),
              ],
            );
          }).then((value) => value ?? false),
      child: Scaffold(
        body: Container(
            color: Theme.of(context).colorScheme.secondary,
            child: IndexedStack(
              index: _selectedScreenIndex,
              children: [
                AmostragemFormPage(
                  localIdAmostragem: widget.localIdAmostragem,
                  idPlanoAmostragem: widget.idPlanoAmostragem,
                ),
                AmostragemInfoPage(
                  amostragemData:
                      amostragemData.itemByIndex(widget.localIdAmostragem),
                ),
              ],
            )),
        bottomNavigationBar: BottomNavigationBar(
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          onTap: _selectScreen,
          selectedFontSize: 13,
          selectedIconTheme: const IconThemeData(size: 30),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          backgroundColor: Colors.grey[300],
          unselectedItemColor: Colors.grey[700],
          selectedItemColor: Theme.of(context).colorScheme.primary,
          elevation: 5,
          currentIndex: _selectedScreenIndex ?? 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Formulário',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info_outline),
              label: 'Informações',
            ),
          ],
        ),
      ),
    );
  }
}
