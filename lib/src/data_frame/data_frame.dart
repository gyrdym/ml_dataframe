import 'package:ml_dataframe/src/data_frame/data_frame_impl.dart';
import 'package:ml_dataframe/src/data_frame/factories/from_matrix.dart';
import 'package:ml_dataframe/src/data_frame/factories/from_raw_data.dart';
import 'package:ml_dataframe/src/data_frame/series.dart';
import 'package:ml_dataframe/src/numerical_converter/numerical_converter_impl.dart';
import 'package:ml_dataframe/src/serializable/serializable.dart';
import 'package:ml_linalg/dtype.dart';
import 'package:ml_linalg/linalg.dart';
import 'package:ml_linalg/matrix.dart';

const defaultHeaderPrefix = 'col_';

/// An in-memory storage to keep data in column-like manner with human readable
/// headers with possibility to convert the data to pure numeric representation.
abstract class DataFrame implements Serializable {
  /// Creates a dataframe from non-typed data.
  ///
  /// [data] Non-typed data that is represented as two-dimensional array,
  /// where each element is a row of data items. The first element of the
  /// two-dimensional array may be a header of a dataset:
  ///
  /// ````dart
  /// final data = [
  ///   ['column_1', 'column_2', 'column_3'], // a header
  ///   [   20,        false,    'value_1' ], // row 1
  ///   [   51,        true,     'value_2' ], // row 2
  ///   [   22,        false,       null   ], // row 3
  /// ]
  /// final dataframe = DataFrame(data);
  /// ````
  ///
  /// [headerExists] Indicates whether the dataset header (a sequence of
  /// column names) exists. If header exists, it must present on the very first
  /// row of the data:
  ///
  /// ````dart
  /// final data = [
  ///   ['column_1', 'column_2', 'column_3'], // row 1
  ///   [   20,        false,    'value_1' ], // row 2
  ///   [   51,        true,     'value_2' ], // row 3
  ///   [   22,        false,       null   ], // row 4
  /// ]
  /// // the first row isn't considered a header in this case, it's considered
  /// // a data item row
  /// final dataframe = DataFrame(data, headerExists: false);
  ///
  /// print(dataframe.header); // should output an autogenerated header
  /// print(dataframe.rows);
  /// ````
  ///
  /// The output:
  ///
  /// ```
  /// ['col_0', 'col_1', 'col_2']
  ///
  /// [
  ///   ['column_1', 'column_2', 'column_3'],
  ///   [   20,        false,    'value_1' ],
  ///   [   51,        true,     'value_2' ],
  ///   [   22,        false,       null   ],
  /// ]
  /// ```
  ///
  /// [header] Predefined dataset header. It'll be skipped if [headerExists] is
  /// true. Use it to provide a custom header to a header-less dataset.
  ///
  /// [autoHeaderPrefix] A string that is used as a prefix for every column name
  /// of auto-generated header (if [headerExists] is false and [header] is
  /// empty). Underscore + ordinal number is used as a postfix of column names.
  ///
  /// [columns] A collection of indices that specifies which columns should be
  /// extracted from the [data] and placed in the resulting [DataFrame]
  ///
  /// [columnNames] A collection of string that specifies which columns
  /// should be extracted from the [data] and placed in the resulting
  /// [DataFrame]. It's also can be used with auto-generated column names.
  ///
  /// [dtype] A numerical type for [Matrix] representation of the [DataFrame]
  factory DataFrame(
      Iterable<Iterable<dynamic>> data,
      {
        bool headerExists = true,
        Iterable<String> header = const [],
        String autoHeaderPrefix = defaultHeaderPrefix,
        Iterable<int> columns = const [],
        Iterable<String> columnNames = const [],
      }
  ) => fromRawData(
    data,
    headerExists: headerExists,
    predefinedHeader: header,
    autoHeaderPrefix: autoHeaderPrefix,
    columns: columns,
    columnNames: columnNames,
  );

  factory DataFrame.fromSeries(Iterable<Series> series) =>
      DataFrameImpl.fromSeries(
        series,
        NumericalConverterImpl(false),
      );

  factory DataFrame.fromMatrix(
      Matrix matrix,
      {
        Iterable<String> header,
        String autoHeaderPrefix = defaultHeaderPrefix,
        Iterable<int> columns = const [],
        Iterable<int> discreteColumns = const [],
        Iterable<String> discreteColumnNames = const [],
      }
  ) => fromMatrix(
    matrix,
    predefinedHeader: header,
    autoHeaderPrefix: autoHeaderPrefix,
    columns: columns,
    discreteColumns: discreteColumns,
    discreteColumnNames: discreteColumnNames,
  );

  factory DataFrame.fromJson(Map<String, dynamic> json) =>
      DataFrameImpl.fromJson(json);

  /// Returns a collection of names of all series (like a table header)
  Iterable<String> get header;

  /// Returns a collection of all data item rows of the DataFrame's source data
  Iterable<Iterable<dynamic>> get rows;

  /// Returns a lazy series (columns) collection of the [DataFrame].
  ///
  /// [Series] is roughly a column and its header (name)
  Iterable<Series> get series;

  /// Returns a list of two integers representing the shape of the dataframe:
  /// the first integer is a number of rows, the second integer - a number of
  /// columns
  List<int> get shape;

  /// Returns a specific [Series] by a key.
  ///
  /// The [key] may be a series name or a series index (ordinal number of the
  /// series)
  Series operator [](Object key);

  /// Returns a dataframe with a new series added to the end of this dataframe's
  /// series collection
  DataFrame addSeries(Series series);

  /// Returns a dataframe, sampled from series that are obtained from the
  /// series [indices] or series [names].
  ///
  /// If [indices] are specified, [names] parameter will be ignored.
  ///
  /// Series indices or series names may be repeating.
  DataFrame sampleFromSeries({
    Iterable<int> indices,
    Iterable<String> names,
  });

  /// Returns a dataframe, sampled from rows that are obtained from the
  /// rows [indices]
  ///
  /// Rows indices may be repeating.
  DataFrame sampleFromRows(Iterable<int> indices);

  /// Returns a new [DataFrame] without specified series
  DataFrame dropSeries({
    Iterable<int> seriesIndices,
    Iterable<String> seriesNames,
  });

  /// Converts the [DataFrame] into [Matrix].
  ///
  /// The method may throw an error if the [DataFrame] contains data that
  /// cannot be converted to numeric representation
  Matrix toMatrix([DType dtype]);

  /// Returns a new [DataFrame] with shuffled rows of this [DataFrame]
  DataFrame shuffle({int seed});
}
