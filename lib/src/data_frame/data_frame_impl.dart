import 'package:ml_dataframe/src/data_frame/data_frame.dart';
import 'package:ml_dataframe/src/data_frame/data_frame_helpers.dart';
import 'package:ml_dataframe/src/data_frame/series.dart';
import 'package:ml_dataframe/src/numerical_converter/numerical_converter.dart';
import 'package:ml_linalg/dtype.dart';
import 'package:ml_linalg/linalg.dart';
import 'package:ml_linalg/matrix.dart';
import 'package:quiver/iterables.dart';

class DataFrameImpl implements DataFrame {
  DataFrameImpl(this.rows, this.header, this._toNumber, this.dtype) :
        series = convertRowsToSeries(header, rows);

  DataFrameImpl.fromSeries(this.series, this._toNumber, this.dtype) :
        header = series.map((series) => series.name),
        rows = convertSeriesToRows(series);

  DataFrameImpl.fromMatrix(
      this._cachedMatrix,
      this.header,
      this._toNumber,
      Iterable<bool> areSeriesDiscrete,
  ) :
        dtype = _cachedMatrix.dtype,
        rows = _cachedMatrix.rows,
        series = zip([header, _cachedMatrix.columns,
          areSeriesDiscrete ?? List.filled(_cachedMatrix.columnsNum, false)])
            .map((seriesData) => Series(
              seriesData[0] as String,
              seriesData[1] as Iterable,
              isDiscrete: seriesData[2] as bool,
            ));

  @override
  final Iterable<String> header;

  @override
  final Iterable<Iterable<dynamic>> rows;

  @override
  final Iterable<Series> series;

  @override
  final DType dtype;

  final NumericalConverter _toNumber;

  Matrix _cachedMatrix;

  @override
  Series operator [](Object key) {
    final seriesName = key is int
        ? header.elementAt(key)
        : key;
    return _getCachedOrCreateSeriesByName()[seriesName];
  }

  @override
  DataFrame sampleFromSeries({
    Iterable<int> indices = const [],
    Iterable<String> names = const [],
  }) {
    if (indices.isNotEmpty) {
      final maxIdx = series.length - 1;
      final outRangedIndices = indices.where((idx) => idx < 0 || idx > maxIdx);
      if (outRangedIndices.isNotEmpty) {
        throw RangeError('Some of provided indices are out of range: '
            '$outRangedIndices, while the valid range is 0..$maxIdx (both '
            'inclusive)');
      }
      return _sampleFromSeries(indices);
    }
    final absentNames = Set<String>
        .from(names)
        .difference(Set.from(header));
    if (absentNames.isNotEmpty) {
      throw Exception('Columns with the names $absentNames do not exist');
    };
    return _sampleFromSeries(names);
  }

  @override
  DataFrame dropSeries({
    Iterable<int> seriesIndices = const [],
    Iterable<String> seriesNames = const [],
  }) {
    if (seriesIndices.isNotEmpty) {
      return _dropByIndices(seriesIndices, series);
    }

    return _dropByNames(seriesNames, series);
  }

  @override
  Matrix toMatrix() =>
      _cachedMatrix ??= Matrix.fromList(
        _toNumber
            .convertRawData(rows)
            .map((row) => row.toList())
            .toList(),
        dtype: dtype,
      );

  DataFrame _sampleFromSeries(Iterable ids) =>
      DataFrame.fromSeries(
        ids.map((dynamic id) => this[id]),
        dtype: dtype,
      );

  DataFrame _dropByIndices(Iterable<int> indices, Iterable<Series> series) {
    final uniqueIndices = Set<int>.from(indices);
    final newSeries = enumerate(series)
        .where((indexedSeries) => !uniqueIndices.contains(indexedSeries.index))
        .map((indexedSeries) => indexedSeries.value);
    return DataFrame.fromSeries(newSeries, dtype: dtype);
  }

  DataFrame _dropByNames(Iterable<String> names, Iterable<Series> series) {
    final uniqueNames = Set<String>.from(names);
    final newSeries = series
        .where((series) => !uniqueNames.contains(series.name));
    return DataFrame.fromSeries(newSeries, dtype: dtype);
  }

  Map<String, Series> _getCachedOrCreateSeriesByName() =>
      _seriesByName ??= Map
          .fromEntries(series.map((series) => MapEntry(series.name, series)));
  Map<String, Series> _seriesByName;
}
