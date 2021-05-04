import 'document_event.dart';

const documentEventsJson = r'{"DocumentEvents":[' +
    documentEventJson +
    r'],"Cursor": "A","ReverseCursor":"B","PageSize":24}';

void main() {
  /*
  Because these "API model" classes are purely boilerplate for generated json_serializable logic,
  it is sufficient to cover the tests for these under the equivalent "model" classes, under
  ".\model\*", so longer as 100% coverage is achieved.
  */
}
