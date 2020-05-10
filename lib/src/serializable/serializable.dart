import 'dart:io';

abstract class Serializable {
  Map<String, dynamic> toJson();

  Future<File> saveAsJson(String fileName, {bool rewrite = false});
}
