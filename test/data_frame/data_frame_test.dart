import 'dart:convert';
import 'dart:io';

import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:ml_dataframe/src/data_frame/data_frame.dart';
import 'package:ml_dataframe/src/data_frame/data_frame_json_keys.dart';
import 'package:ml_dataframe/src/numerical_converter/numerical_converter_json_keys.dart';
import 'package:ml_linalg/matrix.dart';
import 'package:test/test.dart';

void main() {
  group('DataFrame', () {
    final data = [
      ['first',  'second', 'third'],
      [  '1',        2,         3 ],
      [   10,       12,       323 ],
      [  -10,      202,      1000 ],
    ];

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

    group('[] operator', () {
      test('should provide access to its series by series name', () {
        final frame = DataFrame(data);

        expect(frame['first'].name, 'first');
        expect(frame['first'].data, equals(['1', 10, -10]));

        expect(frame['second'].name, 'second');
        expect(frame['second'].data, equals([2, 12, 202]));

        expect(frame['third'].name, 'third');
        expect(frame['third'].data, equals([3, 323, 1000]));
      });

      test('should provide access to its series by series index', () {
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
        final frame = DataFrame(data);

        expect(frame[{1}], isNull);
        expect(frame[1.2], isNull);
        expect(frame[[1, 2]], isNull);
      });

      test('should throw a range error if one tries to access a series using an '
          'integer key which is out of range', () {
        final frame = DataFrame(data);

        expect(() => frame[3], throwsRangeError);
        expect(() => frame[4], throwsRangeError);
        expect(() => frame[-1], throwsRangeError);
      });
    });

    group('dropSeries', () {
      test('should drop series by indices and return a new DataFrame without '
          'these series', () {
        final data = [
          [  '1',       2,        3,        0,         32 ],
          [   10,      12,      323,      1.5,       1132 ],
          [  -10,     202,     1000,     '1.5',     0.005 ],
        ];
        final frame = DataFrame(data, headerExists: false);
        final reduced = frame.dropSeries(seriesIndices: [0, 2, 4]);

        expect(reduced.rows, equals([
          [   2,     0  ],
          [  12,   1.5  ],
          [ 202,  '1.5' ],
        ]));
      });

      test('should drop series by indices and return a new DataFrame without '
          'these series even if input indices are not unique', () {
        final data = [
          [  '1',       2,        3,        0,         32 ],
          [   10,      12,      323,      1.5,       1132 ],
          [  -10,     202,     1000,     '1.5',     0.005 ],
        ];
        final frame = DataFrame(data, headerExists: false);
        final reduced = frame.dropSeries(
            seriesIndices: [0, 2, 2, 0, 4, 2, 4, 0, 4]);

        expect(reduced.rows, equals([
          [   2,     0  ],
          [  12,   1.5  ],
          [ 202,  '1.5' ],
        ]));
      });

      test('should drop series by series names and return a new DataFrame '
          'without these series', () {
        final data = [
          [  '1',       2,        3,        0,         32 ],
          [   10,      12,      323,      1.5,       1132 ],
          [  -10,     202,     1000,     '1.5',     0.005 ],
        ];
        final frame = DataFrame(data, headerExists: false);
        final reduced = frame.dropSeries(
            seriesNames: ['col_0', 'col_2', 'col_4']);

        expect(reduced.rows, equals([
          [   2,     0  ],
          [  12,   1.5  ],
          [ 202,  '1.5' ],
        ]));
      });

      test('should drop series by series names and return a new DataFrame '
          'without these series even if input names are not unique', () {
        final data = [
          [  '1',       2,        3,        0,         32 ],
          [   10,      12,      323,      1.5,       1132 ],
          [  -10,     202,     1000,     '1.5',     0.005 ],
        ];
        final frame = DataFrame(data, headerExists: false);
        final reduced = frame.dropSeries(
            seriesNames: ['col_4', 'col_0', 'col_4', 'col_2', 'col_4',
              'col_2']);

        expect(reduced.rows, equals([
          [   2,     0  ],
          [  12,   1.5  ],
          [ 202,  '1.5' ],
        ]));
      });

      test('should return a copy of the DataFrame if none of the parameters '
          'are specified', () {
        final data = [
          [  '1',       2,        3,        0,         32 ],
          [   10,      12,      323,      1.5,       1132 ],
          [  -10,     202,     1000,     '1.5',     0.005 ],
        ];
        final frame = DataFrame(data, headerExists: false);
        final reduced = frame.dropSeries();

        expect(reduced.rows, equals([
          [  '1',       2,        3,        0,         32 ],
          [   10,      12,      323,      1.5,       1132 ],
          [  -10,     202,     1000,     '1.5',     0.005 ],
        ]));
      });
    });

    group('sampleFromSeries', () {
      test('should sample dataframe by series indices', () {
        final data = [
          [  '1',       2,        3,        0,         32 ],
          [   10,      12,      323,      1.5,       1132 ],
          [  -10,     202,     1000,     '1.5',     0.005 ],
        ];

        final dataFrame = DataFrame(data, headerExists: false);
        final sampled = dataFrame.sampleFromSeries(indices: [0, 1, 2, 3, 4]);

        expect(sampled.rows, equals([
          [  '1',       2,        3,        0,         32 ],
          [   10,      12,      323,      1.5,       1132 ],
          [  -10,     202,     1000,     '1.5',     0.005 ],
        ]));
      });

      test('should support repeating indices', () {
        final data = [
          [  '1',       2,        3,        0,         32 ],
          [   10,      12,      323,      1.5,       1132 ],
          [  -10,     202,     1000,     '1.5',     0.005 ],
        ];

        final dataFrame = DataFrame(data, headerExists: false);
        final sampled = dataFrame.sampleFromSeries(indices: [0, 1, 0, 1]);

        expect(sampled.rows, equals([
          [  '1',   2,  '1',  2 ],
          [   10,  12,  10,  12 ],
          [  -10, 202, -10, 202 ],
        ]));
      });

      test('should sample dataframe by series names', () {
        final data = [
          [  '1',       2,        3,        0,         32 ],
          [   10,      12,      323,      1.5,       1132 ],
          [  -10,     202,     1000,     '1.5',     0.005 ],
        ];

        final dataFrame = DataFrame(data, headerExists: false);
        final sampled = dataFrame.sampleFromSeries(
            names: ['col_0', 'col_1', 'col_2', 'col_3', 'col_4']);

        expect(sampled.rows, equals([
          [  '1',       2,        3,        0,         32 ],
          [   10,      12,      323,      1.5,       1132 ],
          [  -10,     202,     1000,     '1.5',     0.005 ],
        ]));
      });

      test('should ignore names parameter if indices parameter is '
          'provided', () {
        final data = [
          [  '1',       2,        3,        0,         32 ],
          [   10,      12,      323,      1.5,       1132 ],
          [  -10,     202,     1000,     '1.5',     0.005 ],
        ];

        final dataFrame = DataFrame(data, headerExists: false);
        final sampled = dataFrame.sampleFromSeries(
            indices: [1],
            names: ['col_0', 'col_1', 'col_2', 'col_3', 'col_4']);

        expect(sampled.rows, equals([
          [   2, ],
          [  12, ],
          [ 202, ],
        ]));
      });

      test('should throw an error if outranged indices are provided', () {
        final data = [
          [  '1',       2,        3,        0,         32 ],
          [   10,      12,      323,      1.5,       1132 ],
          [  -10,     202,     1000,     '1.5',     0.005 ],
        ];

        final dataFrame = DataFrame(data, headerExists: false);
        final actual = () => dataFrame.sampleFromSeries(indices: [1, 40]);

        expect(actual, throwsRangeError);
      });

      test('should throw an error if outranged negative indices are provided', () {
        final data = [
          [  '1',       2,        3,        0,         32 ],
          [   10,      12,      323,      1.5,       1132 ],
          [  -10,     202,     1000,     '1.5',     0.005 ],
        ];

        final dataFrame = DataFrame(data, headerExists: false);
        final actual = () => dataFrame.sampleFromSeries(indices: [2, -1]);

        expect(actual, throwsRangeError);
      });

      test('should throw an error if names of non existent columns are '
          'provided', () {
        final data = [
          [  '1',       2,        3,        0,         32 ],
          [   10,      12,      323,      1.5,       1132 ],
          [  -10,     202,     1000,     '1.5',     0.005 ],
        ];

        final dataFrame = DataFrame(data, headerExists: false);
        final actual = () => dataFrame.sampleFromSeries(names: ['col_0', 'col_100']);

        expect(actual, throwsException);
      });
    });

    group('serialization', () {
      final json = {
        dataFrameHeaderJsonKey: ['first',  'second', 'third'],
        dataFrameRowsJsonKey: [
          ['1', 2, 3],
          [10, 12, 323],
          [-10, 202, 1000],
        ],
        dataFrameNumericalConverterJsonKey: {
          strictTypeCheckJsonKey: false,
        },
      };

      final fileName = 'test/data_frame/data_frame.json';

      tearDown(() async {
        final file = File(fileName);
        if (await file.exists()) {
          await file.delete();
        }
      });

      test('should convert to serializable map', () {
        final dataFrame = DataFrame(data);
        final actualJson = dataFrame.toJson();
        expect(actualJson, equals(json));
      });

      test('should restore from json', () {
        final dataFrame = DataFrame.fromJson(json);
        expect(dataFrame.header, data[0]);
        expect(dataFrame.rows, data.skip(1));
      });

      test('should return a file pointer while saving as json', () async {
        final dataFrame = DataFrame(data);
        final file = await dataFrame.saveAsJson(fileName, rewrite: true);

        expect(file.existsSync(), isTrue);
      });

      test('should save serializable map to json file', () async {
        final dataFrame = DataFrame(data);

        await dataFrame.saveAsJson(fileName, rewrite: true);

        final file = File(fileName);

        expect(file.existsSync(), isTrue);
      });

      test('should save a correct json', () async {
        final dataFrame = DataFrame(data);

        await dataFrame.saveAsJson(fileName, rewrite: true);

        final file = File(fileName);
        final dataAsString = await file.readAsString();
        final actualJson = jsonDecode(dataAsString) as Map<String, dynamic>;

        expect(actualJson, json);
      });
    });
  });
}
