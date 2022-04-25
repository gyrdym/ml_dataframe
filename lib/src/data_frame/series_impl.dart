import 'package:json_annotation/json_annotation.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:ml_dataframe/src/data_frame/series_json_keys.dart';

part 'series_impl.g.dart';

/// A column of the [DataFrame].
///
/// [name] A column name
///
/// [data] A collection of dynamically typed data
///
/// [isDiscrete] Whether the data is discrete (categorical) or not. If
/// [isDiscrete] is `true`, unique values from the [data] will be extracted and
/// saved to [discreteValues] field
@JsonSerializable()
class SeriesImpl implements Series {
  SeriesImpl(
    this.name,
    this.data, {
    this.isDiscrete = false,
  }) : discreteValues =
            isDiscrete ? Set<dynamic>.from(data) : const <dynamic>[];

  factory SeriesImpl.fromJson(Map<String, dynamic> json) =>
      _$SeriesImplFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SeriesImplToJson(this);

  /// A name of the [SeriesImpl]
  @override
  @JsonKey(name: seriesNameJsonKey)
  final String name;

  /// Returns a lazy iterable of data containing in the [SeriesImpl]
  @override
  @JsonKey(name: seriesDataJsonKey)
  final Iterable data;

  /// Returns true if the [SeriesImpl] contains just discrete values instead of
  /// continuous ones
  @override
  @JsonKey(name: isSeriesDiscreteJsonKey)
  final bool isDiscrete;

  /// Returns a lazy iterable of the [data]'s unique values if the [SeriesImpl]
  /// marked as [isDiscrete]. If [isDiscrete] is `false`, an empty list will be
  /// returned
  @override
  final Iterable discreteValues;

  @override
  String toString() {
    return '$name: ${data.toString()}';
  }
}
