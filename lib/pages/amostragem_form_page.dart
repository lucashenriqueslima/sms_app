import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sms_app/models/amostragem_model.dart';

class AmostragemFormPage extends StatefulWidget {
  const AmostragemFormPage({
    Key? key,
  }) : super(key: key);

  void teste() {
    print("funfa");
  }

  void saveData() {}

  @override
  State<AmostragemFormPage> createState() => _AmostragemFormPageState();
}

class _AmostragemFormPageState extends State<AmostragemFormPage> {
  bool equipIsOn = false;

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, String?>();

  @override
  void dispose() {
    super.dispose();
    _formData['name'] = "123";
    print("asda");
  }

  @override
  Widget build(BuildContext context) {
    AmostragemModel amostragemData = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryVariant,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.primary, //change your color here
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt_rounded),
            tooltip: 'Salvar Dados da Amostragem',
            onPressed: () {},
          ),
        ],
        elevation: 1,
        title: Text(
          "Formulário",
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextFormField(
                  initialValue: _formData['name'],
                  onFieldSubmitted: (name) {
                    print(name);
                  },
                  onSaved: (name) => _formData['name'] = name,
                  // validator: (_name) {
                  //   final name = _name ?? '';

                  //   if (name.trim().isEmpty) {
                  //     return 'Nome é obrigatório';
                  //   }

                  //   if (name.trim().length < 3) {
                  //     return 'Nome precisa no mínimo de 3 letras.';
                  //   }

                  //   return null;
                  // },
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.blue[50],
                    labelText: 'Temp. Amostra',
                    suffixIcon: const Icon(Icons.bloodtype),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: TextFormField(
                  onFieldSubmitted: (value) {
                    print("asd");
                  },
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.blue[50],
                    labelText: 'Temp. Enrolamento',
                    suffixIcon: const Icon(Icons.storm_rounded),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.blue[50],
                    labelText: 'Temp. Equipamento',
                    suffixIcon: const Icon(Icons.takeout_dining_outlined),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.blue[50],
                    labelText: 'Temp. Ambiente',
                    suffixIcon: const Icon(Icons.air_rounded),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.blue[50],
                    labelText: 'Umidade Relativa',
                    suffixIcon: const Icon(Icons.water_damage_outlined),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  maxLines: 5,
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    fillColor: Colors.blue[50],
                    labelText: 'Observação',
                    suffixIcon: const Icon(Icons.border_color_outlined),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 20.00),
                child: SwitchListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    value: equipIsOn,
                    secondary: Icon(Icons.battery_unknown_outlined),
                    title: Text("Equipamento Energizado?"),
                    onChanged: (bool value) {
                      setState(() {
                        equipIsOn = value;
                      });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
