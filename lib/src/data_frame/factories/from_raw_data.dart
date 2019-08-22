import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:ml_dataframe/src/data_frame/data_frame_impl.dart';
import 'package:ml_dataframe/src/data_selector/data_selector.dart';
import 'package:ml_dataframe/src/numerical_converter/numerical_converter_impl.dart';
import 'package:ml_linalg/dtype.dart';
import 'package:quiver/iterables.dart';

DataFrame fromRawData(Iterable<Iterable<dynamic>> data, {
  bool headerExists = true,
  Iterable<String> header,
  String autoHeaderPrefix = 'col_',
  Iterable<int> columns,
  Iterable<String> columnNames,
  DType dtype = DType.float32,
}) {
  final originalHeader = headerExists
      ? data.first.map((dynamic name) => name.toString().trim())
      : <String>[];

  final selected = DataSelector(columns, columnNames, originalHeader)
      .select(data);

  final defaultHeader = header ??
      enumerate<dynamic>(selected.first)
          .map((indexed) => '${autoHeaderPrefix}${indexed.index}');

  final processedHeader = headerExists
      ? selected.first.map((dynamic name) => name.toString().trim())
      : defaultHeader;

  final headLessData = headerExists
      ? selected.skip(1)
      : selected;

  return DataFrameImpl(headLessData, processedHeader,
      NumericalConverterImpl(false), dtype);
}
