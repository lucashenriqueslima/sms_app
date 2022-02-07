import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_app/models/amostragem_model.dart';

class AmostragemFormPage extends StatelessWidget {
  const AmostragemFormPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AmostragemModel amostragemData = Provider.of(context);
    return Container(
      child: Text("a"),
    );
  }
}
