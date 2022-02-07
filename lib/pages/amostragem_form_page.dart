import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sms_app/models/amostragem_model.dart';

class AmostragemFormPage extends StatefulWidget {
  const AmostragemFormPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AmostragemFormPage> createState() => _AmostragemFormPageState();
}

class _AmostragemFormPageState extends State<AmostragemFormPage> {
  bool equipIsOn = false;
  final TextEditingController _emailInput = TextEditingController();
  final TextEditingController _passwdInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AmostragemModel amostragemData = Provider.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextField(
                controller: _emailInput,
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
              child: TextField(
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
                  suffixIcon: const Icon(Icons.storm_rounded),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextField(
                controller: _passwdInput,
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
              child: TextField(
                controller: _emailInput,
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
              child: TextField(
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
              child: TextField(
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
    );
  }
}
