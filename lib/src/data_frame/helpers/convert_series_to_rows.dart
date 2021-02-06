import 'package:ml_dataframe/src/data_frame/series.dart';

Iterable<Iterable<dynamic>> convertSeriesToRows(Iterable<Series> series) sync* {
  final iterators = series
      .map((series) => series.data.iterator)
      .toList(growable: false);

  while (iterators.fold(true, (isActive, iterator) => iterator.moveNext())) {
    yield iterators
        .map((iterator) => iterator.current)
        .toList(growable: false);
  }
}
