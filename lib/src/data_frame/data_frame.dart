import 'package:csv/csv.dart';
import 'package:ml_dataframe/src/data_frame/data_frame_impl.dart';
import 'package:ml_dataframe/src/data_frame/factories/from_matrix.dart';
import 'package:ml_dataframe/src/data_frame/factories/from_raw_csv.dart';
import 'package:ml_dataframe/src/data_frame/factories/from_raw_data.dart';
import 'package:ml_dataframe/src/data_frame/series.dart';
import 'package:ml_dataframe/src/numerical_converter/numerical_converter_impl.dart';
import 'package:ml_dataframe/src/serializable/serializable.dart';
import 'package:ml_linalg/linalg.dart';

const defaultHeaderPrefix = 'col_';

/// An in-memory storage to keep data in column-like manner with human readable
/// headers with possibility to convert the data to pure numeric representation.
abstract class DataFrame implements Serializable {
  /// Creates a dataframe from the non-typed [data] that is represented as
  /// two-dimensional array, where each element is a row of table-like data.
  /// The first element of the two-dimensional array may be a header of a
  /// dataset:
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
  /// [columns] A collection of column indices that specifies which columns
  /// should be extracted from the [data] and placed in the resulting [DataFrame]
  /// Has a higher precedence than [columnNames]
  ///
  /// [columnNames] A collection of column titles that specifies which columns
  /// should be extracted from the [data] and placed in the resulting
  /// [DataFrame]. It's also can be used with auto-generated column names.
  /// The argument will be omitted if [columns] is provided
  factory DataFrame(
    Iterable<Iterable<dynamic>> data, {
    bool headerExists = true,
    Iterable<String> header = const [],
    String autoHeaderPrefix = defaultHeaderPrefix,
    Iterable<int> columns = const [],
    Iterable<String> columnNames = const [],
  }) =>
      fromRawData(
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
        const NumericalConverterImpl(),
      );

  factory DataFrame.fromMatrix(
    Matrix matrix, {
    Iterable<String> header = const [],
    String autoHeaderPrefix = defaultHeaderPrefix,
    Iterable<int> columns = const [],
    Iterable<int> discreteColumns = const [],
    Iterable<String> discreteColumnNames = const [],
  }) =>
      fromMatrix(
        matrix,
        predefinedHeader: header,
        autoHeaderPrefix: autoHeaderPrefix,
        columns: columns,
        discreteColumns: discreteColumns,
        discreteColumnNames: discreteColumnNames,
      );

