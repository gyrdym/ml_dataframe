import 'package:ml_dataframe/data_set.dart';
import 'package:ml_linalg/linalg.dart';
import 'package:test/test.dart';
import 'package:xrange/zrange.dart';

void main() {
  group('DataSet', () {
    final observations = Matrix.fromList(([
      [10, 20, 33, 0, 0, 0, 1, 10, 0, 0, 1],
      [22, 10, 39, 1, 0, 0, 0, 20, 0, 1, 0],
      [90, 26, 14, 0, 1, 0, 0, 65, 0, 0, 1],
    ]));

    final outcomeRange = ZRange.closed(8, 10);

    final columnIdsToDecodingMap = {
      ZRange.closed(3, 6): {
        Vector.fromList([0, 0, 0, 1]): '1',
        Vector.fromList([0, 0, 1, 0]): '2',
        Vector.fromList([0, 1, 0, 0]): '3',
        Vector.fromList([1, 0, 0, 0]): '4',
      },
      outcomeRange: {
        Vector.fromList([0, 0, 1]): 'how_doth',
        Vector.fromList([0, 1, 0]): 'the_little',
        Vector.fromList([1, 0, 0]): 'crocodile',
      },
    };

    final dataSet = DataSet(observations,
        outcomeRange: outcomeRange,
        columnIdsToDecodingMap: columnIdsToDecodingMap
    );

    test('should store nominal feature ranges with their decoding maps', () {
      expect(dataSet.columnIdsToDecodingMap, equals(columnIdsToDecodingMap));
    });

    test('should extract outcome values', () {
      expect(dataSet.outcome, equals([
        [0, 0, 1],
        [0, 1, 0],
        [0, 0, 1],
      ]));
    });

    test('should extract features', () {
      expect(dataSet.features, equals([
        [10, 20, 33, 0, 0, 0, 1, 10],
        [22, 10, 39, 1, 0, 0, 0, 20],
        [90, 26, 14, 0, 1, 0, 0, 65],
      ]));
    });
  });
}
