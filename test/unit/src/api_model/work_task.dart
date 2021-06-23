const documentJson =
    r'{"ID": "A","CreatedOn": "0001-01-01T00:00:00Z","CreatedByUserID": "B","CreatedByUserEmail": "C","CreatedByUserName": "D","Name": "E","NameLower": "F","Origin": "G","IsActive": false,"IsClassified": false,"IsMarkedForPurge": false,"IsSigned": false,"SignatureSessionIsActive": false,"HasSinglePageImages": false,"SignaturesCompletedOn": "0001-01-01T00:00:00Z","PurgeMarkedOn": "0001-01-01T00:00:00Z","FailedBuildAttempts": false,"LastError": "H","PageCount": 0,"FileSize": 1,"BucketName": "I","SourceObjectName": "J","ThumbnailObjectName": "K","ClassificationID": "L","ClassificationName": "M","ClassificationNameLower": "N","PreviewMetadata":[{"0":"A","1":"B","2":"C"}]}';
const workTaskJson =
    r'{"ID":"A","CreatedOn":"0001-01-01T00:00:00Z","ModifiedOn":"0001-01-01T00:00:00Z","CreatedByUserID":"B","CreatedByUserEmail":"C","CreatedByUserName":"D","CompletedOn":"0001-01-01T00:00:00Z","CompletedByUserID":"E","CompletedByUserEmail":"F","CompletedByUserName":"G","ModifiedByUserID":"H","ModifiedByUserEmail":"I","ModifiedByUserName":"J","Revision":0,"Result":"K","Name":"L","NameLower": "M", "Description": "N","DescriptionHtml": "O","DescriptionRichTextJson": "P","RoleID": "Q","RoleName": "R","RoleNameLower": "S","DueOn": "0001-01-01T00:00:00Z","DueOnModifiedOn": "0001-01-01T00:00:00Z","PrimaryDocument":' +
        documentJson +
        ',"OtherDocuments": [' +
        documentJson +
        '],"ParentWorkTaskID": "T","ProcessID": "U","ProcessName": "V","ProcessNameLower": "W","ProcessElementID": "X","ProcessElementName": "Y","ProcessElementNameLower": "Z","Reminder_7_Day": "0001-01-01T00:00:00Z","Reminder_3_Day": "0001-01-01T00:00:00Z","Reminder_1_Day": "0001-01-01T00:00:00Z"}';
const workTaskCollectionJson =
    '{"WorkTasks":[' + workTaskJson + '],"Cursor":"QueryResultA","PageSize":24}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so longer as 100% coverage is achieved.
  */
}
