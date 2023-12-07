// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalonLightData _$SalonLightDataFromJson(Map<String, dynamic> json) =>
    SalonLightData(
      type: $enumDecode(_$ChatroomMessageTypeEnumMap, json['type']),
      id: json['id'] as String,
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
      lastMessage: json['lastMessage'] as String?,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
      creator: json['creator'] as String?,
      members: (json['members'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SalonLightDataToJson(SalonLightData instance) =>
    <String, dynamic>{
      'type': _$ChatroomMessageTypeEnumMap[instance.type],
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'lastMessage': instance.lastMessage,
      'members': instance.members,
      'creator': instance.creator,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };

const _$ChatroomMessageTypeEnumMap = {
  ChatroomMessageType.generalRoom: 'generalRoom',
  ChatroomMessageType.customizeRoom: 'customizeRoom',
  ChatroomMessageType.privateRoom: 'privateRoom',
};

MessageData _$MessageDataFromJson(Map<String, dynamic> json) => MessageData(
      text: json['text'] as String?,
      sendDate:
          const TimestampConverter().fromJson(json['sendDate'] as Timestamp?),
      senderData: json['senderData'] == null
          ? null
          : Profile.fromJson(json['senderData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageDataToJson(MessageData instance) =>
    <String, dynamic>{
      'text': instance.text,
      'sendDate': const TimestampConverter().toJson(instance.sendDate),
      'senderData': instance.senderData?.toJson(),
    };

MessageLightData _$MessageLightDataFromJson(Map<String, dynamic> json) =>
    MessageLightData(
      text: json['text'] as String?,
      sendDate:
          const TimestampConverter().fromJson(json['sendDate'] as Timestamp?),
      senderData: json['senderData'] as String?,
    );

Map<String, dynamic> _$MessageLightDataToJson(MessageLightData instance) =>
    <String, dynamic>{
      'text': instance.text,
      'sendDate': const TimestampConverter().toJson(instance.sendDate),
      'senderData': instance.senderData,
    };
