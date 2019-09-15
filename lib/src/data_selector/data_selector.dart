import 'package:quiver/iterables.dart';

class DataSelector {
  DataSelector(this._columnIndices);

  final Iterable<num> _columnIndices;

  Iterable<Iterable<dynamic>> select(
      Iterable<Iterable<dynamic>> headlessData) sync* {
    for (final row in headlessData) {
      yield _filterRow(row);
    }
  }

  Iterable<dynamic> _filterRow(Iterable<dynamic> row) =>
      _columnIndices?.isNotEmpty == true
          ? enumerate<dynamic>(row)
              .where((indexed) => _columnIndices.contains(indexed.index))
              .map<dynamic>((indexed) => indexed.value)
          : row;
}
