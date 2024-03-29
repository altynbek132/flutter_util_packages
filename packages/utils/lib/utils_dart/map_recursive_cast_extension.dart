extension MapRecursiveCastExtension on Map {
  Map<String, dynamic> castMap() {
    return cast<String, dynamic>();
  }

  Map<K, dynamic> castRecursive<K>() {
    return map((key, value) {
      if (value is Map) {
        return MapEntry(key as K, value.castRecursive<K>());
      }
      return MapEntry(key as K, value);
    }).cast<K, dynamic>();
  }

  Map<String, dynamic> castRecursiveMap() {
    return castRecursive<String>();
  }
}

extension ObjectRecursiveCastExtension on Object {
  Map<String, dynamic> castMap() {
    return (this as Map).cast<String, dynamic>();
  }

  Map<K, dynamic> castRecursive<K>() {
    return (this as Map).castRecursive<K>();
  }

  Map<String, dynamic> castRecursiveMap() {
    return castRecursive<String>();
  }
}
