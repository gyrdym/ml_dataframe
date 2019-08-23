import 'package:ml_dataframe/src/data_frame/data_frame.dart';
import 'package:ml_dataframe/src/data_frame/data_frame_helpers.dart';
import 'package:ml_dataframe/src/data_frame/series.dart';
import 'package:ml_dataframe/src/numerical_converter/numerical_converter.dart';
import 'package:ml_linalg/dtype.dart';
import 'package:ml_linalg/linalg.dart';
import 'package:ml_linalg/matrix.dart';

class DataFrameImpl implements DataFrame {
  DataFrameImpl(this.rows, this.header, this._toNumber, this.dtype) :
        series = convertRowsToSeries(header, rows);

  DataFrameImpl.fromSeries(this.series, this._toNumber, this.dtype) :
        header = series.map((series) => series.name),
        rows = convertSeriesToRows(series);

  @override
  final Iterable<String> header;

  @override
  final Iterable<Iterable<dynamic>> rows;

  @override
  final Iterable<Series> series;

  final DType dtype;

  final NumericalConverter _toNumber;

  Matrix _cachedMatrix;

  @override
  Matrix toMatrix() =>
    _cachedMatrix ??= Matrix.fromList(
        _toNumber
            .convertRawData(rows)
            .map((row) => row.toList())
            .toList(),
        dtype: dtype,
    );

  @override
  Series operator [](Object key) {
    final seriesName = key is int
        ? header.elementAt(key)
        : key;
    return _getCachedOrCreateSeriesByName()[seriesName];
  }

  Map<String, Series> _getCachedOrCreateSeriesByName() =>
      _seriesByName ??= Map
          .fromEntries(series.map((series) => MapEntry(series.name, series)));
  Map<String, Series> _seriesByName;
}
