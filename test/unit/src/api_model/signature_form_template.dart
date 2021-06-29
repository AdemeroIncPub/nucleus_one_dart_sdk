const signatureFormTemplateJson =
    '{"ID":"A","Name":"B","NameLower":"C","CreatedOn":"2021-06-28T18:27:18.205858Z"}';
const signatureFormTemplateCollectionJson = '[$signatureFormTemplateJson]';

const signatureFormTemplateFieldJson = '{"ID":"A","CreatedOn":"2021-06-28T18:26:57.85540675Z","Type":"B","PageIndex":0,"DocumentSignatureSessionRecipientID":"C","X":1.23,"Y":4.56,"Label":"C","WidthPercent":5.67,"SortRank":6}';
const signatureFormTemplateFieldCollectionJson = '[$signatureFormTemplateFieldJson]';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so longer as 100% coverage is achieved.
  */
}
