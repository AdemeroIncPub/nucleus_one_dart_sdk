const documentJson =
    r'{"ID": "A","CreatedOn": "0001-01-01T00:00:00Z","CreatedByUserID": "B","CreatedByUserEmail": "C","CreatedByUserName": "D","Name": "E","NameLower": "F","Origin": "G","IsActive": false,"IsClassified": false,"IsMarkedForPurge": false,"IsSigned": false,"SignatureSessionIsActive": false,"HasSinglePageImages": false,"SignaturesCompletedOn": "0001-01-01T00:00:00Z","PurgeMarkedOn": "0001-01-01T00:00:00Z","FailedBuildAttempts": false,"LastError": "H","PageCount": 0,"FileSize": 1,"BucketName": "I","SourceObjectName": "J","ThumbnailObjectName": "K","ClassificationID": "L","ClassificationName": "M","ClassificationNameLower": "N","PreviewMetadata":[{"0":"A","1":"B","2":"C"}]}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so longer as 100% coverage is achieved.
  */
}
