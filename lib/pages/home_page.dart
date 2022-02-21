import 'package:flutter/material.dart';
import 'package:sms_app/pages/plano_amostragem_checkbox_list_page.dart';
import 'package:sms_app/pages/user_page.dart';
import 'package:sms_app/widgets/home/categories_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.alert = ''}) : super(key: key);

  final String alert;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _showSnackbar() {
    if (widget.alert != '') {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: const Duration(seconds: 3),
            elevation: 10.0,
            content: Text(
              widget.alert,
              textAlign: TextAlign.center,
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary),
      );
    }

    return;
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 200), () {
      _showSnackbar();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          shadowColor: Theme.of(context).shadowColor,
          title: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Image.asset(
              'assets/images/acs_letras.png',
              fit: BoxFit.contain,
              height: 20,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.notifications_active_outlined),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.menu),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserPage()),
                );
              },
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        body: Container(
          color: Theme.of(context).colorScheme.background,
          child: GridView(
            padding: const EdgeInsets.all(30),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 0.8,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            children: [
              CategoriesItemWidget(
                title: 'Executar Plano de Amostragem',
                icon: Icon(
                  Icons.bloodtype_rounded,
                  color: Theme.of(context).colorScheme.primary,
                  size: 45,
                ),
                route: const PlanoAmostragemCheckboxListPage(),
              ),
              CategoriesItemWidget(
                title: 'Amostrages Não Enviadas',
                icon: Icon(
                  Icons.wrap_text,
                  color: Theme.of(context).colorScheme.primary,
                  size: 45,
                ),
                route: null,
              ),
              CategoriesItemWidget(
                title: 'Criar Plano de Amostragem',
                icon: Icon(
                  Icons.colorize_rounded,
                  color: Theme.of(context).colorScheme.primary,
                  size: 45,
                ),
                route: null,
              ),
              CategoriesItemWidget(
                title: 'Visualizar Tranformadores',
                icon: Icon(
                  Icons.offline_bolt_outlined,
                  color: Theme.of(context).colorScheme.primary,
                  size: 45,
                ),
                route: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
