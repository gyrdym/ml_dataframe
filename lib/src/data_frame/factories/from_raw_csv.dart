import 'package:csv/csv.dart';
import 'package:ml_dataframe/src/data_frame/data_frame.dart';
import 'package:ml_dataframe/src/data_frame/factories/from_raw_data.dart';

DataFrame fromRawCsv(
    String rawContent,
    {
      String fieldDelimiter = defaultFieldDelimiter,
      String textDelimiter = defaultTextDelimiter,
      String? textEndDelimiter,
      String eol = '\n',
      bool headerExists = true,
      Iterable<String> header = const [],
      String autoHeaderPrefix = defaultHeaderPrefix,
      Iterable<int> columns = const [],
      Iterable<String> columnNames = const [],
    }
) {
  final converter = CsvToListConverter(
    fieldDelimiter: fieldDelimiter,
    textDelimiter: textDelimiter,
    textEndDelimiter: textDelimiter,
    eol: eol,
  );
  final data = converter.convert(rawContent);

  return fromRawData(
    data,
    headerExists: headerExists,
    predefinedHeader: header,
    autoHeaderPrefix: autoHeaderPrefix,
    columns: columns,
    columnNames: columnNames,
  );
}
