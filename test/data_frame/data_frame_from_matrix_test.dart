import 'package:ml_dataframe/src/data_frame/data_frame.dart';
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
      ]);
      final dataFrame = DataFrame.fromMatrix(matrix);

      expect(dataFrame.header, equals(['col_0', 'col_1', 'col_2', 'col_3']));

      expect(dataFrame.rows, equals([
        [1,    2,    3,    4   ],
        [10,   20,   30,   40  ],
        [100,  200,  300,  400 ],
        [1000, 2000, 3000, 4000],
      ]));

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
    });

    test('should initialize from matrix with predefined header', () {
      final matrix = Matrix.fromList([
        [1,    2,    3,    4   ],
        [10,   20,   30,   40  ],
        [100,  200,  300,  400 ],
        [1000, 2000, 3000, 4000],
      ]);
      final dataFrame = DataFrame.fromMatrix(matrix,
          header: ['how', 'doth', 'the', 'little']);

      expect(dataFrame.header, equals(['how', 'doth', 'the', 'little']));

      expect(dataFrame.rows, equals([
        [1,    2,    3,    4   ],
        [10,   20,   30,   40  ],
        [100,  200,  300,  400 ],
        [1000, 2000, 3000, 4000],
      ]));

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
    });

    test('should initialize from matrix without predefined header but with '
        'auto header prefix', () {
      final matrix = Matrix.fromList([
        [1,    2,    3,    4   ],
        [10,   20,   30,   40  ],
        [100,  200,  300,  400 ],
        [1000, 2000, 3000, 4000],
      ]);
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

      expect(dataFrame.toMatrix(), same(matrix));
    });

    test('should initialize from matrix using certain columns', () {
      final matrix = Matrix.fromList([
        [1,    2,    3,    4   ],
        [10,   20,   30,   40  ],
        [100,  200,  300,  400 ],
        [1000, 2000, 3000, 4000],
      ]);
      final dataFrame = DataFrame.fromMatrix(matrix, columns: [0, 3]);

      expect(dataFrame.header, equals(['col_0', 'col_3']));

      expect(dataFrame.rows, equals([
        [1,    4   ],
        [10,   40  ],
        [100,  400 ],
        [1000, 4000],
      ]));

      expect(dataFrame[0].name, 'col_0');
      expect(dataFrame[0].data, equals([1, 10, 100, 1000]));
      expect(dataFrame['col_0'].data, equals([1, 10, 100, 1000]));

      expect(dataFrame[1].name, 'col_3');
      expect(dataFrame[1].data, equals([4, 40, 400, 4000]));
      expect(dataFrame['col_3'].data, equals([4, 40, 400, 4000]));

      expect(dataFrame.toMatrix(), isNot(same(matrix)));
    });
  });
}
