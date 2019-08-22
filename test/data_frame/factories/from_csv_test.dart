import 'package:ml_dataframe/src/data_frame/factories/from_csv.dart';
import 'package:test/test.dart';

void main() {
  group('fromCsv', () {
    test('should create a dataframe from csv file', () async {
      final data = await fromCsv('test/data_frame/factories/elo_blatter.csv');

      expect(data.series, hasLength(8));
      expect(data.header, equals(['country', 'elo98', 'elo15', 'confederation',
        'gdp06', 'popu06', 'gdp_source', 'popu_source']));
      expect(data.series.map((series) => series.data.length),
          equals(List.filled(8, 209)));
      expect(data.rows.elementAt(141),
          equals(['Pakistan', 928, 963, 'AFC', 3740.607865, 160905794,
            'World Bank', 'World Bank']));
    });
  });
}
