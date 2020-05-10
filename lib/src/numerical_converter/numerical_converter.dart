import 'package:ml_dataframe/src/data_frame/data_frame.dart';

abstract class NumericalConverter {
  DataFrame convertDataFrame(DataFrame data);
  Iterable<Iterable<double>> convertRawData(Iterable<Iterable<dynamic>> data);
  Map<String, dynamic> toJson();
}
