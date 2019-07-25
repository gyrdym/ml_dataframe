import 'package:xrange/zrange.dart';

Map<int, ZRange> createIndexToRangeMapping(Iterable<num> indices,
    [Iterable<ZRange> ranges]) {
  final nominalRanges = ranges != null ? ranges : <ZRange>[];
  return Map.fromEntries(
    indices.map((idx) {
      final range = nominalRanges.firstWhere((range) => range.contains(idx),
          orElse: () => ZRange.singleton(idx));
      return MapEntry(idx, range);
    }),
  );
}