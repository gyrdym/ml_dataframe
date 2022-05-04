import 'package:ml_dataframe/src/data_frame/factories/prefilled_dataframes/get_iris_data_frame.dart';
import 'package:test/test.dart';

void main() {
  group('getIrisDataFrame', () {
    test('should create a dataframe', () {
      final data = getIrisDataFrame();

      expect(data.header, [
        'Id',
        'SepalLengthCm',
        'SepalWidthCm',
        'PetalLengthCm',
        'PetalWidthCm',
        'Species'
      ]);
      expect(data.shape, [150, 6]);
      expect(data.rows.elementAt(0), [1, 5.1, 3.5, 1.4, 0.2, 'Iris-setosa']);
      expect(data.rows.elementAt(113),
          [114, 5.7, 2.5, 5.0, 2.0, 'Iris-virginica']);
      expect(data.rows.elementAt(149),
          [150, 5.9, 3.0, 5.1, 1.8, 'Iris-virginica']);
    });
  });
}
