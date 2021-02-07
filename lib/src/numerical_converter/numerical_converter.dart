import 'package:ml_dataframe/src/data_frame/data_frame.dart';

abstract class NumericalConverter {
  DataFrame convertDataFrame(DataFrame data);
  Iterable<Iterable<double?>> convertRawData(Iterable<Iterable<dynamic>> data);
  Iterable<Iterable<double>> convertRawDataStrict(Iterable<Iterable<dynamic>> data);
}
