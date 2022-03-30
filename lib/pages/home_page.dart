import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_app/models/message_model.dart';
import 'package:sms_app/pages/plano_amostragem_checkbox_list_page.dart';
import 'package:sms_app/pages/user_page.dart';
import 'package:sms_app/widgets/home/categories_item_widget.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:badges/badges.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.alert = '', this.dialog = ''})
      : super(key: key);

  final String alert;
  final String dialog;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _showSnackbar() {
    if (widget.alert != '') {
      showTopSnackBar(
        context,
        CustomSnackBar.info(
          message: widget.alert,
        ),
      );
    }
  }

  _showDialog() {
    if (widget.dialog != '') {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Atenção'),
              content: Text(widget.dialog),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
              ],
            );
          });
    }
  }

  SnackBar test() {
    return SnackBar(
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
        backgroundColor: Theme.of(context).colorScheme.primary);
  }

  @override
  void initState() {
    Provider.of<MessageModel>(
      context,
      listen: false,
    ).loadMessage();

    Future.delayed(const Duration(milliseconds: 200), () {
      _showSnackbar();
      _showDialog();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MessageModel messageData = Provider.of(context);
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
            Badge(
                position: BadgePosition.topEnd(top: 10, end: 10),
                badgeContent: Text(
                  messageData.itemsByStatus.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
                showBadge: messageData.itemsByStatus > 0 ? true : false,
                child: IconButton(
                    icon: Icon(
                      Icons.notifications_active_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                        ),
                        context: context,
                        builder: (_) {
                          return Column(
                            children: [
                              Stack(children: [
                                const SizedBox(
                                  width: double.infinity,
                                  height: 56.0,
                                  child: Center(
                                      child: Text(
                                    "Mensagens",
                                    style: TextStyle(fontSize: 17),
                                  ) // Your desired title
                                      ),
                                ),
                                Positioned(
                                  left: 0.0,
                                  top: 0.0,
                                  child: IconButton(
                                    icon: const Icon(
                                        Icons.close), // Your desired icon
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                )
                              ]),
                              Expanded(
                                  child: messageData.itemsByStatus > 0
                                      ? ListView.builder(
                                          padding: const EdgeInsets.all(10),
                                          itemCount: messageData.itemsCount,
                                          itemBuilder: (ctx, index) {
                                            return ListTile(
                                              contentPadding:
                                                  const EdgeInsets.all(5),
                                              leading: CircleAvatar(
                                                radius: 30,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(6),
                                                  child: FittedBox(
                                                      child: Icon(Icons
                                                          .warning_amber_rounded)),
                                                ),
                                              ),
                                              title: Text(
                                                "Subestação: ${messageData.items[index].message}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline3,
                                              ),
                                              subtitle: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.0),
                                                child: Text(
                                                  "${messageData.items[index].subMessage}}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2,
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      : const Center(
                                          child: Text(
                                            "Você ainda não possui mensagens.",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        )),
                            ],
                          );
                        },
                      );
                    })),
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
