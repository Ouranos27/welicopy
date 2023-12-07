// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      deviceToken: (json['deviceToken'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      phoneNumber: json['phoneNumber'] as String?,
      id: json['id'] as String?,
      entreprise: json['entreprise'] as String?,
      firstName: json['firstName'] as String?,
      userName: json['userName'] as String?,
      job: json['job'] as String?,
      numberOfMessagesUnread: json['numberOfMessagesUnread'] as int?,
      email: json['email'] as String?,
      created:
          const TimestampConverter().fromJson(json['created'] as Timestamp?),
      numberOfNotificationsUnread: json['numberOfNotificationsUnread'] as int?,
      city: json['city'] as String?,
      department: json['department'] as String?,
      investment: (json['investment'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      goods:
          (json['goods'] as List<dynamic>?)?.map((e) => e as String).toList(),
      type: json['type'] as String?,
      pictureUrl: json['pictureUrl'] as String?,
      lastName: json['lastName'] as String?,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.id,
      'phoneNumber': instance.phoneNumber,
      'entreprise': instance.entreprise,
      'firstName': instance.firstName,
      'job': instance.job,
      'numberOfMessagesUnread': instance.numberOfMessagesUnread,
      'email': instance.email,
      'userName': instance.userName,
      'created': const TimestampConverter().toJson(instance.created),
      'numberOfNotificationsUnread': instance.numberOfNotificationsUnread,
      'city': instance.city,
      'type': instance.type,
      'lastName': instance.lastName,
      'department': instance.department,
      'investment': instance.investment,
      'goods': instance.goods,
      'pictureUrl': instance.pictureUrl,
      'deviceToken': instance.deviceToken,
    };
