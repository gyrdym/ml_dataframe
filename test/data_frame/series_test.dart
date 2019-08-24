import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:test/test.dart';

void main() {
  group('Series', () {
    test('should initialize properly', () {
      final data = [1, 2, 3, '4'];
      final series = Series('series_name', data);

      expect(series.name, 'series_name');
      expect(series.data, equals(data));
      expect(series.isDiscrete, isFalse);
      expect(series.discreteValues, isEmpty);
    });

    test('should initialize as a series with discrete data sequence', () {
      final data = [1, 2, 3, '4', 1, 2, 10, '4'];
      final series = Series('series_name', data, isDiscrete: true);

      expect(series.name, 'series_name');
      expect(series.data, equals(data));
      expect(series.isDiscrete, isTrue);
      expect(series.discreteValues, equals([1, 2, 3, '4', 10]));
    });
  });
}
