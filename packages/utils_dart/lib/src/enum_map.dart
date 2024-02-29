class EnumValues<KEY, VALUE> {
  Map<KEY, VALUE> map;
  Map<VALUE, KEY>? reverseMap;

  EnumValues(this.map);

  Map<VALUE, KEY> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
