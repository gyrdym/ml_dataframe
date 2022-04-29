import 'package:ml_dataframe/src/data_frame/data_frame.dart';
import 'package:ml_dataframe/src/data_frame/factories/from_csv.dart';

/// Returns a [DataFrame] instance filled with [Iris](https://www.kaggle.com/datasets/uciml/iris) dataset
Future<DataFrame> loadIrisDataset() async {
  return fromCsv('lib/src/data_frame/datasets/iris.csv');
}
