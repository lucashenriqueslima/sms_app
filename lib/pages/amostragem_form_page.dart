import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_app/models/amostragem_model.dart';
import 'package:sms_app/print/amostragem_print.dart';
import 'package:sms_app/widgets/amostragem/devices_list_item_widget.dart';
import 'package:sms_app/widgets/amostragem/image_input_widget.dart';
import 'amostragem_list_page.dart';
import 'dart:io';
import 'dart:async';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class AmostragemFormPage extends StatefulWidget {
  const AmostragemFormPage({
    Key? key,
    required this.localIdAmostragem,
    required this.idPlanoAmostragem,
  }) : super(key: key);

  final int localIdAmostragem;
  final int idPlanoAmostragem;

  @override
  State<AmostragemFormPage> createState() => _AmostragemFormPageState();
}

class _AmostragemFormPageState extends State<AmostragemFormPage> {
  final _formKey = GlobalKey<FormState>();
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  int bluetoothStatus = 0;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _device;
  bool _connected = false;
  String? pathImage;
  File? _pickedImage;
  AmostragemPrint? amostragemPrint;

  @override
  void initState() {
    super.initState();
    getBluetoothStatus();
    initSavetoPath();
    amostragemPrint = AmostragemPrint();
  }

  initSavetoPath() async {
    //read and write
    //image max 300px X 300px
    const String filename = 'logo_acs_etq.png';
    var bytes = await rootBundle.load("assets/images/logo_acs_etq.png");
    String dir = (await getApplicationDocumentsDirectory()).path;
    writeToFile(bytes, '$dir/$filename');
    setState(() {
      pathImage = '$dir/$filename';
    });
  }

  void submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    Provider.of<AmostragemModel>(
      context,
      listen: false,
    ).items[widget.localIdAmostragem].image = _pickedImage;

    Provider.of<AmostragemModel>(
      context,
      listen: false,
    ).updateAmostragemById(2, widget.localIdAmostragem);

