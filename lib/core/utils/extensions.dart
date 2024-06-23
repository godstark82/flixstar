extension IntX on int? {
  bool get isNull => this == null;

  bool get isNotNull => this != null;
}
