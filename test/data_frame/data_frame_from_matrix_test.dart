import 'package:ml_dataframe/src/data_frame/data_frame.dart';
import 'package:ml_linalg/dtype.dart';
import 'package:ml_linalg/matrix.dart';
import 'package:test/test.dart';

void main() {
  group('DataFrame.fromMatrix', () {
    test('should initialize from matrix without predefined header', () {
      final matrix = Matrix.fromList([
        [1,    2,    3,    4   ],
        [10,   20,   30,   40  ],
        [100,  200,  300,  400 ],
        [1000, 2000, 3000, 4000],
      ], dtype: DType.float32);
      final dataFrame = DataFrame.fromMatrix(matrix);

      expect(dataFrame.header, equals(['col_0', 'col_1', 'col_2', 'col_3']));

      expect(dataFrame.rows, equals([
        [1,    2,    3,    4   ],
        [10,   20,   30,   40  ],
        [100,  200,  300,  400 ],
        [1000, 2000, 3000, 4000],
      ]));

      expect(dataFrame.series, hasLength(4));

      expect(dataFrame[0].name, 'col_0');
      expect(dataFrame[0].data, equals([1, 10, 100, 1000]));
      expect(dataFrame['col_0'].data, equals([1, 10, 100, 1000]));

      expect(dataFrame[1].name, 'col_1');
      expect(dataFrame[1].data, equals([2, 20, 200, 2000]));
      expect(dataFrame['col_1'].data, equals([2, 20, 200, 2000]));

      expect(dataFrame[2].name, 'col_2');
      expect(dataFrame[2].data, equals([3, 30, 300, 3000]));
      expect(dataFrame['col_2'].data, equals([3, 30, 300, 3000]));

      expect(dataFrame[3].name, 'col_3');
      expect(dataFrame[3].data, equals([4, 40, 400, 4000]));
      expect(dataFrame['col_3'].data, equals([4, 40, 400, 4000]));

      expect(dataFrame.toMatrix(), same(matrix));
      expect(dataFrame.dtype, DType.float32);
    });

    test('should initialize from matrix with predefined header', () {
      final matrix = Matrix.fromList([
        [1,    2,    3,    4   ],
        [10,   20,   30,   40  ],
        [100,  200,  300,  400 ],
        [1000, 2000, 3000, 4000],
      ], dtype: DType.float32);
      final dataFrame = DataFrame.fromMatrix(matrix,
          header: ['how', 'doth', 'the', 'little']);

      expect(dataFrame.header, equals(['how', 'doth', 'the', 'little']));

      expect(dataFrame.rows, equals([
        [1,    2,    3,    4   ],
        [10,   20,   30,   40  ],
        [100,  200,  300,  400 ],
        [1000, 2000, 3000, 4000],
      ]));

      expect(dataFrame.series, hasLength(4));

      expect(dataFrame[0].name, 'how');
      expect(dataFrame[0].data, equals([1, 10, 100, 1000]));
      expect(dataFrame['how'].data, equals([1, 10, 100, 1000]));

      expect(dataFrame[1].name, 'doth');
      expect(dataFrame[1].data, equals([2, 20, 200, 2000]));
      expect(dataFrame['doth'].data, equals([2, 20, 200, 2000]));

      expect(dataFrame[2].name, 'the');
      expect(dataFrame[2].data, equals([3, 30, 300, 3000]));
      expect(dataFrame['the'].data, equals([3, 30, 300, 3000]));

      expect(dataFrame[3].name, 'little');
      expect(dataFrame[3].data, equals([4, 40, 400, 4000]));
      expect(dataFrame['little'].data, equals([4, 40, 400, 4000]));

      expect(dataFrame.toMatrix(), same(matrix));
      expect(dataFrame.dtype, DType.float32);
    });

    test('should ignore predefined header list elements that are out of '
        'range', () {

      final matrix = Matrix.fromList([
        [1,    2,    3,    4   ],
        [10,   20,   30,   40  ],
        [100,  200,  300,  400 ],
        [1000, 2000, 3000, 4000],
      ], dtype: DType.float32);

      final dataFrame = DataFrame.fromMatrix(matrix,
          header: ['how', 'doth', 'the', 'little', 'ololo', 'trololo']);

      expect(dataFrame.header, equals(['how', 'doth', 'the', 'little']));

      expect(dataFrame.rows, equals([
        [1,    2,    3,    4   ],
        [10,   20,   30,   40  ],
        [100,  200,  300,  400 ],
        [1000, 2000, 3000, 4000],
      ]));

      expect(dataFrame.series, hasLength(4));

      expect(dataFrame[0].name, 'how');
      expect(dataFrame['how'].data, equals([1, 10, 100, 1000]));

      expect(dataFrame[1].name, 'doth');
      expect(dataFrame['doth'].data, equals([2, 20, 200, 2000]));

      expect(dataFrame[2].name, 'the');
      expect(dataFrame['the'].data, equals([3, 30, 300, 3000]));

      expect(dataFrame[3].name, 'little');
      expect(dataFrame['little'].data, equals([4, 40, 400, 4000]));
      expect(dataFrame.dtype, DType.float32);
    });

    test('should ignore predefined header list elements that are out of '
        'range', () {

      final matrix = Matrix.fromList([
        [1,    2,    3,    4   ],
        [10,   20,   30,   40  ],
        [100,  200,  300,  400 ],
        [1000, 2000, 3000, 4000],
      ]);

      final dataFrame = DataFrame.fromMatrix(matrix,
          header: ['how', 'doth']);

      expect(dataFrame.header, equals(['how', 'doth']));

      expect(dataFrame.rows, equals([
        [1,    2,   ],
        [10,   20,  ],
        [100,  200, ],
        [1000, 2000,],
      ]));

      expect(dataFrame.series, hasLength(2));

      expect(dataFrame[0].name, 'how');
      expect(dataFrame['how'].data, equals([1, 10, 100, 1000]));

      expect(dataFrame[1].name, 'doth');
      expect(dataFrame['doth'].data, equals([2, 20, 200, 2000]));
    }, skip: true);

    test('should extract certain columns while initializing from matrix with '
        'predefined header', () {
      final matrix = Matrix.fromList([
        [1,    2,    3,    4   ],
        [10,   20,   30,   40  ],
        [100,  200,  300,  400 ],
        [1000, 2000, 3000, 4000],
      ], dtype: DType.float32);
      final dataFrame = DataFrame.fromMatrix(matrix,
          columns: [0, 3],
          header: ['how', 'doth', 'the', 'little']);

      expect(dataFrame.header, equals(['how', 'doth']));

      expect(dataFrame.rows, equals([
        [1,    4   ],
        [10,   40  ],
        [100,  400 ],
        [1000, 4000],
      ]));

      expect(dataFrame.series, hasLength(2));

      expect(dataFrame[0].name, 'how');
      expect(dataFrame[0].data, equals([1, 10, 100, 1000]));
      expect(dataFrame['how'].data, equals([1, 10, 100, 1000]));

      expect(dataFrame[1].name, 'doth');
      expect(dataFrame[1].data, equals([4, 40, 400, 4000]));
      expect(dataFrame['doth'].data, equals([4, 40, 400, 4000]));

      expect(dataFrame.dtype, DType.float32);
      expect(dataFrame.toMatrix(), equals([
        [1,    4   ],
        [10,   40  ],
        [100,  400 ],
        [1000, 4000],
      ]));
    });

    test('should initialize from matrix without predefined header but with '
        'auto header prefix', () {
      final matrix = Matrix.fromList([
        [1,    2,    3,    4   ],
        [10,   20,   30,   40  ],
        [100,  200,  300,  400 ],
        [1000, 2000, 3000, 4000],
      ], dtype: DType.float32);
      final dataFrame = DataFrame.fromMatrix(matrix,
          autoHeaderPrefix: 'super_');

      expect(dataFrame.header,
          equals(['super_0', 'super_1', 'super_2', 'super_3']));

      expect(dataFrame.rows, equals([
        [1,    2,    3,    4   ],
        [10,   20,   30,   40  ],
        [100,  200,  300,  400 ],
        [1000, 2000, 3000, 4000],
      ]));

      expect(dataFrame.series, hasLength(4));

      expect(dataFrame[0].name, 'super_0');
      expect(dataFrame[0].data, equals([1, 10, 100, 1000]));
      expect(dataFrame['super_0'].data, equals([1, 10, 100, 1000]));

      expect(dataFrame[1].name, 'super_1');
      expect(dataFrame[1].data, equals([2, 20, 200, 2000]));
      expect(dataFrame['super_1'].data, equals([2, 20, 200, 2000]));

      expect(dataFrame[2].name, 'super_2');
      expect(dataFrame[2].data, equals([3, 30, 300, 3000]));
      expect(dataFrame['super_2'].data, equals([3, 30, 300, 3000]));

      expect(dataFrame[3].name, 'super_3');
      expect(dataFrame[3].data, equals([4, 40, 400, 4000]));
      expect(dataFrame['super_3'].data, equals([4, 40, 400, 4000]));

      expect(dataFrame.dtype, DType.float32);
      expect(dataFrame.toMatrix(), same(matrix));
    });

    test('should initialize from matrix using certain columns', () {
      final matrix = Matrix.fromList([
        [1,    2,    3,    4   ],
        [10,   20,   30,   40  ],
        [100,  200,  300,  400 ],
        [1000, 2000, 3000, 4000],
      ], dtype: DType.float32);
      final dataFrame = DataFrame.fromMatrix(matrix, columns: [0, 3]);

      expect(dataFrame.header, equals(['col_0', 'col_1']));

      expect(dataFrame.rows, equals([
        [1,    4   ],
        [10,   40  ],
        [100,  400 ],
        [1000, 4000],
      ]));

      expect(dataFrame.series, hasLength(2));

      expect(dataFrame[0].name, 'col_0');
      expect(dataFrame[0].data, equals([1, 10, 100, 1000]));
      expect(dataFrame['col_0'].data, equals([1, 10, 100, 1000]));

      expect(dataFrame[1].name, 'col_1');
      expect(dataFrame[1].data, equals([4, 40, 400, 4000]));
      expect(dataFrame['col_1'].data, equals([4, 40, 400, 4000]));

      expect(dataFrame.dtype, DType.float32);
      expect(dataFrame.toMatrix(), equals([
        [1,    4   ],
        [10,   40  ],
        [100,  400 ],
        [1000, 4000],
      ]));
    });

    test('should initialize from matrix using predefined discrete column '
        'indices', () {
      final matrix = Matrix.fromList([
        [1,    2,    3,    4   ],
        [10,   20,   30,   40  ],
        [100,  200,  300,  400 ],
        [1000, 2000, 3000, 4000],
      ], dtype: DType.float32);
      final dataFrame = DataFrame.fromMatrix(matrix, discreteColumns: [0, 1]);

      expect(dataFrame.rows, equals([
        [1,    2,    3,    4   ],
        [10,   20,   30,   40  ],
        [100,  200,  300,  400 ],
        [1000, 2000, 3000, 4000],
      ]));

      expect(dataFrame.series, hasLength(4));

      expect(dataFrame[0].name, 'col_0');
      expect(dataFrame[0].data, equals([1, 10, 100, 1000]));
      expect(dataFrame['col_0'].data, equals([1, 10, 100, 1000]));
      expect(dataFrame['col_0'].isDiscrete, isTrue);

      expect(dataFrame[1].name, 'col_1');
      expect(dataFrame[1].data, equals([2, 20, 200, 2000]));
      expect(dataFrame['col_1'].data, equals([2, 20, 200, 2000]));
      expect(dataFrame['col_1'].isDiscrete, isTrue);

      expect(dataFrame[2].name, 'col_2');
      expect(dataFrame[2].data, equals([3, 30, 300, 3000]));
      expect(dataFrame['col_2'].data, equals([3, 30, 300, 3000]));
      expect(dataFrame['col_2'].isDiscrete, isFalse);

      expect(dataFrame[3].name, 'col_3');
      expect(dataFrame[3].data, equals([4, 40, 400, 4000]));
      expect(dataFrame['col_3'].data, equals([4, 40, 400, 4000]));
      expect(dataFrame['col_3'].isDiscrete, isFalse);

      expect(dataFrame.dtype, DType.float32);
      expect(dataFrame.toMatrix(), same(matrix));
    });

    test('should initialize from matrix using predefined discrete column '
        'names (in conjunction with predefined header)', () {
      final matrix = Matrix.fromList([
        [1,    2,    3,    4   ],
        [10,   20,   30,   40  ],
        [100,  200,  300,  400 ],
        [1000, 2000, 3000, 4000],
      ], dtype: DType.float32);
      final dataFrame = DataFrame.fromMatrix(matrix,
          header: ['first', 'second', 'third', 'fourth'],
          discreteColumnNames: ['first', 'fourth']);

      expect(dataFrame.rows, equals([
        [1,    2,    3,    4   ],
        [10,   20,   30,   40  ],
        [100,  200,  300,  400 ],
        [1000, 2000, 3000, 4000],
      ]));

      expect(dataFrame.series, hasLength(4));

      expect(dataFrame[0].name, 'first');
      expect(dataFrame[0].data, equals([1, 10, 100, 1000]));
      expect(dataFrame['first'].data, equals([1, 10, 100, 1000]));
      expect(dataFrame['first'].isDiscrete, isTrue);

      expect(dataFrame[1].name, 'second');
      expect(dataFrame[1].data, equals([2, 20, 200, 2000]));
      expect(dataFrame['second'].data, equals([2, 20, 200, 2000]));
      expect(dataFrame['second'].isDiscrete, isFalse);

      expect(dataFrame[2].name, 'third');
      expect(dataFrame[2].data, equals([3, 30, 300, 3000]));
      expect(dataFrame['third'].data, equals([3, 30, 300, 3000]));
      expect(dataFrame['third'].isDiscrete, isFalse);

      expect(dataFrame[3].name, 'fourth');
      expect(dataFrame[3].data, equals([4, 40, 400, 4000]));
      expect(dataFrame['fourth'].data, equals([4, 40, 400, 4000]));
      expect(dataFrame['fourth'].isDiscrete, isTrue);

      expect(dataFrame.dtype, DType.float32);
      expect(dataFrame.toMatrix(), same(matrix));
    });

    test('should initialize from matrix using predefined discrete column '
        'names even if predefined header is not defined', () {
      final matrix = Matrix.fromList([
        [1,    2,    3,    4   ],
        [10,   20,   30,   40  ],
        [100,  200,  300,  400 ],
        [1000, 2000, 3000, 4000],
      ], dtype: DType.float32);
      final dataFrame = DataFrame.fromMatrix(matrix,
          discreteColumnNames: ['col_0', 'col_3']);

      expect(dataFrame.rows, equals([
        [1,    2,    3,    4   ],
        [10,   20,   30,   40  ],
        [100,  200,  300,  400 ],
        [1000, 2000, 3000, 4000],
      ]));

      expect(dataFrame.series, hasLength(4));

      expect(dataFrame[0].name, 'col_0');
      expect(dataFrame[0].data, equals([1, 10, 100, 1000]));
      expect(dataFrame['col_0'].data, equals([1, 10, 100, 1000]));
      expect(dataFrame['col_0'].isDiscrete, isTrue);

      expect(dataFrame[1].name, 'col_1');
      expect(dataFrame[1].data, equals([2, 20, 200, 2000]));
      expect(dataFrame['col_1'].data, equals([2, 20, 200, 2000]));
      expect(dataFrame['col_1'].isDiscrete, isFalse);

      expect(dataFrame[2].name, 'col_2');
      expect(dataFrame[2].data, equals([3, 30, 300, 3000]));
      expect(dataFrame['col_2'].data, equals([3, 30, 300, 3000]));
      expect(dataFrame['col_2'].isDiscrete, isFalse);

      expect(dataFrame[3].name, 'col_3');
      expect(dataFrame[3].data, equals([4, 40, 400, 4000]));
      expect(dataFrame['col_3'].data, equals([4, 40, 400, 4000]));
      expect(dataFrame['col_3'].isDiscrete, isTrue);

      expect(dataFrame.dtype, DType.float32);
      expect(dataFrame.toMatrix(), same(matrix));
    });

    test('should ignore entire predefined discrete column name list if none of '
        'the names from the list matches the actual dataframe header', () {
      final matrix = Matrix.fromList([
        [1,    2,    3,    4   ],
        [10,   20,   30,   40  ],
        [100,  200,  300,  400 ],
        [1000, 2000, 3000, 4000],
      ], dtype: DType.float32);
      final dataFrame = DataFrame.fromMatrix(matrix,
          discreteColumnNames: ['ololo', 'trololo']);

      expect(dataFrame.rows, equals([
        [1,    2,    3,    4   ],
        [10,   20,   30,   40  ],
        [100,  200,  300,  400 ],
        [1000, 2000, 3000, 4000],
      ]));

      expect(dataFrame.series, hasLength(4));

      expect(dataFrame[0].name, 'col_0');
      expect(dataFrame[0].data, equals([1, 10, 100, 1000]));
      expect(dataFrame['col_0'].data, equals([1, 10, 100, 1000]));
      expect(dataFrame['col_0'].isDiscrete, isFalse);

      expect(dataFrame[1].name, 'col_1');
      expect(dataFrame[1].data, equals([2, 20, 200, 2000]));
      expect(dataFrame['col_1'].data, equals([2, 20, 200, 2000]));
      expect(dataFrame['col_1'].isDiscrete, isFalse);

      expect(dataFrame[2].name, 'col_2');
      expect(dataFrame[2].data, equals([3, 30, 300, 3000]));
      expect(dataFrame['col_2'].data, equals([3, 30, 300, 3000]));
      expect(dataFrame['col_2'].isDiscrete, isFalse);

      expect(dataFrame[3].name, 'col_3');
      expect(dataFrame[3].data, equals([4, 40, 400, 4000]));
      expect(dataFrame['col_3'].data, equals([4, 40, 400, 4000]));
      expect(dataFrame['col_3'].isDiscrete, isFalse);

      expect(dataFrame.dtype, DType.float32);
      expect(dataFrame.toMatrix(), same(matrix));
    });

    test('should ignore just those names of predefined discrete column name '
        'list, that do not match the actual dataframe header names', () {
      final matrix = Matrix.fromList([
        [1,    2,    3,    4   ],
        [10,   20,   30,   40  ],
        [100,  200,  300,  400 ],
        [1000, 2000, 3000, 4000],
      ], dtype: DType.float32);
      final dataFrame = DataFrame.fromMatrix(matrix,
          discreteColumnNames: ['col_1', 'ololo', 'trololo']);

      expect(dataFrame.rows, equals([
        [1,    2,    3,    4   ],
        [10,   20,   30,   40  ],
        [100,  200,  300,  400 ],
        [1000, 2000, 3000, 4000],
      ]));

      expect(dataFrame.series, hasLength(4));

      expect(dataFrame[0].name, 'col_0');
      expect(dataFrame[0].data, equals([1, 10, 100, 1000]));
      expect(dataFrame['col_0'].data, equals([1, 10, 100, 1000]));
      expect(dataFrame['col_0'].isDiscrete, isFalse);

      expect(dataFrame[1].name, 'col_1');
      expect(dataFrame[1].data, equals([2, 20, 200, 2000]));
      expect(dataFrame['col_1'].data, equals([2, 20, 200, 2000]));
      expect(dataFrame['col_1'].isDiscrete, isTrue);

      expect(dataFrame[2].name, 'col_2');
      expect(dataFrame[2].data, equals([3, 30, 300, 3000]));
      expect(dataFrame['col_2'].data, equals([3, 30, 300, 3000]));
      expect(dataFrame['col_2'].isDiscrete, isFalse);

      expect(dataFrame[3].name, 'col_3');
      expect(dataFrame[3].data, equals([4, 40, 400, 4000]));
      expect(dataFrame['col_3'].data, equals([4, 40, 400, 4000]));
      expect(dataFrame['col_3'].isDiscrete, isFalse);
      expect(dataFrame.dtype, DType.float32);

      expect(dataFrame.toMatrix(), same(matrix));
    });

    test('should consider both discrete indices and names', () {
      final matrix = Matrix.fromList([
        [1,    2,    3,    4   ],
        [10,   20,   30,   40  ],
        [100,  200,  300,  400 ],
        [1000, 2000, 3000, 4000],
      ], dtype: DType.float32);
      final dataFrame = DataFrame.fromMatrix(matrix,
          header: ['first', 'second', 'third', 'fourth'],
          discreteColumns: [2, 3],
          discreteColumnNames: ['first', 'second']);

      expect(dataFrame.rows, equals([
        [1,    2,    3,    4   ],
        [10,   20,   30,   40  ],
        [100,  200,  300,  400 ],
        [1000, 2000, 3000, 4000],
      ]));

      expect(dataFrame.series, hasLength(4));

      expect(dataFrame[0].name, 'first');
      expect(dataFrame[0].data, equals([1, 10, 100, 1000]));
      expect(dataFrame['first'].data, equals([1, 10, 100, 1000]));
      expect(dataFrame['first'].isDiscrete, isTrue);

      expect(dataFrame[1].name, 'second');
      expect(dataFrame[1].data, equals([2, 20, 200, 2000]));
      expect(dataFrame['second'].data, equals([2, 20, 200, 2000]));
      expect(dataFrame['second'].isDiscrete, isTrue);

      expect(dataFrame[2].name, 'third');
      expect(dataFrame[2].data, equals([3, 30, 300, 3000]));
      expect(dataFrame['third'].data, equals([3, 30, 300, 3000]));
      expect(dataFrame['third'].isDiscrete, isTrue);

      expect(dataFrame[3].name, 'fourth');
      expect(dataFrame[3].data, equals([4, 40, 400, 4000]));
      expect(dataFrame['fourth'].data, equals([4, 40, 400, 4000]));
      expect(dataFrame['fourth'].isDiscrete, isTrue);

      expect(dataFrame.dtype, DType.float32);
      expect(dataFrame.toMatrix(), same(matrix));
    });
  });
}
