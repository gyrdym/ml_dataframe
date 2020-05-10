import 'dart:convert';
import 'dart:io';

import 'package:ml_dataframe/src/data_frame/data_frame.dart';
import 'package:ml_dataframe/src/data_frame/data_frame_impl.dart';

Future<DataFrame> fromJson(String fileName) async {
  final file = File(fileName);
  final dataAsString = await file.readAsString();
  final decoded = jsonDecode(dataAsString) as Map<String, dynamic>;

  return DataFrameImpl.fromJson(decoded);
}
