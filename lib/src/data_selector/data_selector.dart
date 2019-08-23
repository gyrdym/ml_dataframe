import 'package:quiver/iterables.dart';

class DataSelector {
  DataSelector(
      Iterable<int> columnIndices,
      Iterable<String> columnNames,
      this._header,
  ) : _columnIndices = columnIndices ?? enumerate(_header)
      .where((indexed) => columnNames?.isNotEmpty == true
        ? columnNames.contains(indexed.value)
        : true)
      .map((indexed) => indexed.index);

  final Iterable<String> _header;
  final Iterable<int> _columnIndices;

  Iterable<Iterable<dynamic>> select(
      Iterable<Iterable<dynamic>> headlessData) sync* {
    yield _filterRow(_header);

    for (final row in headlessData) {
      yield _filterRow(row);
    }
  }

  Iterable<dynamic> _filterRow(Iterable<dynamic> row) =>
      _columnIndices.isEmpty
          ? row
          : enumerate<dynamic>(row)
              .where((indexed) => _columnIndices.contains(indexed.index))
              .map<dynamic>((indexed) => indexed.value);
}
