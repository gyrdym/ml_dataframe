import 'package:ml_dataframe/src/data_frame/factories/load_pima_indians_diabetes_dataset.dart';
import 'package:test/test.dart';

void main() {
  group('loadPimaIndiansDiabetesDataset', () {
    test('should create a dataframe', () async {
      final data = await loadPimaIndiansDiabetesDataset();

      expect(data.header, [
        'Pregnancies',
        'Glucose',
        'BloodPressure',
        'SkinThickness',
        'Insulin',
        'BMI',
        'DiabetesPedigreeFunction',
        'Age',
        'Outcome'
      ]);
      expect(data.shape, [768, 9]);
      expect(data.rows.elementAt(0), [6, 148, 72, 35, 0, 33.6, 0.627, 50, 1]);
      expect(data.rows.elementAt(372), [0, 84, 64, 22, 66, 35.8, 0.545, 21, 0]);
      expect(data.rows.elementAt(767), [1, 93, 70, 31, 0, 30.4, 0.315, 23, 0]);
    });
  });
}
