import 'dart:convert';
import 'dart:io';

import 'package:ml_dataframe/src/serializable/serializable.dart';

mixin SerializableMixin implements Serializable {
  @override
  Future<File> saveAsJson(String fileName, {bool rewrite = false}) async {
    final file = File(fileName);

    if (!rewrite && await file.exists()) {
      throw Exception('The file already exists, path $fileName');
    }

    final serializable = toJson();
    final json = jsonEncode(serializable);

    return file.writeAsString(json);
  }
}
