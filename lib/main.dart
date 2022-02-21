import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_app/models/amostragem_model.dart';
import 'package:sms_app/models/plano_amostragem_model.dart';
import 'package:sms_app/models/user_model.dart';
import 'package:sms_app/pages/autentication_page.dart';

import 'models/plano_amostragem_on_model.dart';

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
              user.id ?? '0',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProvider(
          create: (_) => PlanoAmostragemOnModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => AmostragemModel(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          splashColor: Colors.blue,
          shadowColor: Colors.blueGrey[50],
          cardColor: Colors.white,
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Colors.lightBlue[700],
              secondary: Colors.white,
              background: Colors.grey[100],
              secondaryVariant: Colors.grey[100]),
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
                headline3: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondesed',
                  color: Colors.black,
                ),
                headline5: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontFamily: 'RobotCondesed',
                    fontWeight: FontWeight.w300),
                headline4: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'RobotCondesed',
                ),
                subtitle2: TextStyle(
                  fontFamily: 'RobotoCondesed',
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
        ),
        home: const AutenticationPage(),
      ),
    );
  }
}
