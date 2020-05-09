// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'numerical_converter_impl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NumericalConverterImpl _$NumericalConverterImplFromJson(
    Map<String, dynamic> json) {
  return $checkedNew('NumericalConverterImpl', json, () {
    $checkKeys(json, allowedKeys: const ['S']);
    final val = NumericalConverterImpl(
      $checkedConvert(json, 'S', (v) => v as bool),
    );
    return val;
  }, fieldKeyMap: const {'strictTypeCheck': 'S'});
}

Map<String, dynamic> _$NumericalConverterImplToJson(
        NumericalConverterImpl instance) =>
    <String, dynamic>{
      'S': instance.strictTypeCheck,
    };
