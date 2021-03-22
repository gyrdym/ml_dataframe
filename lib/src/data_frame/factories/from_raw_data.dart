import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:ml_dataframe/src/data_frame/data_frame_impl.dart';
import 'package:ml_dataframe/src/data_frame/helpers/get_header.dart';
import 'package:ml_dataframe/src/data_selector/data_selector.dart';
import 'package:ml_dataframe/src/numerical_converter/numerical_converter_impl.dart';
import 'package:quiver/iterables.dart';

DataFrame fromRawData(Iterable<Iterable<dynamic>> data, {
  bool headerExists = true,
  Iterable<String> predefinedHeader = const [],
  String autoHeaderPrefix = defaultHeaderPrefix,
  Iterable<int> columns = const [],
  Iterable<String> columnNames = const [],
}) {
  final columnsNum = columns.isNotEmpty
      ? columns.length
      : data.isEmpty
        ? predefinedHeader.length
        : data.first.length;

  final header = getHeader(
      columnsNum,
      autoHeaderPrefix,
      headerExists
          ? data.isEmpty
            ? []
            : data.first.map((dynamic el) => el.toString())
          : [],
      predefinedHeader);

  final defaultIndices = count(0).take(columnsNum);

  final filteredIndices = enumerate(header)
      .where((indexedName) => columnNames.contains(indexedName.value))
      .map((indexedName) => indexedName.index);

  final columnIndices = columns.isNotEmpty
      ? columns
      : predefinedHeader.isNotEmpty || columnNames.isEmpty
          ? defaultIndices
          : filteredIndices;

  final originalHeadlessData = headerExists
      ? data.skip(1)
      : data;

  final selectedData = DataSelector(columnIndices)
      .select(originalHeadlessData);

  final selectedHeader = (predefinedHeader.isNotEmpty
      ? enumerate(header)
      : enumerate(header)
          .where((indexedName) => columnIndices.isNotEmpty
            ? columnIndices.contains(indexedName.index)
            : true)
      )
      .map((indexedName) => indexedName.value);

  return DataFrameImpl(selectedData, selectedHeader,
      const NumericalConverterImpl());
}
