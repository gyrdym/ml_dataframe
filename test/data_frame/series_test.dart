import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:ml_dataframe/src/data_frame/series_json_keys.dart';
import 'package:test/test.dart';

void main() {
  group('Series', () {
    final data = [1, 2, 3, '4'];
    final dataWithDuplicates = [1, 2, 3, '4', 1, 2, 10, '4'];
    final uniqueDataItems = [1, 2, 3, '4', 10];
    final seriesName = 'series_name';

    final json = {
      seriesNameJsonKey: seriesName,
      seriesDataJsonKey: data,
      isSeriesDiscreteJsonKey: false,
    };

    final discreteDataframeJson = {
      seriesNameJsonKey: seriesName,
      seriesDataJsonKey: dataWithDuplicates,
      isSeriesDiscreteJsonKey: true,
    };

    test('should initialize properly', () {
      final series = Series(seriesName, data);

      expect(series.name, seriesName);
      expect(series.data, equals(data));
      expect(series.isDiscrete, isFalse);
      expect(series.discreteValues, isEmpty);
    });

    test('should initialize as a series with discrete data item sequence', () {
      final series = Series(seriesName, dataWithDuplicates, isDiscrete: true);

      expect(series.name, seriesName);
      expect(series.data, equals(dataWithDuplicates));
      expect(series.isDiscrete, isTrue);
      expect(series.discreteValues, equals([1, 2, 3, '4', 10]));
    });

    test('should convert to json', () {
      final series = Series(seriesName, data);

      expect(series.toJson(), json);
    });

    test('should restore from json', () {
      final series = Series.fromJson(json);

      expect(series.name, seriesName);
      expect(series.data, data);
      expect(series.isDiscrete, isFalse);
      expect(series.discreteValues, <dynamic>[]);
    });

    test('should restore discrete dataframe from json', () {
      final series = Series.fromJson(discreteDataframeJson);

      expect(series.name, seriesName);
      expect(series.data, dataWithDuplicates);
      expect(series.isDiscrete, isTrue);
      expect(series.discreteValues, uniqueDataItems);
    });
  });
}
