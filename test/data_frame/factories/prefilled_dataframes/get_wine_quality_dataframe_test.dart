import 'package:ml_dataframe/src/data_frame/factories/prefilled_dataframes/get_wine_quality_data_frame.dart';
import 'package:test/test.dart';

void main() {
  group('getWineQualityDataframe', () {
    test('should create a dataframe', () {
      final data = getWineQualityDataFrame();

      expect(data.header, [
        'fixed acidity',
        'volatile acidity',
        'citric acid',
        'residual sugar',
        'chlorides',
        'free sulfur dioxide',
        'total sulfur dioxide',
        'density',
        'pH',
        'sulphates',
        'alcohol',
        'quality',
      ]);
      expect(data.shape, [1599, 12]);
      expect(data.rows.elementAt(0),
          [7.4, 0.7, 0.0, 1.9, 0.076, 11.0, 34.0, 0.9978, 3.51, 0.56, 9.4, 5]);
      expect(data.rows.elementAt(322), [
        7.8,
        0.62,
        0.05,
        2.3,
        0.079,
        6.0,
        18.0,
        0.99735,
        3.29,
        0.63,
        9.3,
        5
      ]);
      expect(data.rows.elementAt(1032),
          [8.1, 0.82, 0.0, 4.1, 0.095, 5.0, 14.0, 0.99854, 3.36, 0.53, 9.6, 5]);
      expect(data.rows.elementAt(1598), [
        6.0,
        0.31,
        0.47,
        3.6,
        0.067,
        18.0,
        42.0,
        0.99549,
        3.39,
        0.66,
        11.0,
        6
      ]);
    });
  });
}
