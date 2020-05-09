// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'numerical_converter_impl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NumericalConverterImpl _$NumericalConverterImplFromJson(
    Map<String, dynamic> json) {
  return $checkedNew('NumericalConverterImpl', json, () {
    $checkKeys(json, allowedKeys: const ['ST']);
    final val = NumericalConverterImpl(
      $checkedConvert(json, 'ST', (v) => v as bool),
    );
    return val;
  }, fieldKeyMap: const {'strictTypeCheck': 'ST'});
}

Map<String, dynamic> _$NumericalConverterImplToJson(
        NumericalConverterImpl instance) =>
    <String, dynamic>{
      'ST': instance.strictTypeCheck,
    };