  /// Creates a dataframe instance from stringified csv [rawContent].
  ///
  /// ````dart
  /// final rawContent =
  ///   'column_1,column_2,column_3\n' +
  ///   '100,200,300\n' +
  ///   '400,500,600\n' +
  ///   '700,800,900\n';
  ///
  /// final dataframe = DataFrame.fromRawCsv(rawContent);
  ///
  /// print(dataframe.header); // (column_1, column_2, column_3)
  /// print(dataframe.rows); // ((100,200,300), (400,500,600), (700,800,900))
  /// print(dataframe.series.elementAt(0).data); // (100, 400, 700)
  /// print(dataframe.series.elementAt(1).data); // (200, 500, 600)
  /// print(dataframe.series.elementAt(2).data); // (300, 600, 900)
  /// ````
  /// [fieldDelimiter] A delimiter which divides elements in a single row,
  /// `,` by default
  ///
  /// [textDelimiter] A delimiter which allows to use [fieldDelimiter] character
  /// inside a cell of the resulting table, e.g. [fieldDelimiter] is `,`,
  /// [textDelimiter] is `"`, and that means that every `,` symbol in [rawContent]
  /// which is not a field delimiter must be wrapped with `"`-symbol
  ///
  /// [eol] The end of line character, `\n` by default
  ///
  /// [headerExists] Whether the [rawContent] has a header line (list of column
  /// titles) or not
  ///
  /// [header] A custom header line for a resulting csv table (if
  /// [headerExists] is false)
  ///
  /// [autoHeaderPrefix] If there is no header line in the [rawContent] and
  /// no [header] provided, [autoHeaderPrefix] will be used as a prefix for
  /// autogenerated column titles
  ///
  /// [columns] A collection of column indices that specifies which columns
  /// should be extracted from the raw data and placed in the resulting [DataFrame].
  /// Has a higher precedence than [columnNames]
  ///
  /// [columnNames] A collection of column titles that specifies which columns
  /// should be extracted from the raw data and placed in the resulting
  /// [DataFrame]. It's also can be used with auto-generated column names.
  /// The argument will be omitted if [columns] is provided
  factory DataFrame.fromRawCsv(
    String rawContent, {
    String fieldDelimiter = defaultFieldDelimiter,
    String textDelimiter = defaultTextDelimiter,
    String? textEndDelimiter,
    String eol = '\n',
    bool headerExists = true,
    Iterable<String> header = const [],
    String autoHeaderPrefix = defaultHeaderPrefix,
    Iterable<int> columns = const [],
    Iterable<String> columnNames = const [],
  }) =>
      fromRawCsv(
        rawContent,
        fieldDelimiter: fieldDelimiter,
        textDelimiter: textDelimiter,
        textEndDelimiter: textEndDelimiter,
        eol: eol,
        headerExists: headerExists,
        header: header,
        autoHeaderPrefix: autoHeaderPrefix,
        columns: columns,
        columnNames: columnNames,
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
  ///
  /// If [indices] are specified, [names] parameter will be ignored.
  DataFrame dropSeries({
    Iterable<int> indices,
    Iterable<String> names,
  });

  /// Converts the [DataFrame] into [Matrix].
  ///
  /// The method may throw an error if the [DataFrame] contains data that
  /// cannot be converted to numeric representation
  Matrix toMatrix([DType dtype]);

  /// Returns a new [DataFrame] with shuffled rows of this [DataFrame]
  DataFrame shuffle({int seed});

  /// Returns a new [DataFrame] with modified data according to the
  /// [mapper] function
  ///
  /// Usage example:
  ///
  /// ```dart
  /// import 'package:ml_dataframe/ml_dataframe';
  ///
  /// void main() {
  ///   final data = DataFrame([
  ///     ['col_1', 'col_2', 'col_3'],
  ///     [      2,      20,     200],
  ///     [      3,      30,     300],
  ///     [      4,      40,     400],
  ///   ]);
  ///   final modifiedData = data.map((value) => (value as num) * 2);
  ///
  ///   print(modifiedData);
  ///   // DataFrame (3 x 3)
  ///   // col_1 col_2 col_3
  ///   //     4    40   400
  ///   //     6    60   600
  ///   //     8    80   800
  /// }
  /// ```
  DataFrame map(dynamic Function(dynamic value) mapper);

  /// Returns a nicely formatted string to inspect the data of the [DataFrame] as the example below shows
  ///
  /// [maxRows] will display the first maxRows/2 and the last maxRows/2 rows of the [DataFrame]
  ///
  /// [maxCols] will display the first maxCols-1 columns and the last column of the [DataFrame]
  ///
  /// ````txt
  /// DataFrame (13 x 10)
  ///  id   age   salary   children   gender           profession   ...   weight
  ///   1    25    30000          2        M              Teacher   ...     78.3
  ///   2    46    85000          0        M              Manager   ...     45.2
  ///   3    36    45000          1        F              Teacher   ...     98.4
  ///   4    23    10000          5        M   Mushroom Collector   ...     57.4
  ///   5    22    30000          2        M              Butcher   ...     87.9
  /// ...   ...      ...        ...      ...                  ...   ...      ...
  ///   9    23      N/A          2        M           Unemployed   ...     56.7
  ///  10    25    32000          4        F              Teacher   ...     98.7
  ///  11    49    34700          0        M              Plumber   ...    120.3
  ///  12    36    45000          1        F            Paramedic   ...     67.9
  ///  13    23    42900          2        M           Researcher   ...     92.3
  /// ````
  @override
  String toString({int maxRows = 10, int maxCols = 7});
}
