import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weli/service/model/converter/converter.dart';

part 'card.g.dart';

@JsonSerializable(includeIfNull: true, explicitToJson: true)
class CardData {
  String? profitability;
  String? propertyType;
  String? propertyState;
  String? title;
  List<String>? labels;
  String? livingSpace;
  String? numberOfBatches;
  String? stateOfGoods;
  String? location;
  String? userId;
  String? landArea;
  String? price;
  String? pricePerSquareMeters;
  List<String>? investment;
  String? buyerType;
  String? investmentDuration;
  @TimestampConverter()
  DateTime? submittedAt;
  @TimestampConverter()
  DateTime? modifiedAt;
  @TimestampConverter()
  DateTime? createdAt;
  List<String>? moreDetails;
  List<String>? goods;
  String? pictureUrl;
  String? id;

  String get pricePerLandArea {
    try {
      if (price == null || landArea == null) {
        return '';
      } else {
        return (double.parse(price!) ~/ double.parse(landArea!)).toString();
      }
    } catch (e) {
      return '';
    }
  }

  CardData({
    this.id,
    this.profitability,
    this.propertyType,
    this.propertyState,
    this.labels,
    this.livingSpace,
    this.numberOfBatches,
    this.price,
    this.location,
    this.userId,
    this.landArea,
    this.investment,
    this.buyerType,
    this.investmentDuration,
    this.createdAt,
    this.modifiedAt,
    this.submittedAt,
    this.title,
    this.stateOfGoods,
    this.moreDetails,
    this.goods,
    this.pricePerSquareMeters,
    this.pictureUrl,
  });

  factory CardData.fromJson(Map<String, dynamic> json) => _$CardDataFromJson(json);

  Map<String, dynamic> toJson() => _$CardDataToJson(this);
}

