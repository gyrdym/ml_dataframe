import 'dart:math' as math;

import 'package:quiver/iterables.dart';

List<int> generateUnorderedIndices(int length, [int seed]) {
  if (length <= 0) {
    return [];
  }

  final generator = math.Random(seed);
  final orderedIndices = List.generate(length, (i) => i);
  final indices = [...orderedIndices]
      .toList()
    ..shuffle(generator);
  final ensureIndicesAreUnordered = () => zip([indices, orderedIndices])
      .any((pair) => pair.first != pair.last);

  while (!ensureIndicesAreUnordered()) {
    indices.shuffle(generator);
  }

  return indices;
}
