import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:test/test.dart';

void main() {
  group('getHousingDataFrame', () {
    test('should create a dataframe', () {
      final data = getHousingDataFrame();

      print(data);

      expect(data.header, [
        'CRIM',
        'ZN',
        'INDUS',
        'CHAS',
        'NOX',
        'RM',
        'AGE',
        'DIS',
        'RAD',
        'TAX',
        'PTRATIO',
        'B',
        'LSTAT',
        'MEDV',
      ]);
      expect(data.shape, [506, 14]);
      expect(data.rows.elementAt(0), [
        0.00632,
        18.00,
        2.310,
        0,
        0.5380,
        6.5750,
        65.20,
        4.0900,
        1,
        296.0,
        15.30,
        396.90,
        4.98,
        24.00
      ]);
      expect(data.rows.elementAt(505), [
        0.04741,
        0.00,
        11.930,
        0,
        0.5730,
        6.0300,
        80.80,
        2.5050,
        1,
        273.0,
        21.00,
        396.90,
        7.88,
        11.90
      ]);
    });
  });
}
