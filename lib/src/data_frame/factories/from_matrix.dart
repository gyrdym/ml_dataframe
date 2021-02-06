import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:ml_dataframe/src/data_frame/data_frame_impl.dart';
import 'package:ml_dataframe/src/data_frame/helpers/get_header.dart';
import 'package:ml_dataframe/src/numerical_converter/numerical_converter_impl.dart';
import 'package:ml_linalg/linalg.dart';
import 'package:quiver/iterables.dart';

DataFrame fromMatrix(Matrix data, {
  Iterable<String> predefinedHeader = const [],
  String autoHeaderPrefix = defaultHeaderPrefix,
  Iterable<int> columns = const [],
  Iterable<int> discreteColumns = const [],
  Iterable<String> discreteColumnNames = const [],
}) {
  final header = getHeader(columns?.isNotEmpty == true
        ? columns.length
        : data.columnsNum,
      autoHeaderPrefix, [], predefinedHeader);

  final selectedData = columns?.isNotEmpty == true
      ? data.sample(columnIndices: columns)
      : data;

  final areSeriesDiscrete = enumerate(header).map((indexedName) =>
    discreteColumns.contains(indexedName.index) ||
        discreteColumnNames.contains(indexedName.value),
  );

  return DataFrameImpl.fromMatrix(selectedData, header,
      NumericalConverterImpl(false), areSeriesDiscrete);
}
