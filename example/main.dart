import 'package:ml_dataframe/ml_dataframe.dart';

void dataframeWithHeaderDemo() {
  final dataframe = DataFrame([
    ['Age', 'City', 'Blood Group', 'is_married'],
    [33, 'Larnaca', 'A', true],
    [17, 'Limassol', 'A', false],
    [29, 'Nicosia', 'B', false],
    [45, 'Larnaca', 'AB', true],
  ]);

  print('\nDataframe with the header row: ');
  print(dataframe);
}

void headlessDataframeDemo() {
  final dataframe = DataFrame([
    [33, 'Larnaca', 'A', true],
    [17, 'Limassol', 'A', false],
    [29, 'Nicosia', 'B', false],
    [45, 'Larnaca', 'AB', true],
  ], headerExists: false);

  print('\nHeadless dataframe: ');
  print(dataframe);
}

void headlessDataframeWithCustomPrefixDemo() {
  final dataframe = DataFrame([
    [33, 'Larnaca', 'A', true],
    [17, 'Limassol', 'A', false],
    [29, 'Nicosia', 'B', false],
    [45, 'Larnaca', 'AB', true],
  ], headerExists: false, autoHeaderPrefix: 'SERIES_');

  print('\nHeadless dataframe with custom prefix: ');
  print(dataframe);
}

void predefinedHeaderDataframeDemo() {
  final dataframe = DataFrame(
      [
        [33, 'Larnaca', 'A', true],
        [17, 'Limassol', 'A', false],
        [29, 'Nicosia', 'B', false],
        [45, 'Larnaca', 'AB', true],
      ],
      headerExists: false,
      header: ['AGE', 'TOWN', 'Blood', 'MARRIED']);

  print('\nDataframe with predefined header: ');
  print(dataframe);
}

void dataframeWithSpecificColumnsDemo() {
  final dataframe = DataFrame([
    ['Age', 'City', 'Blood Group', 'is_married'],
    [33, 'Larnaca', 'A', true],
    [17, 'Limassol', 'A', false],
    [29, 'Nicosia', 'B', false],
    [45, 'Larnaca', 'AB', true],
  ], columnNames: [
    'Age',
    'is_married'
  ]);

  print('\nDataframe with specific columns: ');
  print(dataframe);
}

void main() {
  dataframeWithHeaderDemo();
  headlessDataframeDemo();
  headlessDataframeWithCustomPrefixDemo();
  predefinedHeaderDataframeDemo();
  dataframeWithSpecificColumnsDemo();
}
