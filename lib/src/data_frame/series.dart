class Series {
  Series(this.name, this.data, {
    bool isDiscrete = false,
  }) : discreteValues = isDiscrete
      ? Set<dynamic>.from(data)
      : const <dynamic>[];

  final String name;
  final Iterable data;
  final Iterable discreteValues;

  bool get isDiscrete => discreteValues.isNotEmpty;
}
