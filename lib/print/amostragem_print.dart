import 'package:blue_thermal_printer/blue_thermal_printer.dart';

class AmostragemPrint {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  final String now =
      "${DateTime.now().day.toString().padLeft(2, '0')}/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().year.toString()} ${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}";
  printPage(String pathImageLogo, pathImageBarCode, dataAmostragem,
      dataPlanoAmostragem) async {
    String removeAcentos(str) {
      String comAcento = 'ÁÂÃáâãÓÔÕóôÉÊéêÇçÍíÚú';
      String semAcento = 'AAAaaaOOOooEEeeCcIiUu';

      for (int i = 0; i < comAcento.length; i++) {
        str = str.replaceAll(comAcento[i], semAcento[i]);
      }

      return str;
    }

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
        bluetooth.printCustom(
            removeAcentos(dataPlanoAmostragem[0].razaoSocial), 2, 1);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printCustom(
            removeAcentos(dataPlanoAmostragem[0].nomeFantasia), 2, 1);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printCustom(dataPlanoAmostragem[0].amostrador, 2, 1);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printCustom(
            "${removeAcentos(dataPlanoAmostragem[0].city)} - ${dataPlanoAmostragem[0].state}",
            2,
            1);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printCustom(
            "${dataAmostragem.serie == "SEM INFORMAÇÃO" ? "S/I" : removeAcentos(dataAmostragem.serie)} | ${dataAmostragem.tag == "SEM INFORMAÇÃO" ? "S/I" : removeAcentos(dataAmostragem.tag)} | ${dataAmostragem.sub_estacao == "SEM INFORMAÇÃO" ? "S/I" : removeAcentos(dataAmostragem.sub_estacao)}",
            1,
            1);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printCustom(now, 1, 1);

        bluetooth.printNewLine();
        bluetooth.printCustom("--------------------------------", 1, 1);
        bluetooth.printNewLine();
        bluetooth.printLeftRight(
            "T. Amostra:",
            "${dataAmostragem.temp_amostra.isEmpty ? "" : "${dataAmostragem.temp_amostra} C"}",
            3);
        bluetooth.printNewLine();
        bluetooth.printLeftRight(
            "T. Equipamento:",
            "${dataAmostragem.temp_equipamento.isEmpty ? "" : "${dataAmostragem.temp_equipamento} C"}",
            3);
        bluetooth.printNewLine();
        bluetooth.printLeftRight(
            "T. Enrolamento:",
            "${dataAmostragem.temp_enrolamento.isEmpty ? "" : "${dataAmostragem.temp_enrolamento} C"}",
            3);
        bluetooth.printNewLine();
        bluetooth.printLeftRight(
            "T. Ambiente:",
            "${dataAmostragem.temp_ambiente.isEmpty ? "" : "${dataAmostragem.temp_ambiente} C"}",
            3);
        bluetooth.printNewLine();
        bluetooth.printLeftRight(
            "Umidade:", "${dataAmostragem.umidade_relativa}", 3);
        bluetooth.printNewLine();
        bluetooth.printLeftRight("E. Energizado:",
            "${dataAmostragem.equipamento_energizado ? "S" : "N"}", 3);
        bluetooth.printNewLine();
        bluetooth.printCustom("--------------------------------", 1, 1);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printImage(pathImageBarCode);
        bluetooth.printNewLine();
        bluetooth.printCustom("--------------------------------", 1, 1);
        bluetooth.printNewLine();
        bluetooth.printQRcode(
            "https://systrafo.com.br/etq.php?p=${dataAmostragem.cod_barras}",
            200,
            200,
            1);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.paperCut();
      }
    });
  }
}
