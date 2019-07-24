import 'package:ml_dataframe/data_frame.dart';
import 'package:ml_linalg/linalg.dart';
import 'package:test/test.dart';
import 'package:xrange/zrange.dart';

void main() {
  group('DataFrame', () {
    final observations = Matrix.fromList(([
      [10, 20, 33, 0, 0, 0, 1, 10, 0, 0, 1],
      [22, 10, 39, 1, 0, 0, 0, 20, 0, 1, 0],
      [90, 26, 14, 0, 1, 0, 0, 65, 0, 0, 1],
    ]));

    final rangeToEncoded = {
      ZRange.closed(3, 6): [
        Vector.fromList([0, 0, 0, 1]),
        Vector.fromList([0, 0, 1, 0]),
        Vector.fromList([0, 1, 0, 0]),
        Vector.fromList([1, 0, 0, 0]),
      ],
      ZRange.closed(8, 10): [
        Vector.fromList([0, 0, 1]),
        Vector.fromList([0, 1, 0]),
        Vector.fromList([1, 0, 0]),
      ]
    };

    final dataFrame = DataFrame(observations);

    test('should store nominal feature ranges with their encoded values', () {
      expect(dataFrame.rangeToEncoded, equals(rangeToEncoded));
    });

    test('should store outcome variable column range', () {
      expect(dataFrame.toMatrix(), equals(observations));
    });
  });
}
