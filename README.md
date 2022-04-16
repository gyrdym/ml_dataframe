[![Build Status](https://github.com/gyrdym/ml_dataframe/workflows/CI%20pipeline/badge.svg)](https://github.com/gyrdym/ml_dataframe/actions?query=branch%3Amaster+)
[![Coverage Status](https://coveralls.io/repos/github/gyrdym/ml_dataframe/badge.svg?branch=master)](https://coveralls.io/github/gyrdym/ml_dataframe?branch=master)
[![pub package](https://img.shields.io/pub/v/ml_dataframe.svg)](https://pub.dartlang.org/packages/ml_dataframe)
[![Gitter Chat](https://badges.gitter.im/gyrdym/gyrdym.svg)](https://gitter.im/gyrdym/)

# ml_dataframe
A way to store and manipulate data

The library exposes in-memory storage for dynamically data. The storage is represented by [DataFrame](https://github.com/gyrdym/ml_dataframe/blob/master/lib/src/data_frame/data_frame.dart) class.

## Usage example:

```dart
final data = [
  ['Id', 'SepalLengthCm', 'SepalWidthCm', 'PetalLengthCm', 'PetalWidthCm', 'Species'],
  [1, 5.1, 3.5, 1.4, 0.2, 'Iris-setosa'],
  [2, 4.9, 3.0, 1.4, 0.2, 'Iris-setosa'],
  [89, 5.6, 3.0, 4.1, 1.3, 'Iris-versicolor'],
  [90, 5.5, 2.5, 4.0, 1.3, 'Iris-versicolor'],
  [91, 5.5, 2.6, 4.4, 1.2, 'Iris-versicolor'],
];

final dataframe = DataFrame(data);

print(dataframe);

// DataFrame (5 x 6)
//  Id   SepalLengthCm   SepalWidthCm   PetalLengthCm   PetalWidthCm           Species
//   1             5.1            3.5             1.4            0.2       Iris-setosa
//   2             4.9            3.0             1.4            0.2       Iris-setosa
//  89             5.6            3.0             4.1            1.3   Iris-versicolor
//  90             5.5            2.5             4.0            1.3   Iris-versicolor
//  91             5.5            2.6             4.4            1.2   Iris-versicolor
```

[DataFrame](https://github.com/gyrdym/ml_dataframe/blob/master/lib/src/data_frame/data_frame.dart) makes it possible to:

- Get the header of the data:

```dart
final header = dataframe.header;

print(header);
// ['Id', 'SepalLengthCm', 'SepalWidthCm', 'PetalLengthCm', 'PetalWidthCm', 'Species']
```

- Get the rows of the data:

```dart
final rows = dataframe.rows;

print(rows);
// [
//   [1, 5.1, 3.5, 1.4, 0.2, 'Iris-setosa'],
//   [2, 4.9, 3.0, 1.4, 0.2, 'Iris-setosa'],
//   [89, 5.6, 3.0, 4.1, 1.3, 'Iris-versicolor'],
//   [90, 5.5, 2.5, 4.0, 1.3, 'Iris-versicolor'],
//   [91, 5.5, 2.6, 4.4, 1.2, 'Iris-versicolor'],
// ],
``` 

