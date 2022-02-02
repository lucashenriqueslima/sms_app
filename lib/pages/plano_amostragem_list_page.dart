import 'package:flutter/material.dart';
import 'package:sms_app/models/plano_amostragem_model.dart';
import 'package:sms_app/widgets/global/app_bar_widget.dart';
import 'package:sms_app/widgets/global/layout_widget.dart';
import 'package:provider/provider.dart';

class PlanoAmostragemListPage extends StatefulWidget {
  const PlanoAmostragemListPage({Key? key}) : super(key: key);

  // @override
  // void initState() {
  //   Provider.of<PlanoAmostragemModel>(
  //     context,
  //     listen: false,
  //   ).loadProducts().then((value) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   });
  // }

  @override
  State<PlanoAmostragemListPage> createState() =>
      _PlanoAmostragemListPageState();
}

class _PlanoAmostragemListPageState extends State<PlanoAmostragemListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Planos de Amostragens",
      ),
      body: LayoutWidget(
        child: Text("data"),
      ),
    );
  }
}
