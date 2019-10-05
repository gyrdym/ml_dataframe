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
  /// [data] Non-typed data, the first element may be a header of a dataset (a
  /// collection of strings)
  ///
  /// [headerExists] Indicates, whether the dataset header (a sequence of
  /// column names) exists or not. If header exists, it must present on the
  /// very first row of data
  ///
  /// [header] Predefined dataset header. It's skipped if [headerExists] is
  /// true. Use it to provide a custom header to header-less dataset.
  ///
  /// [autoHeaderPrefix] A string, that uses as a prefix for a column name
  /// of auto-generated header (if [headerExists] is false and [header] is
  /// empty). As a postfix underscore + ordinal number of series uses.
  ///
  /// [columns] A collection of indices, that specifies which columns should be
  /// extracted from the [data] and placed in the resulting [DataFrame]
  ///
  /// [columnNames] A collection of string, that specifies which columns
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

  /// A type used for converting the [DataFrame] into [Matrix]
  DType get dtype;

  /// Returns a collection of names of all series (like a table header)
  Iterable<String> get header;

  Iterable<Iterable<dynamic>> get rows;

  /// Returns a lazy series (columns) collection of the [DataFrame].
  ///
  /// [Series] is roughly a column and its header (name)
  Iterable<Series> get series;

  /// Returns a specific [Series] by a key.
  ///
  /// The [key] may be a series name or a series index (ordinal number of the
  /// series)
  Series operator [](Object key);

  /// Returns a dataframe, sampled from series, that are obtained from provided
  /// series [indices] or series [names].
  ///
  /// If [indices] are specified, [names] parameter will be ignored.
  ///
  /// Series indices or series names may be repeating.
  DataFrame sampleFromSeries({
    Iterable<int> indices,
    Iterable<String> names,
  });

  /// Returns a new [DataFrame] without specified series (columns)
  DataFrame dropSeries({
    Iterable<int> seriesIndices,
    Iterable<String> seriesNames,
  });

  /// Converts the [DataFrame] into [Matrix].
  ///
  /// The method may throw an error if the [DataFrame] contains data, that
  /// cannot be converted to numerical representation
  Matrix toMatrix();
}
