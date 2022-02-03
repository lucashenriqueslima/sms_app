import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_app/widgets/amostragem/amostragem_list_item_widget.dart';
import 'package:sms_app/widgets/global/app_bar_widget.dart';
import '../models/amostragem_model.dart';

class AmostragemListPage extends StatefulWidget {
  const AmostragemListPage({Key? key, required this.paId}) : super(key: key);

  final dynamic paId;

  @override
  _AmostragemListPageState createState() => _AmostragemListPageState();
}

class _AmostragemListPageState extends State<AmostragemListPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    Provider.of<AmostragemModel>(
      context,
      listen: false,
    ).loadAmostragem(widget.paId).then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _refreshPlanoAmostragem(BuildContext context) {
    return Provider.of<AmostragemModel>(
      context,
      listen: false,
    ).loadAmostragem(widget.paId);
  }

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: amostragemData.itemsCount,
                  itemBuilder: (ctx, index) {
                    return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        child: AmostragemListItemWidget(
                          data: amostragemData.items[index],
                        ));
                  },
                ),
              ),
            ),
    );
  }
}
