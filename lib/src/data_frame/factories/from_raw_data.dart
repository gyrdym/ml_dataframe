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
  final header = getHeader(
      data.first.length,
      autoHeaderPrefix,
      headerExists
          ? data.first.map((dynamic el) => el.toString())
          : [],
      predefinedHeader);

  final columnIndices = enumerate(header)
      .where((indexedName) => columns?.isNotEmpty == true
        ? columns.contains(indexedName.index)
        : true)
      .where((indexedName) => columnNames?.isNotEmpty == true
        ? columnNames.contains(indexedName.value)
        : true)
      .map((indexedName) => indexedName.index);

  final originalHeadlessData = headerExists
      ? data.skip(1)
      : data;

  final selectedData = DataSelector(columnIndices)
      .select(originalHeadlessData);

  final selectedHeader = enumerate(header)
      .where((indexedName) => columnIndices.contains(indexedName.index))
      .map((indexedName) => indexedName.value);

  return DataFrameImpl(selectedData, selectedHeader,
      NumericalConverterImpl(false), dtype);
}
