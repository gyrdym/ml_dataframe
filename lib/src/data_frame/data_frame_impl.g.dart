// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_frame_impl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataFrameImpl _$DataFrameImplFromJson(Map<String, dynamic> json) {
  return $checkedNew('DataFrameImpl', json, () {
    $checkKeys(json, allowedKeys: const ['H', 'R', 'N']);
    final val = DataFrameImpl(
      $checkedConvert(json, 'R',
          (v) => (v as List<dynamic>).map((e) => e as List<dynamic>)),
      $checkedConvert(
          json, 'H', (v) => (v as List<dynamic>).map((e) => e as String)),
      $checkedConvert(json, 'N', (v) => fromNumericalConverterJson(v)),
    );
    return val;
  }, fieldKeyMap: const {'rows': 'R', 'header': 'H', 'toNumberConverter': 'N'});
}

Map<String, dynamic> _$DataFrameImplToJson(DataFrameImpl instance) =>
    <String, dynamic>{
      'H': instance.header.toList(),
      'R': instance.rows.map((e) => e.toList()).toList(),
      'N': numericalConverterToJson(instance.toNumberConverter),
    };
