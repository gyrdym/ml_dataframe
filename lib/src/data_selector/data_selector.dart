import 'package:quiver/iterables.dart';

class DataSelector {
  DataSelector(this._columnIndices);

  final Iterable<num> _columnIndices;

  Iterable<Iterable<dynamic>> select(
      Iterable<Iterable<dynamic>> headlessData) => headlessData.map(_filterRow);

  Iterable<dynamic> _filterRow(Iterable<dynamic> row) =>
      _columnIndices.isNotEmpty
          ? enumerate<dynamic>(row)
              .where((indexed) => _columnIndices.contains(indexed.index))
              .map<dynamic>((indexed) => indexed.value)
          : row;
}
