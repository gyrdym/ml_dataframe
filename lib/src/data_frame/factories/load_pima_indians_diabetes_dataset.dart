import 'package:ml_dataframe/src/data_frame/data_frame.dart';
import 'package:ml_dataframe/src/data_frame/factories/from_csv.dart';

/// Returns a [DataFrame] instance filled with [Pima Indians diabetes](https://www.kaggle.com/datasets/uciml/pima-indians-diabetes-database) dataset
///
/// The dataset consists of 9 columns and 768 rows
///
/// The target column is `Outcome` which contains either `1` or `0`
///
/// The dataset is good for training classification models
Future<DataFrame> loadPimaIndiansDiabetesDataset() {
  return fromCsv('lib/src/data_frame/datasets/pima_indians_diabetes.csv');
}
