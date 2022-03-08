import 'dart:io';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';

class AmostragemPrint {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  final String now =
      "${DateTime.now().day.toString().padLeft(2, '0')}/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().year.toString()} ${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}";
  printPage(String pathImageLogo, pathImageBarCode, data) async {
    //SIZE
    // 0- normal size text
    // 1- only bold text
    // 2- bold with medium text
    // 3- bold with large text
    //ALIGN
    // 0- ESC_ALIGN_LEFT
    // 1- ESC_ALIGN_CENTER
    // 2- ESC_ALIGN_RIGHT

//     var response = await http.get("IMAGE_URL");
//     Uint8List bytes = response.bodyBytes;
    bluetooth.isConnected.then((isConnected) {
      if (isConnected!) {
        bluetooth.printImage(pathImageLogo); //path of your image/logo
        bluetooth.printNewLine();
        bluetooth.printCustom("Acs Laboratorios", 4, 1);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printCustom("--------------------------------", 1, 1);
        bluetooth.printNewLine();
//      bluetooth.printImageBytes(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
        bluetooth.printCustom(
            "${data.serie == "Sem Informação" ? "S/I" : data.serie} | ${data.tag == "SEM INFORMAÇÃO" ? "S/I" : data.tag} | ${data.sub_estacao == "Sem Informação" ? "S/I" : data.sub_estacao}",
            1,
            1);
        bluetooth.printNewLine();
        bluetooth.printCustom(now, 1, 1);

        bluetooth.printNewLine();
        bluetooth.printCustom("--------------------------------", 1, 1);
        bluetooth.printNewLine();
        bluetooth.printLeftRight("T. Amostra:", "${data.temp_amostra} C", 3);
        bluetooth.printNewLine();
        bluetooth.printLeftRight(
            "T. Equipamento:", "${data.temp_equipamento} C", 3);
        bluetooth.printNewLine();
        bluetooth.printLeftRight(
            "T. Enrolamento:", "${data.temp_enrolamento} C", 3);
        bluetooth.printNewLine();
        bluetooth.printLeftRight("T. Ambiente:", "${data.temp_ambiente} C", 3);
        bluetooth.printNewLine();
        bluetooth.printLeftRight(
            "T. Umidade:", "${data.umidade_relativa} C", 3);
        bluetooth.printNewLine();
        bluetooth.printCustom("--------------------------------", 1, 1);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printImage(pathImageBarCode);
        bluetooth.printNewLine();
        bluetooth.printCustom("--------------------------------", 1, 1);
        bluetooth.printNewLine();
        bluetooth.printQRcode(
            "https://labmetrix.com.br/etq.php?p=${data.cod_barras}",
            200,
            200,
            1);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.paperCut();
      }
    });
  }
}
