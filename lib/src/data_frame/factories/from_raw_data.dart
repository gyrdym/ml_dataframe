import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:ml_dataframe/src/data_frame/data_frame_impl.dart';
import 'package:ml_dataframe/src/data_selector/data_selector.dart';
import 'package:ml_dataframe/src/numerical_converter/numerical_converter_impl.dart';
import 'package:ml_linalg/dtype.dart';
import 'package:quiver/iterables.dart';

DataFrame fromRawData(Iterable<Iterable<dynamic>> data, {
  bool headerExists = true,
  Iterable<String> predefinedHeader,
  String autoHeaderPrefix = defaultHeaderPrefix,
  Iterable<int> columns,
  Iterable<String> columnNames,
  DType dtype = DType.float32,
}) {
  final fallbackHeader = enumerate<dynamic>(data.first)
      .map((indexed) => '${autoHeaderPrefix}${indexed.index}');

  final actualHeader = data.first
      .map((dynamic name) => name.toString().trim());

  final originalHeader = predefinedHeader ?? (
      headerExists
          ? actualHeader
          : fallbackHeader
  );

  final originalHeadlessData = headerExists
      ? data.skip(1)
      : data;

  final selectedData = DataSelector(columns, columnNames, originalHeader)
      .select(originalHeadlessData);

  final header = selectedData.first
      .map((dynamic name) => name.toString().trim());

  final headlessData = selectedData.skip(1);

  return DataFrameImpl(headlessData, header,
      NumericalConverterImpl(false), dtype);
}
