import 'package:ml_dataframe/src/data_frame/data_frame.dart';
import 'package:ml_dataframe/src/data_frame/series.dart';
import 'package:test/test.dart';

void main() {
  group('DataFrame.fromSeries', () {
    test('should initialize from a series collection', () {
      final series = [
        Series('first', <dynamic>[1, 2, 3, true, '32']),
        Series('second', <dynamic>[10, 12, 323, false, '1132']),
        Series('third', <dynamic>[-10, 202, null, true, 'abs']),
      ];
      final frame = DataFrame.fromSeries(series);

      expect(frame.header, equals(['first', 'second', 'third']));
      expect(frame.rows, equals([
        [    1,     10,    -10 ],
        [    2,     12,    202 ],
        [    3,    323,   null ],
        [ true,  false,   true ],
        [ '32',  '1132', 'abs' ],
      ]));
      expect(frame.series.map((series) => series.name),
          equals(['first', 'second', 'third']));
      expect(frame.series.map((series) => series.data), equals([
        <dynamic>[1, 2, 3, true, '32'],
        <dynamic>[10, 12, 323, false, '1132'],
        <dynamic>[-10, 202, null, true, 'abs'],
      ]));
    });
  });
}
