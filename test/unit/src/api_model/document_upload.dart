const documentUploadJsonFileSizeFormat =
    r'{"SignedUrl":"A","ObjectName":"B","UniqueId":"C","OriginalFilename":"D","OriginalFileSize":{0},"ClassificationID":"E","FieldIDsAndValues":{"A":["A","B"]}}';
final documentUploadJson = documentUploadJsonFileSizeFormat.replaceFirst('{0}', '0');

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so longer as 100% coverage is achieved.
  */
}
