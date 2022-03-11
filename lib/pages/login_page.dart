import 'package:flutter/material.dart';
import 'package:sms_app/models/user_model.dart';
import 'package:sms_app/pages/home_page.dart';
import '../models/user_model.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool checkbox = false;

  final TextEditingController _emailInput = TextEditingController();
  final TextEditingController _passwdInput = TextEditingController();

  _login() async {
    if (_emailInput.text == "" || _passwdInput.text == "") {
      return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Erro ao efetuar login'),
          content: const Text('Favor preencha todos os campos.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Ok'),
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    }

    UserModel auth = Provider.of(context, listen: false);

    final result =
        await auth.loginUser(_emailInput.text, _passwdInput.text, checkbox);

    if (result == false) {
      return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Erro ao efetuar login'),
          content: const Text('E-mail ou senha incorreto(s).'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Ok'),
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    }

    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const HomePage(
              alert: "Seja bem-vindo",
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF37383b), Color(0xFF242629)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 7,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/logo_acs.png",
                    height: 100,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.width / 18,
                        right: MediaQuery.of(context).size.width / 12),
                    child: Text(
                      'Login',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: 25,
                vertical: MediaQuery.of(context).size.height / 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailInput,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(fontSize: 15.0),
                          filled: true,
                          hintText: "E-mail",
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (text) {},
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height / 65),
                      ),
                      TextFormField(
                        controller: _passwdInput,
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(fontSize: 15.0),
                          filled: true,
                          hintText: "Senha",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                          ),
                        ),
                        obscureText: true,
                        onFieldSubmitted: (_) => _login(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height / 42),
                        child: Row(
                          children: [
                            Checkbox(
                                value: checkbox,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    checkbox = newValue ?? true;
                                  });
                                }),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  checkbox = !checkbox;
                                });
                              },
                              child: Text(
                                "Manter-me conectado?",
                                style: Theme.of(context).textTheme.overline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(90),
                              ),
                              minimumSize: const Size(100.0, 50),
                              padding: const EdgeInsets.all(0.0)),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.blue, Colors.blue[800]!],
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft),
                              borderRadius: BorderRadius.circular(90),
                            ),
                            child: Container(
                              constraints: const BoxConstraints(
                                maxHeight: 50.0,
                                minHeight: 50.0,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "LOGIN",
                                style: Theme.of(context).textTheme.headline1,
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
