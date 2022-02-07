import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_app/db/Db.dart';
import 'package:sms_app/pages/home_page.dart';
import 'package:sms_app/widgets/amostragem/amostragem_list_item_widget.dart';
import 'package:sms_app/widgets/global/app_bar_widget.dart';
import '../models/amostragem_model.dart';

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
      print("reloaded");
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

    Future<void> _finishAmostragem() async {
      await amostragemData.finishAmostragem();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
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
                    onPressed: _finishAmostragem),
              ],
            ),
    );
  }
}
