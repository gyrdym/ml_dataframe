class WrongSeriesShapeException implements Exception {
  WrongSeriesShapeException(this.expectedLength, this.actualLength);

  final int expectedLength;
  final int actualLength;

  @override
  String toString() => 'Wrong series shape, expected series data length '
      '$expectedLength, got $actualLength';
}
