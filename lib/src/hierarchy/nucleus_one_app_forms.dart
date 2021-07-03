import 'dart:convert';

import '../../nucleus_one_dart_sdk.dart';
import '../http.dart' as http;
import '../nucleus_one.dart';

class NucleusOneAppForms with NucleusOneAppDependent {
  NucleusOneAppForms({
    required NucleusOneAppInternal app,
  }) {
    this.app = app;
  }

  /// Submits a form.
  ///
  /// [formTemplateId]: The id of the form template.
  ///
  /// [package]: The form package to submit.
  Future<void> submitForm({
    required String formTemplateId,
    required FormSubmissionPackage package,
  }) async {
    if (formTemplateId.isEmpty) {
      throw ArgumentError.value(formTemplateId, 'formTemplateId', 'Cannot be blank.');
    }

    final packages = FormSubmissionPackageCollection(items: [package]);

    await http.executePostRequest(
      http.apiPaths.formTemplatesPublicSubmissions.replaceFirst('<formTemplateId>', formTemplateId),
      app,
      body: jsonEncode(packages.toApiModel()),
    );
  }
}
