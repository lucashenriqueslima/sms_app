import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_app/models/amostragem_model.dart';
import 'package:sms_app/pages/amostragem_info_page.dart';
import './amostragem_form_page.dart';

class AmostragemMainPage extends StatefulWidget {
  const AmostragemMainPage({Key? key, required this.localIdAmostragem})
      : super(key: key);

  final int localIdAmostragem;

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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AmostragemModel amostragemData = Provider.of(context);

    return Scaffold(
      body: Container(
          color: Theme.of(context).colorScheme.secondary,
          child: IndexedStack(
            index: _selectedScreenIndex,
            children: [
              AmostragemFormPage(
                localIdAmostragem: widget.localIdAmostragem,
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
        backgroundColor: Theme.of(context).colorScheme.background,
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
    );
  }
}
