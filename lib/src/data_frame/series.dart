import 'package:ml_dataframe/src/data_frame/data_frame.dart';
import 'package:ml_dataframe/src/data_frame/series_impl.dart';

/// A column of the [DataFrame].
///
/// [name] A column name
///
/// [data] A collection of dynamically typed data
///
/// [isDiscrete] Whether the data is discrete or not. If [isDiscrete] is `true`,
/// unique values from the [data] will be extracted and saved to
/// [discreteValues] field
///
/// Discrete values are elements from a finite set of values. Examples of
/// discrete values:
///
/// - Blood group. Possible values are A, B, AB and O
///
/// - Size. Possible values are XS, S, M, L, XL
///
/// Usage examples:
///
/// - A series with discrete values
///
/// ```dart
/// import 'package:ml_dataframe/ml_dataframe';
///
/// void main() {
///   final series = Series('super_series', [1, 4, 3, 1, 4, 3], isDiscrete: true);
///
///   print(series);
///   // super_series: [1, 4, 3, 1, 4, 3]
///
///   print(series.discreteValues);
///   // [1, 4, 3]
/// }
/// ```
///
/// - A series with continuous values
///
/// ```dart
/// import 'package:ml_dataframe/ml_dataframe';
///
/// void main() {
///   final series = Series('super_series', [1, 14, 3.4, 10, 'some_string', 111, false]);
///
///   print(series);
///   // super_series: [1, 14, 3.4, 10, 'some_string', 111, false]
///
///   print(series.discreteValues);
///   // []
/// }
/// ```
abstract class Series {
  factory Series(
    String name,
    Iterable data, {
    bool isDiscrete,
  }) = SeriesImpl;

  /// Creates a [Series] instance from a json-serializable [Series]
  /// representation
  ///
  /// A usage example:
  ///
  /// ```dart
  /// import 'package:ml_dataframe/ml_dataframe';
  ///
  /// void main() {
  ///   final json = {
  ///     'N': 'awesome_series', // a series' name
  ///     'D': [1, 5, 1, 2, 3, 1, 4], // series' data
  ///     'ISD': true, // whether a series id discrete or not
  ///   };
  ///   final series = Series.fromJson(json);
  ///
  ///   print(series);
  ///   // awesome_series: [1, 5, 1, 2, 3, 1, 4]
  /// }
  /// ```
  ///
  /// One can get the JSON serializable representation by calling [toJson]
  /// method
  factory Series.fromJson(Map<String, dynamic> json) = SeriesImpl.fromJson;

  /// Returns a json-serializable representation of a [Series] instance
  ///
  /// A usage example:
  ///
  /// ```dart
  /// import 'package:ml_dataframe/ml_dataframe';
  ///
  /// void main() {
  ///   final series = Series('super_series', [10, 22, 33, 44]);
  ///   final json = series.toJson();
  ///
  ///   print(json);
  ///   // {'N': 'super_series', 'D': [10, 22, 33, 44], 'ISD': false}
  /// }
  /// ```
  Map<String, dynamic> toJson();

  /// A name of a [Series] instance
  String get name;

  /// Returns a lazy iterable of [Series] instance data
  Iterable get data;

  /// Returns true if a [Series] instance contains just discrete values instead of
  /// continuous ones
  bool get isDiscrete;

  /// Returns a lazy iterable of the [data]'s unique values if a [Series]
  /// instance marked as [isDiscrete]. If [isDiscrete] is `false`, an empty
  /// list will be returned
  Iterable get discreteValues;
}
