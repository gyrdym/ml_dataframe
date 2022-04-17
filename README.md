[![Build Status](https://github.com/gyrdym/ml_dataframe/workflows/CI%20pipeline/badge.svg)](https://github.com/gyrdym/ml_dataframe/actions?query=branch%3Amaster+)
[![Coverage Status](https://coveralls.io/repos/github/gyrdym/ml_dataframe/badge.svg?branch=master)](https://coveralls.io/github/gyrdym/ml_dataframe?branch=master)
[![pub package](https://img.shields.io/pub/v/ml_dataframe.svg)](https://pub.dartlang.org/packages/ml_dataframe)
[![Gitter Chat](https://badges.gitter.im/gyrdym/gyrdym.svg)](https://gitter.im/gyrdym/)

# ml_dataframe
A way to store and manipulate data

The library exposes in-memory storage for dynamical data. The storage is represented by [DataFrame](https://github.com/gyrdym/ml_dataframe/blob/master/lib/src/data_frame/data_frame.dart) class.

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

## [DataFrame](https://github.com/gyrdym/ml_dataframe/blob/master/lib/src/data_frame/data_frame.dart) API with examples:

Let's assume that all the examples below are applied to the dataframe instance which was created above.

### Get the header of the data

```dart
final header = dataframe.header;

print(header);
// ['Id', 'SepalLengthCm', 'SepalWidthCm', 'PetalLengthCm', 'PetalWidthCm', 'Species']
```

### Get the rows of the data

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

### Get the series collection (columns) of the data

```dart
final series = dataframe.series;

print(series);
// [
//   'Id': [1, 2, 89, 90, 91],
//   'SepalLengthCm': [5.1, 4.9, 5.6, 5.5, 5.5],
//   'SepalWidthCm': [3.5, 3.0, 3.0, 2.5, 2.6],
//   'PetalLengthCm': [1.4, 1.4, 4.1, 4.0, 4.4],
//   'PetalWidthCm': [0.2, 0.2, 1.3, 1.3, 1.2],
//   'Species': ['Iris-setosa', 'Iris-setosa', 'Iris-versicolor', 'Iris-versicolor', 'Iris-versicolor'],
// ],
``` 

### Get the shape of the data

```dart
final shape = dataframe.shape;

print(shape);
// [5, 6] - 5 rows, 6 columns
```

### Add a series

```dart
final firstSeries = Series('super_series', [1, 2, 3, 4, 5, 6]);

dataframe.addSeries([firstSeries]);

print(dataframe.series.last);
// 'super_series': [1, 2, 3, 4, 5, 6]
```

### Drop a series by a series name

```dart
print(dataframe.shape);
// [5, 6] - 6 rows, 6 columns 

dataframe.dropSeries(names: ['Id']);

print(dataframe.shape);
// [5, 5] -  after a series had been dropped, the number of columns became one lesser 
````

### Drop a series by a series index

```dart
print(dataframe.shape);
// [5, 6] - 5 rows, 6 columns 

dataframe.dropSeries(indices: [0]);

print(dataframe.shape);
// [5, 5] -  after a series had been dropped, the number of columns became one lesser 
````

### Sample a new dataframe from rows of an existing dataframe

```dart
final sampled = dataframe.sampleFromRows([0, 5]);

print(sampled);
// DataFrame (2 x 6)
//  Id   SepalLengthCm   SepalWidthCm   PetalLengthCm   PetalWidthCm           Species
//   1             5.1            3.5             1.4            0.2       Iris-setosa
//  91             5.5            2.6             4.4            1.2   Iris-versicolor 
````

### Sample a new dataframe from series indices of an existing dataframe

```dart
final sampled = dataframe.sampleFromSeries(indices: [0, 1]);

print(sampled);
// DataFrame (5 x 2)
//  Id   SepalLengthCm
//   1             5.1
//   2             4.9
//  89             5.6
//  90             5.5
//  91             5.5
````

### Sample a new dataframe from series names of an existing dataframe

```dart
final sampled = dataframe.sampleFromSeries(names: ['Id', 'SepalLengthCm']);

print(sampled);
// DataFrame (5 x 2)
//  Id   SepalLengthCm
//   1             5.1
//   2             4.9
//  89             5.6
//  90             5.5
//  91             5.5
````

### Save a dataframe to a JSON file

```dart
await dataframe.saveAsJson('path/to/json/file.json');
````

### Shuffle rows in a dataframe

```dart
print(dataframe);
// DataFrame (5 x 6)
//  Id   SepalLengthCm   SepalWidthCm   PetalLengthCm   PetalWidthCm           Species
//   1             5.1            3.5             1.4            0.2       Iris-setosa
//   2             4.9            3.0             1.4            0.2       Iris-setosa
//  89             5.6            3.0             4.1            1.3   Iris-versicolor
//  90             5.5            2.5             4.0            1.3   Iris-versicolor
//  91             5.5            2.6             4.4            1.2   Iris-versicolor

dataframe.shuffle(); 

print(dataframe);
// DataFrame (5 x 6)
//  Id   SepalLengthCm   SepalWidthCm   PetalLengthCm   PetalWidthCm           Species
//  89             5.6            3.0             4.1            1.3   Iris-versicolor
//   1             5.1            3.5             1.4            0.2       Iris-setosa
//  91             5.5            2.6             4.4            1.2   Iris-versicolor
//   2             4.9            3.0             1.4            0.2       Iris-setosa
//  90             5.5            2.5             4.0            1.3   Iris-versicolor
````

One can use `seed` parameter to keep the order of rows disregard the number of `shuffle` calls:   

```dart
dataframe.shuffle(seed: 10);
``` 

### Get a json-serializable representation

```dart
final json = dataframe.toJson(); // json contains a serializable map
```

### Convert a dataframe to a [ml_linalg](https://pub.dev/packages/ml_linalg) matrix:

```dart
dataframe.toMatrix();
```

the method throws an error if there are inconvertible to a number values in the dataframe.

### Get a series by its index

```dart
final series = dataframe[0];

print(series);
// Id: [1, 2, 89, 90, 91]
```

### Get a series by its name

```dart
final series = dataframe['Id'];

print(series);
// Id: [1, 2, 89, 90, 91]
```

## Ways to create a dataframe

## `fromCsv` function

```dart
import 'package:ml_dataframe/ml_dataframe.dart';

final data = await fromCsv('path/to/csv/file.csv');
```

If the `csv` file doe not have a header row, it's needed to provide the corresponding flag:

```dart
import 'package:ml_dataframe/ml_dataframe.dart';

final data = await fromCsv('path/to/csv/file.csv', headerExists: false);
```

## Restore previously persisted as a json file dataframe - `fromJson` function

```dart
import 'package:ml_dataframe/ml_dataframe.dart';

final data = await fromJson('path/to/json/file.json');
```

This function works in conjunction with DataFrame `saveAsJson` method.

### Contacts
If you have questions, feel free to text me on
 - [Twitter](https://twitter.com/ilgyrd) 
 - [Facebook](https://www.facebook.com/ilya.gyrdymov)
 - [Linkedin](https://www.linkedin.com/in/gyrdym/)
