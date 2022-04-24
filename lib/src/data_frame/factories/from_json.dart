import 'dart:convert';
import 'dart:io';

import 'package:ml_dataframe/src/data_frame/data_frame.dart';
import 'package:ml_dataframe/src/data_frame/data_frame_impl.dart';

/// Creates a [DataFrame] instance from a previously persisted json file
///
/// A usage example:
///
/// ```dart
/// import 'package:ml_dataframe/ml_dataframe.dart';
///
/// void main() async {
///   final data = DataFrame([
///     ['feature_1', 'feature_2', 'feature_3'],
///     [1, 10, 100],
///     [2, 20, 200],
///     [3, 30, 300],
///   ]);
///
///   await data.saveAsJson('path/to/json_file.json');
///
///   // ...
///
///   final restoredDataFrame = await fromJson('path/to/json_file.json');
///
///   print(restoredDataFrame);
///   // DataFrame (3 x 3)
///   // feature_1 feature_2 feature_3
///   //         1        10       100
///   //         2        20       200
///   //         3        30       300
/// }
/// ```
Future<DataFrame> fromJson(String fileName) async {
  final file = File(fileName);
  final dataAsString = await file.readAsString();
  final decoded = jsonDecode(dataAsString) as Map<String, dynamic>;

  return DataFrameImpl.fromJson(decoded);
}
