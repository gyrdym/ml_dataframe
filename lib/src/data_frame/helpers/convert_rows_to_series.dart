import 'package:ml_dataframe/src/data_frame/series.dart';

Iterable<Series> convertRowsToSeries(
    Iterable<String> columnHeaders,
    Iterable<Iterable<dynamic>> rows,
    ) {
  final rowIterators = rows
      .map((row) => row.iterator)
      .toList(growable: false);

  return columnHeaders.map(((header) {
    final column = rowIterators
        .where((iterator) => iterator.moveNext())
        .map<dynamic>((iterator) => iterator.current)
        .toList(growable: false);

    return Series(header, column);
  })).toList(growable: false);
}
