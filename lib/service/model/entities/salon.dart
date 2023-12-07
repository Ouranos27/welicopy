import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weli/page/message/page/type.dart';
import 'package:weli/service/model/converter/converter.dart';
import 'package:weli/service/model/entities/profile.dart';

part 'salon.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class SalonLightData {
  ChatroomMessageType type;
  String id;
  String? name;
  String? imageUrl;
  String? lastMessage;
  List<String> members;
  String? creator;
  @TimestampConverter()
  DateTime? createdAt;

  SalonLightData({
    required this.type,
    required this.id,
    this.name,
    this.imageUrl,
    this.lastMessage,
    this.createdAt,
    this.creator,
    this.members = const [],
  });

  factory SalonLightData.fromJson(Map<String, dynamic> json) => _$SalonLightDataFromJson(json);

  Map<String, dynamic> toJson() => _$SalonLightDataToJson(this);
}

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class MessageData {
  String? text;
  @TimestampConverter()
  DateTime? sendDate;
  Profile? senderData;

  MessageData({this.text, this.sendDate, this.senderData});

  factory MessageData.fromJson(Map<String, dynamic> json) => _$MessageDataFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDataToJson(this);
}

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class MessageLightData {
  String? text;
  @TimestampConverter()
  DateTime? sendDate;
  String? senderData;

  MessageLightData({this.text, this.sendDate, this.senderData});

  factory MessageLightData.fromJson(Map<String, dynamic> json) => _$MessageLightDataFromJson(json);

  Map<String, dynamic> toJson() => _$MessageLightDataToJson(this);
}
