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
      test('replaceOrgIdAndProjectIdPlaceholdersUsingProject method tests', () {
        final project = getStandardN1Project();
        expect('<projectId>'.replaceOrgIdAndProjectIdPlaceholdersUsingProject(project), project.id);
      });

      test('replaceOrgIdAndProjectIdPlaceholders method tests', () {
        final project = getStandardN1Project();
        expect(
            '<organizationId>/<projectId>'
                .replaceOrgIdAndProjectIdPlaceholders(project.organization.id, project.id),
            '${project.organization.id}/${project.id}');
      });

      test('replaceOrgIdPlaceholder method tests', () {
        expect('<organizationId>'.replaceOrgIdPlaceholder('123'), '123');
      });

      test('replaceDocumentIdPlaceholder method tests', () {
        expect('<documentId>'.replaceDocumentIdPlaceholder('123'), '123');
      });

      test('replaceDocumentFolderIdPlaceholder method tests', () {
        expect('<documentFolderId>'.replaceDocumentFolderIdPlaceholder('123'), '123');
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
