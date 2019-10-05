import 'package:csv/csv.dart';
import 'package:ml_dataframe/src/data_frame/data_frame.dart';
import 'package:ml_dataframe/src/data_frame/factories/from_raw_data.dart';
import 'package:ml_dataframe/src/data_reader/data_reader.dart';

Future<DataFrame> fromCsv(
    String fileName,
    {
      String columnDelimiter = defaultFieldDelimiter,
      String eol = '\n',
      bool headerExists = true,
      Iterable<String> header = const [],
      String autoHeaderPrefix = defaultHeaderPrefix,
      Iterable<int> columns = const [],
      Iterable<String> columnNames = const [],
    }
) async {
  final reader = DataReader.csv(fileName, columnDelimiter, eol);
  final data = await reader.extractData();

  return fromRawData(
    data,
    headerExists: headerExists,
    predefinedHeader: header,
    autoHeaderPrefix: autoHeaderPrefix,
    columns: columns,
    columnNames: columnNames,
  );
}
