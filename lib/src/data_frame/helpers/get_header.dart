import 'package:quiver/iterables.dart';

Iterable<String> getHeader(
    int columnsNum,
    String autoHeaderPrefix,
    [
      Iterable<String> rawActualHeader = const [],
      Iterable<String> predefinedHeader = const [],
    ]
    ) {
  if (predefinedHeader?.isNotEmpty == true) {
    return predefinedHeader.take(columnsNum);
  }

  if (rawActualHeader?.isNotEmpty == true) {
    return rawActualHeader.map((name) => name.trim());
  }

  return count(0)
      .take(columnsNum)
      .map((index) => '${autoHeaderPrefix}${index}');
}
