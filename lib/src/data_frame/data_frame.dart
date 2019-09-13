import 'package:ml_dataframe/src/data_frame/factories/from_matrix.dart';
import 'package:ml_dataframe/src/data_frame/factories/from_raw_data.dart';
import 'package:ml_dataframe/src/data_frame/data_frame_impl.dart';
import 'package:ml_dataframe/src/data_frame/series.dart';
import 'package:ml_dataframe/src/numerical_converter/numerical_converter_impl.dart';
import 'package:ml_linalg/dtype.dart';
import 'package:ml_linalg/linalg.dart';
import 'package:ml_linalg/matrix.dart';

const defaultHeaderPrefix = 'col_';

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
        String autoHeaderPrefix = defaultHeaderPrefix,
        Iterable<int> columns,
        Iterable<String> columnNames,
        DType dtype = DType.float32,
      }
  ) => fromRawData(
    data,
    headerExists: headerExists,
    predefinedHeader: header,
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

  factory DataFrame.fromMatrix(
      Matrix matrix,
      {
        Iterable<String> header,
        String autoHeaderPrefix = defaultHeaderPrefix,
        Iterable<int> columns,
        Iterable<bool> areSeriesDiscrete,
      }
  ) => fromMatrix(
    matrix,
    predefinedHeader: header,
    autoHeaderPrefix: autoHeaderPrefix,
    columns: columns,
    areSeriesDiscrete: areSeriesDiscrete,
  );

  Iterable<String> get header;

  Iterable<Iterable<dynamic>> get rows;

  Iterable<Series> get series;

  Series operator [](Object key);

  /// Converts the data_frame into Matrix
  Matrix toMatrix();
}
