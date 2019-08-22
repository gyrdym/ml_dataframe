import 'package:ml_dataframe/src/data_frame/factories/from_raw_data.dart';
import 'package:ml_dataframe/src/data_frame/data_frame_impl.dart';
import 'package:ml_dataframe/src/data_frame/series.dart';
import 'package:ml_dataframe/src/numerical_converter/numerical_converter_impl.dart';
import 'package:ml_linalg/dtype.dart';
import 'package:ml_linalg/linalg.dart';
import 'package:ml_linalg/matrix.dart';

/// A structure to store and manipulate data
abstract class DataFrame {
  /// Creates a data frame from non-typed data.
  ///
  /// [data] Non-typed data, the first element may be a header of dataset (a
  /// collection of strings)
  ///
  /// [headerExists] Indicates, whether the csv-file header (a sequence of
  /// column names) exists or not
  factory DataFrame(
      Iterable<Iterable<dynamic>> data,
      {
        bool headerExists = true,
        Iterable<String> header,
        String autoHeaderPrefix = 'col_',
        Iterable<int> columns,
        Iterable<String> columnNames,
        DType dtype = DType.float32,
      }
  ) => fromRawData(
    data,
    headerExists: headerExists,
    header: header,
    autoHeaderPrefix: autoHeaderPrefix,
    columns: columns,
    columnNames: columnNames,
    dtype: dtype,
  );

  factory DataFrame.fromSeries(
      Iterable<Series> series,
      {
        DType dtype = DType.float32,
      }
  ) => DataFrameImpl.fromSeries(
      series,
      NumericalConverterImpl(false),
      dtype,
  );

  Iterable<String> get header;

  Iterable<Iterable<dynamic>> get rows;

  Iterable<Series> get series;

  Map<String, Series> get seriesByName;

  /// Converts the data_frame into Matrix
  Matrix toMatrix();
}
