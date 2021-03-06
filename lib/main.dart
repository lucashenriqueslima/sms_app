import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_app/models/plano_amostragem_model.dart';
import 'package:sms_app/models/user_model.dart';
import 'package:sms_app/pages/plano_amostragem_list_page.dart';
import 'package:sms_app/pages/autentication_page.dart';
import 'package:sms_app/pages/home_page.dart';
import 'package:sms_app/pages/login_page.dart';
import 'package:sms_app/pages/user_page.dart';
import 'package:sms_app/routes/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserModel(),
        ),
        ChangeNotifierProxyProvider<UserModel, PlanoAmostragemModel>(
          create: (_) => PlanoAmostragemModel(),
          update: (ctx, user, previous) {
            return PlanoAmostragemModel(
              user.level ?? 0,
              user.id ?? '',
              previous?.items ?? [],
            );
          },
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          splashColor: Colors.blue,
          shadowColor: Colors.blueGrey[900],
          cardColor: Colors.grey[600],
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Colors.lightBlue[700],
              secondary: Colors.white,
              background: Colors.grey[100],
              secondaryVariant: Colors.white70),
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Raleway',
                    color: Theme.of(context).colorScheme.primary),
                caption: const TextStyle(
                  fontSize: 17,
                  fontFamily: 'RobotoCondensed',
                  color: Colors.black,
                ),
                headline1: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w300),
                overline: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'RobotoCondesed',
                ),
                headline2: const TextStyle(
                  fontSize: 26,
                  fontFamily: 'RobotoCondesed',
                  color: Colors.white,
                ),
                subtitle2: TextStyle(
                  fontFamily: 'RobotoCondesed',
                  color: Colors.grey[700],
                  fontSize: 12,
                ),
              ),
        ),
        home: const AutenticationPage(),
      ),
    );
  }
}
