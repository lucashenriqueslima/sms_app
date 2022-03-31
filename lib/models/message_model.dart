import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:sms_app/class/amostragem_class.dart';
import 'package:sms_app/db/db.dart';
import 'package:sms_app/class/message_class.dart';

class MessageModel with ChangeNotifier {
  List<MessageClass> items = [];

  int get itemsCount {
    return items.length;
  }

  int get itemsByStatus {
    return items.where((element) => element.status == 1).length;
  }

  Future<void> loadMessage() async {
    DB.select("SELECT * FROM message").then((value) {
      for (int i = 0; i < value.length; i++) {
        items.add(MessageClass(
          localIdMessage: value[i]['localIdMessage'],
          module: value[i]['module'],
          type: value[i]['type'],
          message: value[i]['message'],
          subMessage: value[i]['subMessage'],
          status: value[i]['status'],
        ));
      }
    });

    notifyListeners();
  }

  Future<void> setReadedMessage(localIdMessage) async {
    DB.update(
        "UPDATE message SET status = 0 WHERE localIdMessage = $localIdMessage");
    items
        .where((element) => element.localIdMessage == localIdMessage)
        .toList()[0]
        .status = 0;

    notifyListeners();
  }

  Future<void> deleteMessage(localIdMessage) async {
    DB.delete("DELETE FROM message WHERE localIdMessage = $localIdMessage");
  }
}
