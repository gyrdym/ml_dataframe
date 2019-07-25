import 'package:ml_linalg/matrix.dart';
import 'package:ml_linalg/vector.dart';
import 'package:xrange/zrange.dart';

class DataSet {
  DataSet(this._records, {
    this.outcomeRange,
    this.columnIdsToDecodingMap,
    this.header,
  }) {
    _features = _records
        .submatrix(columns: ZRange.closedOpen(0, outcomeRange.firstValue));
    _outcome = _records.submatrix(columns: outcomeRange);
  }

  final List<String> header;
  final ZRange outcomeRange;
  final Map<ZRange, Map<Vector, String>> columnIdsToDecodingMap;
  final Matrix _records;

  Matrix get features => _features;
  Matrix _features;

  Matrix get outcome => _outcome;
  Matrix _outcome;

  bool isColumnNominal(ZRange range)  => columnIdsToDecodingMap
      ?.containsKey(range) == true;

  Matrix toMatrix() => _records;
}
