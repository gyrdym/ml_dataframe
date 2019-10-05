class Series {
  Series(this.name, this.data, {
    bool isDiscrete = false,
  }) : discreteValues = isDiscrete
      ? Set<dynamic>.from(data)
      : const <dynamic>[];

  /// A name of the [Series]
  final String name;

  /// Return a lazy iterable of data, containing in the [Series]
  final Iterable data;

  /// Returns a lazy iterable of the [data]'s unique values if the [Series]
  /// marked as [isDiscrete]. If [isDiscrete] is `false`, an empty list will be
  /// returned
  final Iterable discreteValues;

  /// Shows if [Series] contains just discrete values instead of continuous ones
  bool get isDiscrete => discreteValues.isNotEmpty;
}
