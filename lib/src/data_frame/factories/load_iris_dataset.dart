import 'package:ml_dataframe/src/data_frame/data_frame.dart';
import 'package:ml_dataframe/src/data_frame/factories/from_csv.dart';

/// Returns a [DataFrame] instance filled with [Iris](https://www.kaggle.com/datasets/uciml/iris) dataset
///
/// The dataset consists of 6 columns and 150 rows. The data is divided into 3
/// classes - `Iris-setosa`, `Iris-versicolor` and `Iris-virginica`
///
/// The target column is `Species`
///
/// The dataset is good for training classification models
Future<DataFrame> loadIrisDataset() {
  return fromCsv('lib/src/data_frame/datasets/iris.csv');
}
