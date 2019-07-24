import 'package:ml_linalg/matrix.dart';
import 'package:ml_linalg/vector.dart';
import 'package:xrange/zrange.dart';

class DataFrame {
  DataFrame(this._records, {this.rangeToEncoded});

  final Map<ZRange, List<Vector>> rangeToEncoded;
  final Matrix _records;

  bool isColumnNominal(ZRange range)  => rangeToEncoded
      ?.containsKey(range) == true;

  Matrix toMatrix() => _records;
}
