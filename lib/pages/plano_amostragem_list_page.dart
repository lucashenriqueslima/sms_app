import 'package:flutter/material.dart';
import 'package:sms_app/models/amostragem_model.dart';
import 'package:sms_app/models/user_model.dart';
import 'package:sms_app/models/plano_amostragem_model.dart';
import 'package:sms_app/widgets/global/app_bar_widget.dart';
import 'package:provider/provider.dart';
import 'package:sms_app/widgets/global/list_item_widget.dart';
import 'package:provider/provider.dart';

class PlanoAmostragemListPage extends StatefulWidget {
  const PlanoAmostragemListPage({Key? key}) : super(key: key);

  @override
  State<PlanoAmostragemListPage> createState() =>
      _PlanoAmostragemListPageState();
}

class _PlanoAmostragemListPageState extends State<PlanoAmostragemListPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    Provider.of<PlanoAmostragemModel>(
      context,
      listen: false,
    ).loadPlanoAmostragem().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _refreshPlanoAmostragem(BuildContext context) {
    return Provider.of<PlanoAmostragemModel>(
      context,
      listen: false,
    ).loadPlanoAmostragem();
  }

  @override
  Widget build(BuildContext context) {
    PlanoAmostragemModel planoData = Provider.of(context);
    AmostragemModel amostragemData = Provider.of(context);

    return Scaffold(
      appBar: AppBarWidget(
        title: "Amostragens",
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () => _refreshPlanoAmostragem(context),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                child: ListView.builder(
                  itemCount: planoData.itemsCount,
                  itemBuilder: (ctx, index) {
                    return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ListItemWidget(
                          dataPlano: planoData.items[index],
                        ));
                  },
                ),
              ),
            ),
    );
  }
}
