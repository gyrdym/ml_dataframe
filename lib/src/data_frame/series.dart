import 'package:json_annotation/json_annotation.dart';
import 'package:ml_dataframe/src/data_frame/series_json_keys.dart';

part 'series.g.dart';

@JsonSerializable()
class Series {
  Series(this.name, this.data, {
    this.isDiscrete = false,
  }) : discreteValues = isDiscrete
      ? Set<dynamic>.from(data)
      : const <dynamic>[];

  factory Series.fromJson(Map<String, dynamic> json) => _$SeriesFromJson(json);

  Map<String, dynamic> toJson() => _$SeriesToJson(this);

  /// A name of the [Series]
  @JsonKey(name: seriesNameJsonKey)
  final String name;

  /// Returns a lazy iterable of data containing in the [Series]
  @JsonKey(name: seriesDataJsonKey)
  final Iterable data;

  /// Returns true if the [Series] contains just discrete values instead of
  /// continuous ones
  @JsonKey(name: isSeriesDiscreteJsonKey)
  final bool isDiscrete;

  /// Returns a lazy iterable of the [data]'s unique values if the [Series]
  /// marked as [isDiscrete]. If [isDiscrete] is `false`, an empty list will be
  /// returned
  final Iterable discreteValues;
}
