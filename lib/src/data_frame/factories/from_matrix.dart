import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:ml_dataframe/src/data_frame/data_frame_helpers.dart';
import 'package:ml_dataframe/src/data_frame/data_frame_impl.dart';
import 'package:ml_dataframe/src/numerical_converter/numerical_converter_impl.dart';
import 'package:ml_linalg/linalg.dart';
import 'package:quiver/iterables.dart';
import 'package:xrange/zrange.dart';

DataFrame fromMatrix(Matrix data, {
  Iterable<String> predefinedHeader,
  String autoHeaderPrefix = defaultHeaderPrefix,
  Iterable<int> columns,
  Iterable<bool> areSeriesDiscrete,
}) {
  final header = getHeader(
      enumerate(data.rows.first).map((indexed) => indexed.index),
      autoHeaderPrefix, null, predefinedHeader);

  final selectedData = data.pick(
      rowRanges: [ZRange.all()],
      columnRanges: columns.map((idx) => ZRange.singleton(idx)),
  );

  return DataFrameImpl.fromMatrix(selectedData, header,
      NumericalConverterImpl(false), areSeriesDiscrete);
}
