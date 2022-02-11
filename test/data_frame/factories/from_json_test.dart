import 'package:ml_dataframe/src/data_frame/factories/from_json.dart';
import 'package:test/test.dart';

void main() {
  group('fromJson', () {
    final fileName = 'test/data_frame/factories/data_frame.json';
    final header = [
      'country',
      'elo98',
      'elo15',
      'confederation',
      'gdp06',
      'popu06',
      'gdp_source',
      'popu_source'
    ];

    test('should return a valid data frame', () async {
      final dataFrame = await fromJson(fileName);

      expect(dataFrame.header, header);
      expect(dataFrame.rows.elementAt(107), [
        'Libya',
        1446,
        1478,
        'CAF',
        25008.83906,
        5686475,
        'World Bank',
        'World Bank'
      ]);
      expect(dataFrame.series.map((series) => series.name), header);
    });
  });
}
