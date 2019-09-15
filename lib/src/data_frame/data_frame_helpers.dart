import 'package:ml_dataframe/src/data_frame/series.dart';
import 'package:quiver/iterables.dart';

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
    Iterable<int> columnIndices,
    String autoHeaderPrefix,
    [
      Iterable<String> rawActualHeader = const [],
      Iterable<String> predefinedHeader = const [],
    ]
) => predefinedHeader?.isNotEmpty == true
      ? predefinedHeader
      : (rawActualHeader?.isNotEmpty == true
        ? rawActualHeader.map((name) => name.trim())
        : enumerate(columnIndices)
            .map((index) => '${autoHeaderPrefix}${index.index}'));