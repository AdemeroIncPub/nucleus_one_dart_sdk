import 'dart:async';

import 'http.dart' as http;
import 'nucleus_one.dart';

class Document with NucleusOneAppDependent {
  Document({
    required NucleusOneAppInternal app,
  }) {
    this.app = app;
  }

  /// Gets the document count.
  Future<int> getCount(bool ignoreInbox, bool ignoreRecycleBin) async {
    final qp = {
      'ignoreInbox': ignoreInbox,
      'ignoreRecycleBin': ignoreRecycleBin,
    };
    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.documentCounts,
      app,
      query: qp,
    );
    return int.parse(responseBody);
  }
}
