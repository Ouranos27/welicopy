// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardData _$CardDataFromJson(Map<String, dynamic> json) => CardData(
      id: json['id'] as String?,
      profitability: json['profitability'] as String?,
      propertyType: json['propertyType'] as String?,
      propertyState: json['propertyState'] as String?,
      labels:
          (json['labels'] as List<dynamic>?)?.map((e) => e as String).toList(),
      livingSpace: json['livingSpace'] as String?,
      numberOfBatches: json['numberOfBatches'] as String?,
      price: json['price'] as String?,
      location: json['location'] as String?,
      userId: json['userId'] as String?,
      landArea: json['landArea'] as String?,
      investment: (json['investment'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      buyerType: json['buyerType'] as String?,
      investmentDuration: json['investmentDuration'] as String?,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
      modifiedAt:
          const TimestampConverter().fromJson(json['modifiedAt'] as Timestamp?),
      submittedAt: const TimestampConverter()
          .fromJson(json['submittedAt'] as Timestamp?),
      title: json['title'] as String?,
      stateOfGoods: json['stateOfGoods'] as String?,
      moreDetails: (json['moreDetails'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      goods:
          (json['goods'] as List<dynamic>?)?.map((e) => e as String).toList(),
      pricePerSquareMeters: json['pricePerSquareMeters'] as String?,
      pictureUrl: json['pictureUrl'] as String?,
    );

Map<String, dynamic> _$CardDataToJson(CardData instance) => <String, dynamic>{
      'profitability': instance.profitability,
      'propertyType': instance.propertyType,
      'propertyState': instance.propertyState,
      'title': instance.title,
      'labels': instance.labels,
      'livingSpace': instance.livingSpace,
      'numberOfBatches': instance.numberOfBatches,
      'stateOfGoods': instance.stateOfGoods,
      'location': instance.location,
      'userId': instance.userId,
      'landArea': instance.landArea,
      'price': instance.price,
      'pricePerSquareMeters': instance.pricePerSquareMeters,
      'investment': instance.investment,
      'buyerType': instance.buyerType,
      'investmentDuration': instance.investmentDuration,
      'submittedAt': const TimestampConverter().toJson(instance.submittedAt),
      'modifiedAt': const TimestampConverter().toJson(instance.modifiedAt),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'moreDetails': instance.moreDetails,
      'goods': instance.goods,
      'pictureUrl': instance.pictureUrl,
      'id': instance.id,
    };