    // _formKey.currentState?.save();
  }

  Future<void> getBluetoothStatus() async {
    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            _connected = true;
            bluetoothStatus = BlueThermalPrinter.CONNECTED;
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            _connected = false;
            print("bluetooth device state: disconnected");
          });
          break;
        case BlueThermalPrinter.DISCONNECT_REQUESTED:
          setState(() {
            _connected = false;
            print("bluetooth device state: disconnect requested");
          });
          break;
        case BlueThermalPrinter.STATE_TURNING_OFF:
          setState(() {
            _connected = false;
            // print("bluetooth device state: bluetooth turning off");
          });
          break;
        case BlueThermalPrinter.STATE_OFF:
          setState(() {
            _connected = false;
            bluetoothStatus = BlueThermalPrinter.STATE_OFF;
            print(bluetoothStatus);
          });
          break;
        case BlueThermalPrinter.STATE_ON:
          setState(() {
            bluetoothStatus = BlueThermalPrinter.STATE_ON;
            print(bluetoothStatus);
          });
          break;
        case BlueThermalPrinter.STATE_TURNING_ON:
          setState(() {
            _connected = false;
            // print("bluetooth device state: bluetooth turning on");
          });
          break;
        case BlueThermalPrinter.ERROR:
          setState(() {
            _connected = false;
            print("bluetooth device state: error");
          });
          break;
        default:
          print(state);
          break;
      }
    });
  }

  Future<void> getDevices() async {
    bool? isConnected = await bluetooth.isConnected;
    List<BluetoothDevice> devices = [];

    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {
      // TODO - Error
    }

    if (!mounted) return;
    setState(() {
      _devices = devices;
    });

    if (isConnected!) {
      setState(() {
        _connected = true;
      });
    }
  }

  void selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  modalBottomSheet() {}

  @override
  Widget build(BuildContext context) {
    AmostragemModel amostragemData = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulário"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              submitForm();

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AmostragemListPage(
                    reloaded: true,
                    paId: widget.idPlanoAmostragem,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.check),
          )
        ],
        leading: IconButton(
          onPressed: () {
            showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Atenção'),
                content: const Text(
                    'Os dados referente a está amostragem não serão salvos e seu status ficara como pendente. \n\n Deseja continuar?'),
                actions: [
                  TextButton(
                    child: const Text('Não'),
                    onPressed: () => Navigator.of(ctx).pop(false),
                  ),
                  TextButton(
                    child: const Text('Sim'),
                    onPressed: () async {
                      Navigator.of(context).pop(true);

                      Provider.of<AmostragemModel>(
                        context,
                        listen: false,
                      )
                          .updateAmostragemById(1, widget.localIdAmostragem)
                          .then((_) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AmostragemListPage(
                              reloaded: true,
                              paId: widget.idPlanoAmostragem,
                            ),
                          ),
                        );
                      });
                    },
                  ),
                ],
              ),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextFormField(
                initialValue: amostragemData
                    .itemByIndex(widget.localIdAmostragem)
                    .temp_amostra,
                onSaved: (temp_amostra) => amostragemData
                    .items[widget.localIdAmostragem]
                    .temp_amostra = temp_amostra,
                validator: (_temp_amostra) {
                  final temp_amostra = _temp_amostra ?? '';

                  if (temp_amostra.contains('.')) {
                    return 'Favor não utilizar "."';
                  }

                  return null;
                },
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
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
              padding: const EdgeInsets.only(top: 20.0),
              child: TextFormField(
                validator: (_temp_amostra) {
                  final temp_amostra = _temp_amostra ?? '';

                  if (temp_amostra.contains('.')) {
                    return 'Favor não utilizar "."';
                  }

                  return null;
                },
                initialValue: amostragemData
                    .itemByIndex(widget.localIdAmostragem)
                    .temp_equipamento,
                onSaved: (temp_equipamento) => amostragemData
                    .items[widget.localIdAmostragem]
                    .temp_equipamento = temp_equipamento,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
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
              padding: const EdgeInsets.only(top: 15.0),
              child: TextFormField(
                validator: (_temp_amostra) {
                  final temp_amostra = _temp_amostra ?? '';

                  if (temp_amostra.contains('.')) {
                    return 'Favor não utilizar "."';
                  }

                  return null;
                },
                initialValue: amostragemData
                    .itemByIndex(widget.localIdAmostragem)
                    .temp_enrolamento,
                onSaved: (temp_enrolamento) => amostragemData
                    .items[widget.localIdAmostragem]
                    .temp_enrolamento = temp_enrolamento,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
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
                validator: (_temp_amostra) {
                  final temp_amostra = _temp_amostra ?? '';

                  if (temp_amostra.contains('.')) {
                    return 'Favor não utilizar "."';
                  }

                  return null;
                },
                initialValue: amostragemData
                    .itemByIndex(widget.localIdAmostragem)
                    .temp_ambiente,
                onSaved: (temp_ambiente) => amostragemData
                    .items[widget.localIdAmostragem]
                    .temp_ambiente = temp_ambiente,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
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
                validator: (_temp_amostra) {
                  final temp_amostra = _temp_amostra ?? '';

                  if (temp_amostra.contains('.')) {
                    return 'Favor não utilizar "."';
                  }

                  return null;
                },
                initialValue: amostragemData
                    .itemByIndex(widget.localIdAmostragem)
                    .umidade_relativa,
                onSaved: (umidade_relativa) => amostragemData
                    .items[widget.localIdAmostragem]
                    .umidade_relativa = umidade_relativa,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
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
                initialValue: amostragemData
                    .itemByIndex(widget.localIdAmostragem)
                    .observacao,
                onSaved: (observacao) => amostragemData
                    .items[widget.localIdAmostragem].observacao = observacao,
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
              padding: const EdgeInsets.only(top: 15.0, bottom: 30.00),
              child: Card(
                color: Colors.blue[50],
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: SwitchListTile(
                    contentPadding: EdgeInsets.all(6),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: amostragemData
                        .itemByIndex(widget.localIdAmostragem)
                        .equipamento_energizado!,
                    secondary: const Icon(Icons.battery_unknown_outlined),
                    title: const Text("Equipamento Energizado?"),
                    onChanged: (value) {
                      setState(() {
                        amostragemData
                            .itemByIndex(widget.localIdAmostragem)
                            .equipamento_energizado = value;
                        amostragemData.notifyListeners();
                      });
                    }),
              ),
            ),
            // ImageInputWidget(
            //   onSelectImage: selectImage,
            //   storedImage:
            //       amostragemData.itemByIndex(widget.localIdAmostragem).image,
            // ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () async {
                submitForm();

                print(bluetoothStatus);

                if (_connected) {
                  printPaper(
                    amostragemData.itemByIndex(widget.localIdAmostragem),
                  );
                  return;
                }

                await getDevices();

                showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                  ),
                  context: context,
                  builder: (_) {
                    return Column(
                      children: [
                        Stack(children: [
                          const SizedBox(
                            width: double.infinity,
                            height: 56.0,
                            child: Center(
                                child: Text(
                              "Selecione uma impressora",
                              style: TextStyle(fontSize: 17),
                            ) // Your desired title
                                ),
                          ),
                          Positioned(
                            left: 0.0,
                            top: 0.0,
                            child: IconButton(
                              icon:
                                  const Icon(Icons.close), // Your desired icon
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          )
                        ]),
                        Expanded(
                          child: bluetoothStatus != 12
                              ? const Center(
                                  child: Text(
                                    "Favor ligar o bluetooth",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.all(10),
                                  itemCount: _devices.length,
                                  itemBuilder: (ctx, index) {
                                    return DevicesListItemWidget(
                                      device: _devices[index].name ??
                                          "Dispositivo Sem Nome",
                                      index: index,
                                      selectDevice: selectDevice,
                                      localIdAmostragem:
                                          widget.localIdAmostragem,
                                    );
                                  },
                                ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Icon(Icons.print_rounded, color: Colors.white),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
                onPrimary: Colors.indigo[900],
              ),
            )
          ],
        ),
      ),
    );
  }

  void selectDevice(int index, data) {
    _device = _devices[index];
    _connect();
    printPaper(data);
  }

  void _connect() {
    if (_device == null) {
    } else {
      bluetooth.isConnected.then((isConnected) {
        if (!isConnected!) {
          bluetooth.connect(_device!).catchError((error) {
            setState(() => _connected = false);
          });
          setState(() => _connected = true);
        }
      });
    }
  }

  printPaper(data) {
    amostragemPrint!.printPage(pathImage!, data);
    return;
  }

  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}
