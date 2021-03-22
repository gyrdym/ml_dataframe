import 'package:ml_dataframe/src/data_frame/data_frame.dart';
import 'package:ml_dataframe/src/numerical_converter/numerical_converter.dart';

class NumericalConverterImpl implements NumericalConverter {
  const NumericalConverterImpl();

  static final Exception _exception =
    Exception('Unsuccessful attempt to convert a value to number');

  @override
  DataFrame convertDataFrame(DataFrame data) =>
    DataFrame(convertRawData(data.rows), header: data.header);

  @override
  Iterable<Iterable<double?>> convertRawData(Iterable<Iterable> data) =>
    data.map((row) => row.map((value) => _convertSingle(value, false)));

  @override
  Iterable<Iterable<double>> convertRawDataStrict(Iterable<Iterable> data) =>
      data.map((row) => row.map((value) => _convertSingle(value, true)!));

  double? _convertSingle(dynamic value, bool strictCheck) {
    if (value is String) {
      try {
        return double.parse(value);
      } catch (e) {
        if (strictCheck) {
          throw _exception;
        }

        return null;
      }
    }

    if (value is bool) {
      if (strictCheck) {
        throw _exception;
      }

      return value ? 1 : 0;
    }

    if (value is! num) {
      if (strictCheck) {
        throw _exception;
      }

      return null;
    }

    return value * 1.0;
  }
}
