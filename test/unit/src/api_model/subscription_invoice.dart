const subscriptionInvoiceJson =
    '{"ID":"A","CreatedOn":"2021-07-17T01:01:56Z","AmountDue":0.12,"IsUpcoming":true,"Status":"B","PDFUrl":"C"}';
const subscriptionInvoiceCollectionJson = '[$subscriptionInvoiceJson]';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so longer as 100% coverage is achieved.
  */
}
