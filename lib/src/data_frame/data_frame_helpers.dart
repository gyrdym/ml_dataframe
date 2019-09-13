import 'package:ml_dataframe/src/data_frame/series.dart';

Iterable<Series> convertRowsToSeries(
    Iterable<String> columnHeaders,
    Iterable<Iterable<dynamic>> rows,
) sync* {
  final rowIterators = rows
      .map((row) => row.iterator)
      .toList(growable: false);

  for (final header in columnHeaders) {
    final column = rowIterators
        .where((iterator) => iterator.moveNext())
        .map<dynamic>((iterator) => iterator.current)
        .toList(growable: false);
    yield Series(header, column);
  }
}

Iterable<Iterable<dynamic>> convertSeriesToRows(Iterable<Series> series) sync* {
  final iterators = series
      .map((series) => series.data.iterator)
      .toList(growable: false);

  while (iterators.fold(true, (isActive, iterator) => iterator.moveNext())) {
    yield iterators.map<dynamic>((iterator) => iterator.current);
  }
}

Iterable<String> getHeader(
    Iterable<int> indices,
    String autoHeaderPrefix,
    [
      Iterable<String> rawActualHeader,
      Iterable<String> predefinedHeader,
    ]
) {
  final fallbackHeader = indices.map((index) => '${autoHeaderPrefix}${index}');

  return predefinedHeader ?? (
      rawActualHeader != null
          ? rawActualHeader.map((dynamic name) => name.toString().trim())
          : fallbackHeader
  );
}