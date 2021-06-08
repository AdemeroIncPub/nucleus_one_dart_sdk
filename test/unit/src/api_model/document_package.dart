const documentSubscriptionJson =
    r'{"Subscribed":false,"Notify":false,"CreatedOn":"0001-01-01T00:00:00Z","DocumentID":"A","DocumentCreatedOn":"0001-01-01T00:00:00Z","DocumentName":"B","DocumentPageCount":0,"DocumentFileSize":1,"DocumentClassificationID":"C","DocumentClassificationName":"D","DocumentPreviewMetadata":"[{"0":"A","1":"B","2":"C"}]","DocumentIsSigned":false,}';
const documentJson =
    r'{"ID":"A","DocumentID":"B","CreatedOn":"2021-01-06T17:37:32.327396Z","PurgeDate":"0001-01-31T00:00:00Z","Name":"C","PageCount":21,"FileSize":1234,"ThumbnailUrl":"D","IsSigned":false,"ClassificationID":"E","ClassificationName":"F","PreviewMetadata":[{"0":"A","1":"B","2":"C"}],"DocumentApprovalID":"G","DocumentApprovalCreatedOn":"0001-01-01T00:00:00Z","DocumentSubscriptionID":"H","DocumentSubscriptionCreatedOn":"0001-01-01T00:00:00Z","DocumentSignatureSessionRecipientID":"I","DocumentSignatureSessionID":"J","DocumentSignatureSessionRecipientEmail":"K","DocumentSignatureSessionRecipientFullName":"L","DocumentSignatureSessionRecipientRequestedOn":"0001-01-01T00:00:00Z","RoleName":"M","ProcessName":"N","ProcessElementName":"O","Score":123,"CreatedByUserID":"P","CreatedByUserEmail":"Q","CreatedByUserName":"R","NameLower":"S","Origin":"T","IsActive":false,"IsClassified":false,"IsMarkedForPurge":false,"SignatureSessionIsActive":false,"HasSinglePageImages":false,"SignaturesCompletedOn":"0001-01-01T00:00:00Z","PurgeMarkedOn":"0001-01-01T00:00:00Z","FailedBuildAttempts":false,"LastError":"U","BucketName":"V","SourceObjectName":"W","ThumbnailObjectName":"X","ClassificationNameLower":"Y"}';
const approvalJson =
    r'{"ID": "A","CreatedOn": "2021-06-04T16:49:04.317582Z","RoleID": "B","RoleName": "C","ProcessID": "D","ProcessName": "E","ProcessElementID": "F","ProcessElementName": "G","ParticipationType": "H","ApprovingTenantMemberIDs":  "[{"0":false,"1":false,"2":false}]","Result": "J","ItemType": "K","ItemID": "L","ItemCreatedOn": "2021-06-04T16:49:05.317582Z","ItemCreatedByUserID": "M","ItemCreatedByUserEmail": "N","ItemCreatedByUserName": "O","ItemCompletedOn": "0001-01-01T00:00:01Z","ItemCompletedByUserID": "P","ItemCompletedByUserEmail": "Q","ItemCompletedByUserName": "R","ItemName": "S","ItemDescription": "T","DocumentName": "U","DocumentCreatedOn": "2021-06-04T16:49:06.317582Z","DocumentCreatedByUserID": "V","DocumentCreatedByUserEmail": "W","DocumentCreatedByUserName": "X","DocumentPageCount": 0,"DocumentFileSize": 1,"DocumentClassificationID": "Y","DocumentClassificationName": "Z","DocumentPreviewMetadata": "[{"0":"A","1":"B","2":"C"}]","DocumentIsSigned": false,"WorkTaskDueOn": "0001-01-01T00:00:01Z","ThumbnailUrl": "AA"}';
const documentPackageFieldJson =
    r'{"ClassificationFieldID":"A", "ClassificationFieldRank":0,"FieldID":"B","ParentFieldID":"C","Name":"D","LabelOrName":"E","Type":0,"DisplaySelectionList":false,"AllowMultipleLines":false,"Rows":1,"AllowMultipleValues":false,"AllowNewSelectionListItems":false,"SaveNewSelectionListItems":false,"DecimalPlaces":2,"Mask":"F","Required":false,"Value":"G","Values":"H","UseCreationDate":false,"TextMatchType":"I",}';
const documentPackageJson = r'{"Document": ' +
    documentJson +
    ',"DocumentSubscription": ' +
    documentSubscriptionJson +
    ',"Approval": ' +
    approvalJson +
    ',"ClassificationField": ' +
    documentPackageFieldJson +
    ',"IndexFields": [' +
    documentPackageFieldJson +
    '],}';
void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so longer as 100% coverage is achieved.
  */
}
