import 'package:json_annotation/json_annotation.dart';

enum ChatroomMessageType {
  @JsonValue("generalRoom")
  generalRoom,
  @JsonValue("customizeRoom")
  customizeRoom,
  @JsonValue("privateRoom")
  privateRoom,
}
