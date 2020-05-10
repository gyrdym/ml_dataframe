import 'package:ml_dataframe/src/numerical_converter/numerical_converter.dart';
import 'package:ml_dataframe/src/numerical_converter/numerical_converter_impl.dart';

NumericalConverter fromNumericalConverterJson(Map<String, dynamic> json) =>
    NumericalConverterImpl.fromJson(json);
