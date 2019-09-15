import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:ml_dataframe/src/data_frame/data_frame.dart';
import 'package:ml_linalg/matrix.dart';
import 'package:test/test.dart';

void main() {
  group('DataFrame', () {
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

    test('should convert stored data into matrix', () {
      final data = [
        ['col_1',  'col_2', 'col_3',  'col_4',   'col_5'],
        [  '1',       2,        3,        0,         32 ],
        [   10,      12,      323,      1.5,       1132 ],
        [  -10,     202,     1000,     '1.5',     0.005 ],
      ];
      final frame = DataFrame(data, headerExists: true,
          columnNames: ['col_1', 'col_3', 'col_4']);

      expect(frame.toMatrix(), isA<Matrix>());
      expect(frame.toMatrix(), equals([
        [  1,    3,   0],
        [ 10,  323, 1.5],
        [-10, 1000, 1.5],
      ]));
    });

    test('should provide access to its series by series name', () {
      final data = [
        ['first',  'second', 'third'],
        [  '1',        2,         3 ],
        [   10,       12,       323 ],
        [  -10,      202,      1000 ],
      ];
      final frame = DataFrame(data);

      expect(frame['first'].name, 'first');
      expect(frame['first'].data, equals(['1', 10, -10]));

      expect(frame['second'].name, 'second');
      expect(frame['second'].data, equals([2, 12, 202]));

      expect(frame['third'].name, 'third');
      expect(frame['third'].data, equals([3, 323, 1000]));
    });

    test('should provide access to its series by series index', () {
      final data = [
        ['first',  'second', 'third'],
        [  '1',        2,         3 ],
        [   10,       12,       323 ],
        [  -10,      202,      1000 ],
      ];
      final frame = DataFrame(data);

      expect(frame[0].name, 'first');
      expect(frame[0].data, equals(['1', 10, -10]));

      expect(frame[1].name, 'second');
      expect(frame[1].data, equals([2, 12, 202]));

      expect(frame[2].name, 'third');
      expect(frame[2].data, equals([3, 323, 1000]));
    });

    test('should return null if one tries to access a series using a key of '
        'improper type (neither String nor int)', () {
      final data = [
        ['first',  'second', 'third'],
        [  '1',        2,         3 ],
        [   10,       12,       323 ],
        [  -10,      202,      1000 ],
      ];
      final frame = DataFrame(data);

      expect(frame[{1}], isNull);
      expect(frame[1.2], isNull);
      expect(frame[[1, 2]], isNull);
    });

    test('should throw a range error if one tries to access a series using an '
        'integer key which is out of range', () {
      final data = [
        ['first',  'second', 'third'],
        [  '1',        2,         3 ],
        [   10,       12,       323 ],
        [  -10,      202,      1000 ],
      ];
      final frame = DataFrame(data);

      expect(() => frame[3], throwsRangeError);
      expect(() => frame[4], throwsRangeError);
      expect(() => frame[-1], throwsRangeError);
    });
  });
}
