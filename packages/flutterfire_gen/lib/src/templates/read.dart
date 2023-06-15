import '../firestore_document_visitor.dart';
import '../flutterfire_gen.dart';

/// Returns Read class template.
String readClassTemplate({
  required FirestoreDocumentConfig config,
  required FirestoreDocumentVisitor visitor,
  required Map<String, dynamic> fields,
}) {
  return '''
class ${config.readClassName} {
  const ${config.readClassName}({
    ${fields.entries.map((entry) => 'required this.${entry.key},').join('\n')}
  });

  ${fields.entries.map((entry) => 'final ${entry.value} ${entry.key};').join('\n')}

  Map<String, dynamic> toJson() {
    return {
      ${fields.entries.map((entry) => "'${entry.key}': ${entry.key},").join('\n')}
    };
  }

  factory ${config.readClassName}.fromJson(Map<String, dynamic> json) {
    return ${config.readClassName}(
      ${fields.entries.map((entry) {
    final key = entry.key;
    final value = entry.value;
    final defaultValue = visitor.defaultValues[key];
    if (defaultValue != null) {
      return "$key: json['$key'] as $value? ?? $defaultValue,";
    } else {
      return "$key: json['$key'] as $value,";
    }
  }).join('\n')}
    );
  }

  factory ${config.readClassName}.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return ${config.readClassName}.fromJson(<String, dynamic>{
      ...data,
      '${config.documentName}Id': ds.id,
    });
  }

  ${config.readClassName} copyWith({
    ${fields.entries.map((entry) => '${entry.value}? ${entry.key},').join('\n')}
  }) {
    return ${config.readClassName}(
      ${fields.entries.map((entry) => '${entry.key}: ${entry.key} ?? this.${entry.key},').join('\n')}
    );
  }
}
''';
}