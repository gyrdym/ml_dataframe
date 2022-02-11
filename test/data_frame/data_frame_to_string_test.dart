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
    final dataFrame1 = DataFrame.fromRawCsv(rawCSV);
    final rawCSV2 = '''
id,age,salary
1,25,30000
2,46,85000
3,46,85000
''';
    final dataFrame2 = DataFrame.fromRawCsv(rawCSV2);

    final dataFrames = [dataFrame1, dataFrame2];

    final expected = <String, String>{};

    expected['1:10x7'] = '''
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

    expected['1:1000x1000'] = '''
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

    expected['1:0x10'] = '''
DataFrame (13 x 10)''';

    expected['1:3x0'] = '''
DataFrame (13 x 10)''';

    expected['1:1x1000'] = '''
DataFrame (13 x 10)
id   age   salary   children   gender   profession   years_of_education   married   height   weight
 1    25    30000          2        M      Teacher                    5      true      189     78.3''';

    expected['1:1000x1'] = '''
DataFrame (13 x 10)
id
 1
 2
 3
 4
 5
 6
 7
 8
 9
10
11
12
13''';

    expected['1:3x2'] = '''
DataFrame (13 x 10)
 id   ...   weight
  1   ...     78.3
...   ...      ...
 12   ...     67.9
 13   ...     92.3''';

    expected['1:3x3'] = '''
DataFrame (13 x 10)
 id   age   ...   weight
  1    25   ...     78.3
...   ...   ...      ...
 12    36   ...     67.9
 13    23   ...     92.3''';

    expected['1:1x1'] = '''
DataFrame (13 x 10)
id
 1''';

    expected['2:10x7'] = '''
DataFrame (3 x 3)
id   age   salary
 1    25    30000
 2    46    85000
 3    46    85000''';

    expected['2:1000x1000'] = '''
DataFrame (3 x 3)
id   age   salary
 1    25    30000
 2    46    85000
 3    46    85000''';

    expected['2:0x10'] = '''
DataFrame (3 x 3)''';

    expected['2:3x0'] = '''
DataFrame (3 x 3)''';

    expected['2:1x1000'] = '''
DataFrame (3 x 3)
id   age   salary
 1    25    30000''';

    expected['2:1000x1'] = '''
DataFrame (3 x 3)
id
 1
 2
 3''';

    expected['2:3x2'] = '''
DataFrame (3 x 3)
id   ...   salary
 1   ...    30000
 2   ...    85000
 3   ...    85000''';

    expected['2:3x3'] = '''
DataFrame (3 x 3)
id   age   salary
 1    25    30000
 2    46    85000
 3    46    85000''';

    expected['2:1x1'] = '''
DataFrame (3 x 3)
id
 1''';

    for (var entry in expected.entries) {
      final dfNumberAndSpecs = entry.key.split(':');
      final dfIndex = int.parse(dfNumberAndSpecs[0]) - 1;
      final specs = dfNumberAndSpecs[1].split('x');
      final maxRows = int.parse(specs[0]);
      final maxCols = int.parse(specs[1]);
      test(
          'should print dataFrame${dfNumberAndSpecs[0]} with maxRows=$maxRows, maxCols=$maxCols correctly',
          () {
        expect(dataFrames[dfIndex].toString(maxRows: maxRows, maxCols: maxCols),
            entry.value);
      });
    }
  });
}
