import 'package:ml_dataframe/src/data_frame/data_frame.dart';
import 'package:ml_dataframe/src/numerical_converter/numerical_converter.dart';

class NumericalConverterImpl implements NumericalConverter {
  NumericalConverterImpl(this._strictTypeCheck);

  final bool _strictTypeCheck;
  final Exception _exception =
    Exception('Unsuccessful attempt to convert a value to number');

  @override
  DataFrame convertDataFrame(DataFrame data) =>
    DataFrame(convertRawData(data.rows), header: data.header);

  @override
  Iterable<Iterable<double>> convertRawData(Iterable<Iterable> data) =>
    data.map((row) => row.map(_convertSingle));

  double _convertSingle(dynamic value) {
    if (value is String) {
      try {
        return double.parse(value);
      } catch (e) {
        if (_strictTypeCheck) {
          throw _exception;
        }
        return null;
      }
    }
    if (value is bool) {
      if (_strictTypeCheck) {
        throw _exception;
      }
      return value ? 1 : 0;
    }
    if (value is! num) {
      if (_strictTypeCheck) {
        throw _exception;
      }
      return null;
    }
    return value * 1.0 as double;
  }
}
