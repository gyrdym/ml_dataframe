import 'package:ml_dataframe/src/data_frame/data_frame.dart';
import 'package:ml_dataframe/src/data_frame/factories/prefilled_dataframes/get_pima_indians_diabetes_data_frame.dart';

/// Returns a [DataFrame] instance filled with [Pima Indians diabetes](https://www.kaggle.com/datasets/uciml/pima-indians-diabetes-database) dataset
///
/// The dataset consists of 9 columns and 768 rows
///
/// The target column is `Outcome` which contains either `1` or `0`
///
/// The dataset is good for training classification models
///
/// Deprecated, use synchronous [getPimaIndiansDiabetesDataFrame] instead
@deprecated
Future<DataFrame> loadPimaIndiansDiabetesDataset() {
  return Future.value(getPimaIndiansDiabetesDataFrame());
}
