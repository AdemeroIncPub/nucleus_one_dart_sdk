import 'package:nucleus_one_dart_sdk/nucleus_one_dart_sdk.dart';
import 'package:nucleus_one_dart_sdk/src/api_model/document_upload.dart' as api_mod;
import 'package:test/test.dart';

import '../../../src/common.dart';
import '../api_model/document_upload.dart';

void main() {
  group('DocumentUpload class tests', () {
    performStandardModelTests<DocumentUpload, api_mod.DocumentUpload>(
      apiModelJson: documentUploadJson,
      expectedPublicFieldCount: 7,
      fieldsAndExpectedValues: (apiModel) => <dynamic, dynamic>{
        apiModel.signedUrl: 'A',
        apiModel.objectName: 'B',
        apiModel.uniqueId: 'C',
        apiModel.originalFilename: 'D',
        apiModel.originalFileSize: 0,
        apiModel.classificationID: 'E',
        apiModel.fieldIDsAndValues: {
          'A': {'A', 'B'}
        },
      },
    );
  });
}
