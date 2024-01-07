import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:flutterfire_gen/src/parser/from_json_field_parser.dart';
import 'package:flutterfire_gen/src/utils/dart_type_util.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'from_json_field_parser_test.mocks.dart';

@GenerateMocks([InterfaceType, InterfaceElement])
void main() {
  group('FromJsonFieldParser test', () {
    late final MockInterfaceType stringDartType;
    late final MockInterfaceElement stringElement;
    late final MockInterfaceType nullableStringDartType;
    late final MockInterfaceElement nullableStringElement;
    late final MockInterfaceType dateTimeDartType;
    late final MockInterfaceElement dateTimeElement;
    late final MockInterfaceType nullableDateTimeDartType;
    late final MockInterfaceElement nullableDateTimeElement;

    setUpAll(() {
      stringDartType = MockInterfaceType();
      stringElement = MockInterfaceElement();
      when(stringElement.name).thenReturn('String');
      when(stringDartType.isDartCoreList).thenReturn(false);
      when(stringDartType.isJsonMap).thenReturn(false);
      when(stringDartType.nullabilitySuffix).thenReturn(NullabilitySuffix.none);
      when(stringDartType.element).thenReturn(stringElement);
      when(stringDartType.typeArguments).thenReturn([]);

      nullableStringDartType = MockInterfaceType();
      nullableStringElement = MockInterfaceElement();
      when(nullableStringElement.name).thenReturn('String');
      when(nullableStringDartType.isDartCoreList).thenReturn(false);
      when(nullableStringDartType.isJsonMap).thenReturn(false);
      when(nullableStringDartType.nullabilitySuffix)
          .thenReturn(NullabilitySuffix.question);
      when(nullableStringDartType.element).thenReturn(nullableStringElement);
      when(nullableStringDartType.typeArguments).thenReturn([]);

      dateTimeDartType = MockInterfaceType();
      dateTimeElement = MockInterfaceElement();
      when(dateTimeElement.name).thenReturn('DateTime');
      when(dateTimeDartType.isDartCoreList).thenReturn(false);
      when(dateTimeDartType.isJsonMap).thenReturn(false);
      when(dateTimeDartType.nullabilitySuffix)
          .thenReturn(NullabilitySuffix.none);
      when(dateTimeDartType.element).thenReturn(dateTimeElement);
      when(dateTimeDartType.typeArguments).thenReturn([]);

      nullableDateTimeDartType = MockInterfaceType();
      nullableDateTimeElement = MockInterfaceElement();
      when(nullableDateTimeElement.name).thenReturn('DateTime');
      when(nullableDateTimeDartType.isDartCoreList).thenReturn(false);
      when(nullableDateTimeDartType.isJsonMap).thenReturn(false);
      when(nullableDateTimeDartType.nullabilitySuffix)
          .thenReturn(NullabilitySuffix.question);
      when(nullableDateTimeDartType.element)
          .thenReturn(nullableDateTimeElement);
      when(nullableDateTimeDartType.typeArguments).thenReturn([]);
    });

    test('test String field', () {
      final parser = FromJsonFieldParser(
        name: 'text',
        dartType: stringDartType,
        defaultValueString: null,
        jsonConverterConfig: null,
      );
      final result = parser.toString();
      expect(result, "text: extendedJson['text'] as String,");
    });

    test('test String field with default value', () {
      final parser = FromJsonFieldParser(
        name: 'text',
        dartType: stringDartType,
        defaultValueString: "'defaultText'",
        jsonConverterConfig: null,
      );
      final result = parser.toString();
      expect(result, "text: extendedJson['text'] as String? ?? 'defaultText',");
    });

    test('test String? field', () {
      final parser = FromJsonFieldParser(
        name: 'text',
        dartType: nullableStringDartType,
        defaultValueString: null,
        jsonConverterConfig: null,
      );
      final result = parser.toString();
      expect(result, "text: extendedJson['text'] as String?,");
    });

    test('test String? field with default value', () {
      final parser = FromJsonFieldParser(
        name: 'text',
        dartType: nullableStringDartType,
        defaultValueString: "'defaultText'",
        jsonConverterConfig: null,
      );
      final result = parser.toString();
      expect(result, "text: extendedJson['text'] as String? ?? 'defaultText',");
    });

    test('test DateTime field', () {
      final parser = FromJsonFieldParser(
        name: 'createdAt',
        dartType: dateTimeDartType,
        defaultValueString: null,
        jsonConverterConfig: null,
      );
      final result = parser.toString();
      expect(
        result,
        "createdAt: (extendedJson['createdAt'] as Timestamp).toDate(),",
      );
    });

    test('test DateTime? field', () {
      final parser = FromJsonFieldParser(
        name: 'createdAt',
        dartType: nullableDateTimeDartType,
        defaultValueString: null,
        jsonConverterConfig: null,
      );
      final result = parser.toString();
      expect(
        result,
        "createdAt: (extendedJson['createdAt'] as Timestamp?)?.toDate(),",
      );
    });
  });
}
