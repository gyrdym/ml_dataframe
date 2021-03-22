import 'dart:convert';

import 'dart:io';

import 'package:csv/csv.dart';
import 'package:ml_dataframe/src/data_reader/data_reader.dart';
import 'package:ml_dataframe/src/data_reader/file_factory/file_factory.dart';

class CsvDataReader implements DataReader {
  CsvDataReader(String fileName, this._csvCodec, [FileFactory? createFile]) :
        _file = createFile == null
            ? fileFactory(fileName)
            : createFile(fileName);

  final CsvCodec _csvCodec;
  final File _file;

  @override
  Future<List<List<dynamic>>> extractData() =>
      _file.openRead()
          .cast<List<int>>()
          .transform(utf8.decoder)
          .transform(_csvCodec.decoder)
          .toList();
}
