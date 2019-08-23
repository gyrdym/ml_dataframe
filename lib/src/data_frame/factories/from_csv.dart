import 'package:csv/csv.dart';
import 'package:ml_dataframe/src/data_frame/data_frame.dart';
import 'package:ml_dataframe/src/data_frame/factories/from_raw_data.dart';
import 'package:ml_dataframe/src/data_reader/data_reader.dart';
import 'package:ml_linalg/dtype.dart';

Future<DataFrame> fromCsv(
    String fileName,
    {
      String columnDelimiter = defaultFieldDelimiter,
      String eol = '\n',
      bool headerExists = true,
      Iterable<String> header,
      String autoHeaderPrefix = defaultHeaderPrefix,
      Iterable<int> columns,
      Iterable<String> columnNames,
      DType dtype = DType.float32,
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
    dtype: dtype,
  );
}
