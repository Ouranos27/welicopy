import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weli/service/model/converter/converter.dart';

part 'profile.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class Profile {
  String? id;
  String? phoneNumber;
  String? entreprise;
  String? firstName;
  String? job;
  int? numberOfMessagesUnread;
  String? email;
  String? userName;
  @TimestampConverter()
  DateTime? created;
  int? numberOfNotificationsUnread;
  String? city;
  String? type;
  String? lastName;
  String? department;
  List<String>? investment;
  List<String>? goods;
  String? pictureUrl;
  List<String> deviceToken;

  Profile({
    this.deviceToken = const [],
    this.phoneNumber,
    this.id,
    this.entreprise,
    this.firstName,
    this.userName,
    this.job,
    this.numberOfMessagesUnread,
    this.email,
    this.created,
    this.numberOfNotificationsUnread,
    this.city,
    this.department,
    this.investment,
    this.goods,
    this.type,
    this.pictureUrl,
    this.lastName,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
