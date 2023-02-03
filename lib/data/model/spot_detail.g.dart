// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpotDetail _$SpotDetailFromJson(Map<String, dynamic> json) => $checkedCreate(
      'SpotDetail',
      json,
      ($checkedConvert) {
        final val = SpotDetail(
          about: $checkedConvert('about', (v) => v as String?),
          address: $checkedConvert('address', (v) => v as String?),
          comments: $checkedConvert(
              'comments',
              (v) => v == null
                  ? null
                  : Comments.fromJson(v as Map<String, dynamic>)),
          description: $checkedConvert('description', (v) => v as String?),
          distance: $checkedConvert('distance', (v) => v as int?),
          favoriteCount: $checkedConvert('favorite_count', (v) => v as int?),
          id: $checkedConvert('id', (v) => v as int?),
          imageFullsize: $checkedConvert('image_fullsize', (v) => v as String?),
          imageThumbnail:
              $checkedConvert('image_thumbnail', (v) => v as String?),
          imagesCollection: $checkedConvert('images_collection',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          isClosed: $checkedConvert('is_closed', (v) => v as bool?),
          isFavorite: $checkedConvert('is_favorite', (v) => v as bool?),
          isRecommended: $checkedConvert('is_recommended', (v) => v as bool?),
          isVisited: $checkedConvert('is_visited', (v) => v as bool?),
          latitude: $checkedConvert('latitude', (v) => (v as num?)?.toDouble()),
          longitude:
              $checkedConvert('longitude', (v) => (v as num?)?.toDouble()),
          nextReward: $checkedConvert('next_reward', (v) => v as int?),
          nextRewardLevel:
              $checkedConvert('next_reward_level', (v) => v as int?),
          openingHours: $checkedConvert('opening_hours', (v) => v as String?),
          pricing: $checkedConvert('pricing', (v) => v as String?),
          tagsCategory: $checkedConvert(
              'tags_category',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => SpotCategory.fromJson(e as Map<String, dynamic>))
                  .toList()),
          title: $checkedConvert('title', (v) => v as String?),
          website: $checkedConvert('website', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'favoriteCount': 'favorite_count',
        'imageFullsize': 'image_fullsize',
        'imageThumbnail': 'image_thumbnail',
        'imagesCollection': 'images_collection',
        'isClosed': 'is_closed',
        'isFavorite': 'is_favorite',
        'isRecommended': 'is_recommended',
        'isVisited': 'is_visited',
        'nextReward': 'next_reward',
        'nextRewardLevel': 'next_reward_level',
        'openingHours': 'opening_hours',
        'tagsCategory': 'tags_category'
      },
    );

Map<String, dynamic> _$SpotDetailToJson(SpotDetail instance) =>
    <String, dynamic>{
      'about': instance.about,
      'address': instance.address,
      'comments': instance.comments?.toJson(),
      'description': instance.description,
      'distance': instance.distance,
      'favorite_count': instance.favoriteCount,
      'id': instance.id,
      'image_fullsize': instance.imageFullsize,
      'image_thumbnail': instance.imageThumbnail,
      'images_collection': instance.imagesCollection,
      'is_closed': instance.isClosed,
      'is_favorite': instance.isFavorite,
      'is_recommended': instance.isRecommended,
      'is_visited': instance.isVisited,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'next_reward': instance.nextReward,
      'next_reward_level': instance.nextRewardLevel,
      'opening_hours': instance.openingHours,
      'pricing': instance.pricing,
      'tags_category': instance.tagsCategory?.map((e) => e.toJson()).toList(),
      'title': instance.title,
      'website': instance.website,
    };
