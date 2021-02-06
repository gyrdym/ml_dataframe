import 'package:json_annotation/json_annotation.dart';
import 'package:ml_dataframe/src/data_frame/data_frame.dart';
import 'package:ml_dataframe/src/numerical_converter/numerical_converter.dart';
import 'package:ml_dataframe/src/numerical_converter/numerical_converter_json_keys.dart';

part 'numerical_converter_impl.g.dart';

@JsonSerializable()
class NumericalConverterImpl implements NumericalConverter {
  const NumericalConverterImpl(this.strictTypeCheck);

  factory NumericalConverterImpl.fromJson(Map<String, dynamic> json) =>
      _$NumericalConverterImplFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NumericalConverterImplToJson(this);

  @JsonKey(name: strictTypeCheckJsonKey)
  final bool strictTypeCheck;

  static final Exception _exception =
    Exception('Unsuccessful attempt to convert a value to number');

  @override
  DataFrame convertDataFrame(DataFrame data) =>
    DataFrame(convertRawData(data.rows), header: data.header);

  @override
  Iterable<Iterable<double>> convertRawData(Iterable<Iterable> data) =>
    data.map((row) => row.map(_convertSingle));

  double _convertSingle(dynamic value) {
    if (value is String) {
      try {
        return double.parse(value);
      } catch (e) {
        if (strictTypeCheck) {
          throw _exception;
        }

        return null;
      }
    }

    if (value is bool) {
      if (strictTypeCheck) {
        throw _exception;
      }

      return value ? 1 : 0;
    }

    if (value is! num) {
      if (strictTypeCheck) {
        throw _exception;
      }

      return null;
    }

    return value * 1.0 as double;
  }
}
