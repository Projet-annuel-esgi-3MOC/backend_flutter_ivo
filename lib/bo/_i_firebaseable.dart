abstract class Firebaseable {
  String? _id;

  String get id => _id ?? '';

  factory Firebaseable.fromMap(Map<String, dynamic> json) {
    throw UnimplementedError('Subclasses must implement fromMap method');
  }
  String toJson();
}
