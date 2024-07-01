import 'dart:convert';

class MessageModel {
  String type;
  String message;
  String time;
  MessageModel({required this.message, required this.type, required this.time});
}
// To parse this JSON data, do
//
//     final getSingleMsgModel = getSingleMsgModelFromJson(jsonString);


