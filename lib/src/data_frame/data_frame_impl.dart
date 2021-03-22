import 'package:json_annotation/json_annotation.dart';
import 'package:ml_dataframe/src/data_frame/data_frame.dart';
import 'package:ml_dataframe/src/data_frame/data_frame_json_keys.dart';
import 'package:ml_dataframe/src/data_frame/exceptions/wrong_series_shape_exception.dart';
import 'package:ml_dataframe/src/data_frame/helpers/convert_rows_to_series.dart';
import 'package:ml_dataframe/src/data_frame/helpers/convert_series_to_rows.dart';
import 'package:ml_dataframe/src/data_frame/helpers/generate_unordered_indices.dart';
import 'package:ml_dataframe/src/data_frame/series.dart';
import 'package:ml_dataframe/src/numerical_converter/helpers/from_numerical_converter_json.dart';
import 'package:ml_dataframe/src/numerical_converter/helpers/numerical_converter_to_json.dart';
import 'package:ml_dataframe/src/numerical_converter/numerical_converter.dart';
import 'package:ml_dataframe/src/serializable/serializable_mixin.dart';
import 'package:ml_linalg/dtype.dart';
import 'package:ml_linalg/linalg.dart';
import 'package:ml_linalg/matrix.dart';
import 'package:quiver/iterables.dart';

part 'data_frame_impl.g.dart';

@JsonSerializable()
class DataFrameImpl with SerializableMixin implements DataFrame {
  DataFrameImpl(this.rows, this.header, this.toNumberConverter) :
        series = convertRowsToSeries(header, rows);

  DataFrameImpl.fromSeries(this.series, this.toNumberConverter) :
        header = series.map((series) => series.name),
        rows = convertSeriesToRows(series);

  DataFrameImpl.fromMatrix(
      Matrix matrix,
      this.header,
      this.toNumberConverter,
      Iterable<bool>? areSeriesDiscrete,
  ) :
        rows = matrix.rows,
        series = zip([header, matrix.columns,
          areSeriesDiscrete ?? List.filled(matrix.columnsNum, false)])
            .map((seriesData) => Series(
              seriesData[0] as String,
              seriesData[1] as Iterable,
              isDiscrete: seriesData[2] as bool,
            )) {
    _cachedMatrices[matrix.dtype] = matrix;
  }

  factory DataFrameImpl.fromJson(Map<String, dynamic> json) =>
      _$DataFrameImplFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DataFrameImplToJson(this);

  @override
  @JsonKey(name: dataFrameHeaderJsonKey)
  final Iterable<String> header;

  @override
  @JsonKey(name: dataFrameRowsJsonKey)
  final Iterable<Iterable> rows;

  @override
  final Iterable<Series> series;

  @JsonKey(
    name: dataFrameNumericalConverterJsonKey,
    toJson: numericalConverterToJson,
    fromJson: fromNumericalConverterJson,
  )
  final NumericalConverter toNumberConverter;

  @override
  List<int> get shape => [
    series.first.data.length,
    header.length,
  ];

  final Map<DType, Matrix> _cachedMatrices = {};

  @override
  Series operator [](Object key) {
    final seriesName = key is int
        ? header.elementAt(key)
        : key;
    final series = _getCachedOrCreateSeriesByName()[seriesName];

    if (series == null) {
      throw Exception('Failed to find a series by key "$key". '
          'The type of the key is "${key.runtimeType}"');
    }

    return series;
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
      throw Exception('Columns with names $absentNames do not exist');
    };

    return _sampleFromSeries(names);
  }

  @override
  DataFrame sampleFromRows(Iterable<int> indices) {
    final rowsAsList = rows.toList(growable: false);
    final selectedRows = indices.map((index) => rowsAsList[index]);

    return DataFrame(
      selectedRows,
      headerExists: false,
      header: header,
    );
  }

  @override
  DataFrame addSeries(Series newSeries) {
    if (newSeries.data.length != shape.first) {
      throw WrongSeriesShapeException(shape.first, newSeries.data.length);
    }

    return DataFrame.fromSeries([...series, newSeries]);
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
  Matrix toMatrix([DType dtype = DType.float32]) =>
    _cachedMatrices[dtype] ??= Matrix.fromList(
      toNumberConverter
          .convertRawDataStrict(rows)
          .map((row) => row.toList())
          .toList(),
      dtype: dtype,
    );

  @override
  DataFrame shuffle({int? seed}) {
    final rowsAsList = rows.toList();
    final indices = generateUnorderedIndices(shape.first, seed);
    final shuffledRows = indices.map((index) => rowsAsList[index]);

    return DataFrame(shuffledRows, header: header, headerExists: false);
  }

  DataFrame _sampleFromSeries(Iterable ids) =>
      DataFrame.fromSeries(ids.map((dynamic id) => this[id]));

  DataFrame _dropByIndices(Iterable<int> indices, Iterable<Series> series) {
    final uniqueIndices = Set<int>.from(indices);
    final newSeries = enumerate(series)
        .where((indexedSeries) => !uniqueIndices.contains(indexedSeries.index))
        .map((indexedSeries) => indexedSeries.value);

    return DataFrame.fromSeries(newSeries);
  }

  DataFrame _dropByNames(Iterable<String> names, Iterable<Series> series) {
    final uniqueNames = Set<String>.from(names);
    final newSeries = series
        .where((series) => !uniqueNames.contains(series.name));

    return DataFrame.fromSeries(newSeries);
  }

  Map<String, Series> _getCachedOrCreateSeriesByName() =>
      _seriesByName ??= Map
          .fromEntries(series.map((series) => MapEntry(series.name, series)));
  Map<String, Series>? _seriesByName;
}
