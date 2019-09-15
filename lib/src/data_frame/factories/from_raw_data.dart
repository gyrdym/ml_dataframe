import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:ml_dataframe/src/data_frame/data_frame_helpers.dart';
import 'package:ml_dataframe/src/data_frame/data_frame_impl.dart';
import 'package:ml_dataframe/src/data_selector/data_selector.dart';
import 'package:ml_dataframe/src/numerical_converter/numerical_converter_impl.dart';
import 'package:ml_linalg/dtype.dart';
import 'package:quiver/iterables.dart';

DataFrame fromRawData(Iterable<Iterable<dynamic>> data, {
  bool headerExists = true,
  Iterable<String> predefinedHeader = const [],
  String autoHeaderPrefix = defaultHeaderPrefix,
  Iterable<int> columns = const [],
  Iterable<String> columnNames = const [],
  DType dtype = DType.float32,
}) {
  final originalHeader = getHeader(
      enumerate<dynamic>(data.first)
          .where((indexed) => columns?.isNotEmpty == true
            ? columns.contains(indexed.index)
            : true)
          .where((indexed) => columnNames?.isNotEmpty == true
            ? columnNames.contains(indexed.value.toString().trim())
            : true)
          .map((indexed) => indexed.index),
      autoHeaderPrefix,
      headerExists
          ? data.first.map((dynamic el) => el.toString())
          : null,
      predefinedHeader);

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
