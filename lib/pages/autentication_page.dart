import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_app/models/user_model.dart';
import 'package:sms_app/pages/home_page.dart';
import 'package:sms_app/pages/login_page.dart';
import 'package:sms_app/widgets/global/loader_widget.dart';

class AutenticationPage extends StatelessWidget {
  const AutenticationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel redirect = Provider.of(context);
    return FutureBuilder(
      future: redirect.redirectUser(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoaderWidget();
        }
        if (snapshot.error != null) {
          return const Center(
            child: Text('Ocorreu um erro!'),
          );
        } else {
          return redirect.status != 1 ? const LoginPage() : const HomePage();
        }
      },
    );
  }
}
