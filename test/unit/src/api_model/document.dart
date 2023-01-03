const previewMetadataJson1 = r'{"0":"A","1":"B","2":"C"}';
const previewMetadataJson2 = r'{"0":"D","1":"E","2":"F"}';
const documentJson =
    r'{"ID":"A","OrganizationID":"B","ProjectID":"C","ProjectName":"D","ProjectAccessType":"E","DocumentID":"F","DocumentFolderID":"","DocumentFolderPath":"","AssignmentUserEmails":["F0"],"GroupID":"","CreatedOn":"0001-01-01T00:00:00Z","CreatedByUserEmail":"G@H.com","CreatedByUserName":"I","ModifiedOn":"0001-01-01T00:00:00Z","ModifiedByUserEmail":"","ModifiedByUserName":"","PurgeDate":"0001-01-01T00:00:00Z","Name":"J","Origin":"UserUpload","PageCount":3,"FileSize":648732,"ThumbnailUrl":"https://K","IsSigned":false,"PreviewMetadata":[' +
        previewMetadataJson1 +
        r',' +
        previewMetadataJson2 +
        r'],"ApprovalID":"","ApprovalCreatedOn":"0001-01-01T00:00:00Z","IsMarkedForPurge":false,"HasSinglePageImages":true,"SignatureSessionIsActive":false,"SignaturesCompletedOn":"0001-01-01T00:00:00Z","DocumentSubscriptionID":"","DocumentSubscriptionCreatedOn":"0001-01-01T00:00:00Z","ProcessName":"","ProcessElementName":"","Revision":0,"PaperSize":"","PaperOrientation":"","PaperMarginLeft":0,"PaperMarginRight":0,"PaperMarginTop":0,"PaperMarginBottom":0}';
const documentCollectionJson =
    '{"Documents":[' + documentJson + '],"Cursor":"QueryResultA","PageSize":24}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so long as 100% coverage is achieved.
  */
}
