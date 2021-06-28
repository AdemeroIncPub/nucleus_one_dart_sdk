const documentSignatureSessionJson =
    '{"ID":"A","CreatedOn":"2021-06-21T15:21:18.483838807Z","ModifiedOn":"0001-01-01T00:00:00Z","CreatedByUserID":"B","CreatedByUserEmail":"C","CreatedByUserName":"D","LastModifiedByUserID":"E","LastModifiedByUserEmail":"F","LastModifiedByUserName":"G","DocumentID":"H","DocumentRevisionID":"I","IsActive":true,"IsComplete":false,"WasStopped":true,"CompletedOn":"0001-01-01T00:00:00Z","IsRendered":false,"RenderedOn":"0001-01-01T00:00:00Z","FormDesignType":"J","UseAccessCode":true,"AccessCode":"K","UseCustomSubjectAndBody":false,"CustomSubject":"L","CustomBody":"M","QuickDesignPlaceInitials":true,"QuickDesignPlaceFullName":false,"QuickDesignPlaceEmail":true,"QuickDesignPlaceTitle":false}';
const documentSignatureSessionRecipientJson =
    '{"ID":"A","TenantID":"B","DocumentID":"C","DocumentCreatedOn":"2021-06-21T13:51:14.231757Z","DocumentBucketName":"D","DocumentThumbnailObjectName":"E","DocumentName":"F","DocumentNameLower":"G","DocumentPageCount":0,"DocumentFileSize":1,"DocumentClassificationID":"H","DocumentClassificationName":"I","DocumentClassificationNameLower":"J","DocumentPreviewMetadata":[{"K":"L"}],"DocumentSignatureSessionID":"M","DocumentSignatureSessionIsActive":true,"DocumentSignatureSessionIsComplete":false,"UniqueID":"N","Rank":2,"Email":"O","FullName":"P","Type":"Q","TenantMemberID":"R","SigningRequestSent":true,"RequestedOn":"0001-01-01T00:00:00Z","IsActive":false,"IsComplete":true,"CompletedOn":"0002-01-01T00:00:00Z","IPAddress":"S"}';

const documentSignatureSessionPackageJson =
    '{"Session":$documentSignatureSessionJson,"Recipients":[$documentSignatureSessionRecipientJson],"BeginSession":true,"ResetSession":false}';
const documentSignatureSessionPackageCollectionJson = '[$documentSignatureSessionPackageJson]';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so longer as 100% coverage is achieved.
  */
}
