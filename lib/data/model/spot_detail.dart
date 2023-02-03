import 'package:json_annotation/json_annotation.dart';
import 'package:spots_discovery/data/model/category.dart';

import 'comments.dart';

part 'spot_detail.g.dart';

@JsonSerializable(
    checked: true, explicitToJson: true, fieldRename: FieldRename.snake)
class SpotDetail {
  String? about;
  String? address;
  Comments? comments;
  String? description;
  int? distance;
  int? favoriteCount;
  int? id;
  String? imageFullsize;
  String? imageThumbnail;
  List<String>? imagesCollection;
  bool? isClosed;
  bool? isFavorite;
  bool? isRecommended;
  bool? isVisited;
  double? latitude;
  double? longitude;
  int? nextReward;
  int? nextRewardLevel;
  String? openingHours;
  String? pricing;
  List<SpotCategory>? tagsCategory;
  String? title;
  String? website;

  SpotDetail({
    this.about,
    this.address,
    this.comments,
    this.description,
    this.distance,
    this.favoriteCount,
    this.id,
    this.imageFullsize,
    this.imageThumbnail,
    this.imagesCollection,
    this.isClosed,
    this.isFavorite,
    this.isRecommended,
    this.isVisited,
    this.latitude,
    this.longitude,
    this.nextReward,
    this.nextRewardLevel,
    this.openingHours,
    this.pricing,
    this.tagsCategory,
    this.title,
    this.website,
  });

  factory SpotDetail.fromJson(Map<String, dynamic> json) =>
      _$SpotDetailFromJson(json);

  Map<String, dynamic> toJson() => _$SpotDetailToJson(this);
}
