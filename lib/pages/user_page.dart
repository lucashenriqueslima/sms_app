import 'package:flutter/material.dart';
import 'package:sms_app/pages/login_page.dart';
import 'package:sms_app/widgets/global/app_bar_widget.dart';
import 'package:sms_app/widgets/global/layout_widget.dart';
import '../models/user_model.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  const UserPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    UserModel userData = Provider.of(context);

    return Scaffold(
      appBar: AppBarWidget(
        title: "Dados Pessoais",
      ),
      body: LayoutWidget(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, media.height / 20, 0, media.height * 0.006),
                  child: CircleAvatar(
                    radius: media.height / 20,
                    backgroundColor: Theme.of(context).cardColor,
                    child: Text(
                      "${userData.name!.split(" ")[0][0].toString()}${userData.name!.split(" ")[0][1].toString().toUpperCase()}",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ),
                Text(
                  userData.name!.toUpperCase(),
                  style: const TextStyle(
                      fontFamily: "RobotoCondesed",
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.5),
                  child: Text(
                    userData.email!,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                Text(
                  userData.level != 0 ? "Colaborador ACS" : "Cliente ACS",
                  style: Theme.of(context).textTheme.subtitle2,
                )
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: media.height / 2.5,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    userData.deleteUser();

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text("Sair"),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red[900]!),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
    ;
  }
}
