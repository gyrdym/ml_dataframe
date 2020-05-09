// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Series _$SeriesFromJson(Map<String, dynamic> json) {
  return $checkedNew('Series', json, () {
    $checkKeys(json, allowedKeys: const ['N', 'D', 'isDiscrete']);
    final val = Series(
      $checkedConvert(json, 'N', (v) => v as String),
      $checkedConvert(json, 'D', (v) => v as List),
      isDiscrete: $checkedConvert(json, 'isDiscrete', (v) => v as bool),
    );
    return val;
  }, fieldKeyMap: const {'name': 'N', 'data': 'D'});
}

Map<String, dynamic> _$SeriesToJson(Series instance) => <String, dynamic>{
      'N': instance.name,
      'D': instance.data?.toList(),
      'isDiscrete': instance.isDiscrete,
    };
