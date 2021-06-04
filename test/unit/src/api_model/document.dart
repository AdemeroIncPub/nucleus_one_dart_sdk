const documentJson =
    r'{"ID":"A","DocumentID":"B","CreatedOn":"2021-01-06T17:37:32.327396Z","PurgeDate":"0001-01-31T00:00:00Z","Name":"C","PageCount":21,"FileSize":1234,"ThumbnailUrl":"D","IsSigned":false,"ClassificationID":"E","ClassificationName":"F","PreviewMetadata":[{"0":"A","1":"B","2":"C"}],"DocumentApprovalID":"G","DocumentApprovalCreatedOn":"0001-01-01T00:00:00Z","DocumentSubscriptionID":"H","DocumentSubscriptionCreatedOn":"0001-01-01T00:00:00Z","DocumentSignatureSessionRecipientID":"I","DocumentSignatureSessionID":"J","DocumentSignatureSessionRecipientEmail":"K","DocumentSignatureSessionRecipientFullName":"L","DocumentSignatureSessionRecipientRequestedOn":"0001-01-01T00:00:00Z","RoleName":"M","ProcessName":"N","ProcessElementName":"O","Score":123,"CreatedByUserID":"P","CreatedByUserEmail":"Q","CreatedByUserName":"R","NameLower":"S","Origin":"T","IsActive":false,"IsClassified":false,"IsMarkedForPurge":false,"SignatureSessionIsActive":false,"HasSinglePageImages":false,"SignaturesCompletedOn":"0001-01-01T00:00:00Z","PurgeMarkedOn":"0001-01-01T00:00:00Z","FailedBuildAttempts":false,"LastError":"U","BucketName":"V","SourceObjectName":"W","ThumbnailObjectName":"X","ClassificationNameLower":"Y"}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so longer as 100% coverage is achieved.
  */
}
