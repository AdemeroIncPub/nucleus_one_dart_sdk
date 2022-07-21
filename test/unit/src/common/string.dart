import 'package:nucleus_one_dart_sdk/src/common/string.dart' as string;
import 'package:test/test.dart';

import '../../../src/common.dart';

void main() {
  group('String tests', () {
    test('isNotEmpty method test', () {
      expect(string.isNotEmpty(null), isFalse);
      expect(string.isNotEmpty(''), isFalse);
      expect(string.isNotEmpty(' '), isTrue);
      expect(string.isNotEmpty('1'), isTrue);
    });

    test('isNullOrEmpty method test', () {
      expect(string.isNullOrEmpty(' '), isFalse);
      expect(string.isNullOrEmpty(null), isTrue);
      expect(string.isNullOrEmpty(''), isTrue);
    });

    group('CommonFormatting class tests', () {
      test('replaceOrganizationAndProjectPlaceholders method tests', () {
        final project = getStandardN1Project();
        expect('<projectId>'.replaceOrganizationAndProjectPlaceholders(project), project.id);
      });

      test('replaceOrganizationPlaceholder method tests', () {
        expect('<organizationId>'.replaceOrganizationPlaceholder('123'), '123');
      });

      test('replaceDocumentIdPlaceholder method tests', () {
        expect('<documentId>'.replaceDocumentIdPlaceholder('123'), '123');
      });

      test('replaceDocumentSignatureFormIdPlaceholder method tests', () {
        expect('<documentSignatureFormId>'.replaceDocumentSignatureFormIdPlaceholder('123'), '123');
      });

      test('replaceDocumentSignatureFormFieldIdPlaceholder method tests', () {
        expect(
            '<documentSignatureFormFieldId>'.replaceDocumentSignatureFormFieldIdPlaceholder('123'),
            '123');
      });

      test('replaceDocumentSignatureSessionIdPlaceholder method tests', () {
        expect('<documentSignatureSessionId>'.replaceDocumentSignatureSessionIdPlaceholder('123'),
            '123');
      });

      test('replaceDocumentSignatureSessionRecipientIdPlaceholder method tests', () {
        expect(
            '<documentSignatureSessionRecipientId>'
                .replaceDocumentSignatureSessionRecipientIdPlaceholder('123'),
            '123');
      });

      test('replaceSignatureFormTemplateIdPlaceholder method tests', () {
        expect('<signatureFormTemplateId>'.replaceSignatureFormTemplateIdPlaceholder('123'), '123');
      });

      test('replaceFormTemplateIdPlaceholder method tests', () {
        expect('<formTemplateId>'.replaceFormTemplateIdPlaceholder('123'), '123');
      });

      test('replaceFormTemplateFieldIdPlaceholder method tests', () {
        expect('<formTemplateFieldId>'.replaceFormTemplateFieldIdPlaceholder('123'), '123');
      });

      test('replaceTaskIdPlaceholder method tests', () {
        expect('<taskId>'.replaceTaskIdPlaceholder('123'), '123');
      });
    });
  });
}
