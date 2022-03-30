import 'dart:io';

class MessageClass {
  final int localIdMessage;
  final String module;
  final String type;
  final String message;
  final String subMessage;
  int status;

  MessageClass({
    required this.localIdMessage,
    required this.module,
    required this.type,
    required this.message,
    required this.subMessage,
    required this.status,
  });
}
