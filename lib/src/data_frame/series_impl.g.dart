// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_impl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeriesImpl _$SeriesImplFromJson(Map<String, dynamic> json) {
  return $checkedNew('SeriesImpl', json, () {
    $checkKeys(json, allowedKeys: const ['N', 'D', 'ISD']);
    final val = SeriesImpl(
      $checkedConvert(json, 'N', (v) => v as String),
      $checkedConvert(json, 'D', (v) => v as List<dynamic>),
      isDiscrete: $checkedConvert(json, 'ISD', (v) => v as bool),
    );
    return val;
  }, fieldKeyMap: const {'name': 'N', 'data': 'D', 'isDiscrete': 'ISD'});
}

Map<String, dynamic> _$SeriesImplToJson(SeriesImpl instance) =>
    <String, dynamic>{
      'N': instance.name,
      'D': instance.data.toList(),
      'ISD': instance.isDiscrete,
    };
