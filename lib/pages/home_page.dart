import 'package:flutter/material.dart';
import 'package:sms_app/class/plano_amostragem_class.dart';
import 'package:sms_app/models/user_model.dart';
import 'package:sms_app/pages/plano_amostragem_list_page.dart';
import 'package:sms_app/pages/user_page.dart';
import 'package:sms_app/routes/app_routes.dart';
import 'package:sms_app/widgets/home/categories_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                title: 'Executar Amostragem',
                icon: Icon(
                  Icons.bloodtype_rounded,
                  color: Theme.of(context).colorScheme.primary,
                  size: 45,
                ),
                route: const PlanoAmostragemListPage(),
              ),
              CategoriesItemWidget(
                title: 'Amostrages N??o Enviadas',
                icon: Icon(
                  Icons.wrap_text,
                  color: Theme.of(context).colorScheme.primary,
                  size: 45,
                ),
                route: AppRoutes.AMOSTRAGEM_LIST,
              ),
              CategoriesItemWidget(
                title: 'Criar Plano de Amostragem',
                icon: Icon(
                  Icons.addchart,
                  color: Theme.of(context).colorScheme.primary,
                  size: 45,
                ),
                route: AppRoutes.AMOSTRAGEM_LIST,
              ),
              CategoriesItemWidget(
                title: 'Visualizar Tranformadores',
                icon: Icon(
                  Icons.offline_bolt_outlined,
                  color: Theme.of(context).colorScheme.primary,
                  size: 45,
                ),
                route: AppRoutes.AMOSTRAGEM_LIST,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
