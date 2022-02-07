import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_app/models/amostragem_model.dart';
import 'package:sms_app/pages/amostragem_info_page.dart';
import 'package:sms_app/widgets/global/app_bar_widget.dart';
import './amostragem_form_page.dart';

class AmostragemMainPage extends StatefulWidget {
  const AmostragemMainPage({Key? key, required this.localIdAmostragem})
      : super(key: key);

  final int localIdAmostragem;

  @override
  _AmostragemMainPageState createState() => _AmostragemMainPageState();
}

class _AmostragemMainPageState extends State<AmostragemMainPage> {
  int _selectedScreenIndex = 0;

  final List<String> _titles = [
    'Fomulário',
    'Informações',
  ];

  List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens = [
      AmostragemFormPage(),
      AmostragemInfoPage(
        localIdAmostragem: widget.localIdAmostragem,
      ),
    ];
  }

  _selectScreen(int index) {
    if (index == 0) {
      print(index);
    }
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    AmostragemModel amostragemData = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryVariant,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.primary, //change your color here
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt_rounded),
            tooltip: 'Salvar Dados da Amostragem',
            onPressed: () {},
          ),
        ],
        elevation: 1,
        title: Text(
          _titles[_selectedScreenIndex],
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: _screens[_selectedScreenIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        backgroundColor: Theme.of(context).colorScheme.background,
        unselectedItemColor: Colors.grey[700],
        selectedItemColor: Theme.of(context).colorScheme.primary,
        elevation: 5,
        currentIndex: _selectedScreenIndex,
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
