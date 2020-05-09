import 'package:json_annotation/json_annotation.dart';
import 'package:ml_dataframe/src/data_frame/series_json_keys.dart';

part 'series.g.dart';

@JsonSerializable()
class Series {
  Series(this.name, this.data, {
    bool isDiscrete = false,
  }) : discreteValues = isDiscrete
      ? Set<dynamic>.from(data)
      : const <dynamic>[];

  /// A name of the [Series]
  @JsonKey(name: nameJsonKey)
  final String name;

  /// Return a lazy iterable of data, containing in the [Series]
  @JsonKey(name: dataJsonKey)
  final Iterable data;

  /// Returns a lazy iterable of the [data]'s unique values if the [Series]
  /// marked as [isDiscrete]. If [isDiscrete] is `false`, an empty list will be
  /// returned
  @JsonKey(name: discreteValuesJsonKey)
  final Iterable discreteValues;

  /// Shows if [Series] contains just discrete values instead of continuous ones
  bool get isDiscrete => discreteValues.isNotEmpty;
}
