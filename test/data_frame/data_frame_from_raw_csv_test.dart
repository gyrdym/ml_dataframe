import 'dart:io';

import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:test/test.dart';

void main() {
  group('DataFrame.fromRawCsv', () {
    final csvAsString = File('test/data_frame/data/raw_csv_with_header.txt')
        .readAsStringSync();

    test('should create a dataframe with a proper header', () {
      final dataframe = DataFrame.fromRawCsv(csvAsString);

      expect(dataframe.header, [
        'number of times pregnant',
        'plasma glucose concentration a 2 hours in an oral glucose tolerance test',
        'diastolic blood pressure (mm Hg)',
        'triceps skin fold thickness (mm)',
        '2-Hour serum insulin (mu U/ml)',
        'body mass index (weight in kg/(height in m)^2)',
        'diabetes pedigree function',
        'age (years)',
        'class variable (0 or 1)'
      ]);
    });

    test('should create a dataframe with a proper shape', () {
      final dataframe = DataFrame.fromRawCsv(csvAsString);

      expect(dataframe.shape, [768, 9]);
    });

    test('should create a dataframe with proper series length', () {
      final dataframe = DataFrame.fromRawCsv(csvAsString);

      expect(dataframe.series, hasLength(9));
    });

    test('should create a dataframe with proper series content', () {
      final dataframe = DataFrame.fromRawCsv(csvAsString);

      expect(dataframe
          .series
          .elementAt(0)
          .data
          .take(10), [6, 1, 8, 1, 0, 5, 3, 10, 2, 8]);

      expect(dataframe
          .series
          .elementAt(3)
          .data
          .toList()
          .sublist(760), [26, 31, 0, 48, 27, 23, 0, 31]);
    });
  });
}
