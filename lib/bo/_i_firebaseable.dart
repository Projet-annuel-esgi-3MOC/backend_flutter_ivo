abstract class Firebaseable {
  String? _id;

  String get id => _id ?? '';

  /// This comes from a json object goten from jsonEnode
  factory Firebaseable.fromMap(Map<String, dynamic> json) {
    throw UnimplementedError('Subclasses must implement fromMap method');
  }
  String toJson();
  String toCreateJson();
}
