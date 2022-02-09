import 'package:ml_dataframe/src/data_frame/data_frame.dart';
import 'package:test/test.dart';

void main() {
  group('DataFrame.fromMatrix', () {
    final rawCSV = '''
id,age,salary,children,gender,profession,years_of_education,married,height,weight
1,25,30000,2,M,Teacher,5,true,189,78.3
2,46,85000,0,M,Manager,7,false,176,45.2
3,36,45000,1,F,Teacher,4,true,165,98.4
4,23,10000,5,M,Mushroom Collector,0,true,179,57.4
5,22,30000,2,M,Butcher,5,true,189,87.9
6,28,82000,0,F,Scientist,10,true,179,98.3
7,46,85000,0,M,Scientist,7,false,176,67.8
8,36,45000,1,F,Teacher,4,true,165,76.8
9,23,N/A,2,M,Unemployed,0,true,179,56.7
10,25,32000,4,F,Teacher,5,true,189,98.7
11,49,34700,0,M,Plumber,7,true,176,120.3
12,36,45000,1,F,Paramedic,4,true,165,67.9
13,23,42900,2,M,Researcher,0,true,179,92.3
''';
    final dataFrame = DataFrame.fromRawCsv(rawCSV);
    final expectedRows10Cols7 = '''
DataFrame (13 x 10)
 id   age   salary   children   gender           profession   ...   weight
  1    25    30000          2        M              Teacher   ...     78.3
  2    46    85000          0        M              Manager   ...     45.2
  3    36    45000          1        F              Teacher   ...     98.4
  4    23    10000          5        M   Mushroom Collector   ...     57.4
  5    22    30000          2        M              Butcher   ...     87.9
...   ...      ...        ...      ...                  ...   ...      ...
  9    23      N/A          2        M           Unemployed   ...     56.7
 10    25    32000          4        F              Teacher   ...     98.7
 11    49    34700          0        M              Plumber   ...    120.3
 12    36    45000          1        F            Paramedic   ...     67.9
 13    23    42900          2        M           Researcher   ...     92.3''';

    final expectedRows1000Cols1000 = '''
DataFrame (13 x 10)
id   age   salary   children   gender           profession   years_of_education   married   height   weight
 1    25    30000          2        M              Teacher                    5      true      189     78.3
 2    46    85000          0        M              Manager                    7     false      176     45.2
 3    36    45000          1        F              Teacher                    4      true      165     98.4
 4    23    10000          5        M   Mushroom Collector                    0      true      179     57.4
 5    22    30000          2        M              Butcher                    5      true      189     87.9
 6    28    82000          0        F            Scientist                   10      true      179     98.3
 7    46    85000          0        M            Scientist                    7     false      176     67.8
 8    36    45000          1        F              Teacher                    4      true      165     76.8
 9    23      N/A          2        M           Unemployed                    0      true      179     56.7
10    25    32000          4        F              Teacher                    5      true      189     98.7
11    49    34700          0        M              Plumber                    7      true      176    120.3
12    36    45000          1        F            Paramedic                    4      true      165     67.9
13    23    42900          2        M           Researcher                    0      true      179     92.3''';

    test('should print dataframe correctly with default maxRows=10, maxCols=7',
        () {
      expect(dataFrame.toString(), expectedRows10Cols7);
    });

    test(
        'should print dataframe correctly with maxRows=1000, maxCols=1000, resulting in full print',
        () {
      expect(dataFrame.toString(maxCols: 1000, maxRows: 1000),
          expectedRows1000Cols1000);
    });
  });
}
