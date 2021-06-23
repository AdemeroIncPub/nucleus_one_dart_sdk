import 'document_content_package.dart';

const documentSignatureSessionRecipientFormFieldJson =
    '{"ID":"A","DocumentSignatureFormFieldID":"B","DocumentSignatureSessionRecipientID":"C","DocumentSignatureSessionRecipientRank":0,"IsComplete":true,"Type":"D","PageIndex":1,"X":2.34,"Y":3.45,"Value":"E","PlacementRank":4}';
const documentSignatureSessionRecipientFormFieldCollectionJson =
    '[$documentSignatureSessionRecipientFormFieldJson]';
const documentSignatureSessionFormFieldPackageJson =
    '{"FormDesignType":"A","QuickDesignPlaceInitials":true,"QuickDesignPlaceFullName":false,"QuickDesignPlaceEmail":true,"QuickDesignPlaceTitle":false,"FormFields":[$documentSignatureSessionRecipientFormFieldJson],"CompletedFormFields":[$documentSignatureSessionRecipientFormFieldJson]}';
const documentSignatureSessionSigningRecipientJson = '{"Email":"A","FullName":"B"}';
const documentSignatureSessionSigningRecipientPackageJson =
    '{"RequireAccessCode":false,"SigningRecipient":$documentSignatureSessionSigningRecipientJson,"FormFieldPackage":$documentSignatureSessionFormFieldPackageJson,"ServerDate":"2021-06-23T15:56:33.360404143Z","ContentPackage":$documentContentPackageJson}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so longer as 100% coverage is achieved.
  */
}
