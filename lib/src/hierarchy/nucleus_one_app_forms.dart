import 'dart:convert';

import '../api_model/field_list_item.dart' as api_mod;
import '../api_model/form_template.dart' as api_mod;
import '../api_model/query_result.dart' as api_mod;
import '../common/model.dart';
import '../common/string.dart';
import '../http.dart' as http;
import '../model/field_list_item.dart';
import '../model/form_template.dart';
import '../model/query_result.dart';
import '../nucleus_one.dart';
import 'nucleus_one_app_project.dart';

class NucleusOneAppForms with NucleusOneAppDependent {
  final NucleusOneAppProject project;

  NucleusOneAppForms({
    required this.project,
  }) {
    app = project.app;
  }

  /// Gets form templates, by page.
  ///
  /// [cursor]: The id of the cursor, from a previous query.  Used for paging results.
  ///
  /// [sortDescending]: Sort order.
  Future<QueryResult<FormTemplateCollection>> getFormTemplates({
    String? cursor,
    bool sortDescending = false,
  }) async {
    final qp = http.StandardQueryParams.get([
      (sqp) => sqp.cursor(cursor),
      (sqp) => sqp.sortDescending(sortDescending),
    ]);

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.organizationsProjectsFormTemplatesFormat
          .replaceOrganizationAndProjectPlaceholders(project),
      app,
      query: qp,
    );
    final apiModel =
        api_mod.QueryResult<api_mod.FormTemplateCollection>.fromJson(jsonDecode(responseBody));

    return QueryResult(
      results: FormTemplateCollection(
          items:
              apiModel.results!.formTemplates!.map((x) => FormTemplate.fromApiModel(x)).toList()),
      cursor: apiModel.cursor!,
      pageSize: apiModel.pageSize!,
    );
  }

  /// Gets a form template by id.
  ///
  /// [id]: The id of the form template.
  ///
  /// [uniqueId]: A unique id that identifies that you are permitted to access this resource.
  Future<FormTemplate> getFormTemplateById(String id, String uniqueId) async {
    final qp = http.StandardQueryParams.get();
    qp['uniqueId'] = uniqueId;

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.formTemplatesPublicFormat.replaceFirst('<formTemplateId>', id),
      app,
      query: qp,
    );
    final apiModel = api_mod.FormTemplate.fromJson(jsonDecode(responseBody));
    return FormTemplate.fromApiModel(apiModel);
  }

  /// Gets a form template by id.
  ///
  /// [formTemplateId]: The id of the form template.
  ///
  /// [projectId]: The id of the project to which this form template belongs.
  Future<FormTemplateFieldCollection> getFormTemplateFields(
      String formTemplateId, String projectId) async {
    final qp = http.StandardQueryParams.get();
    qp['tenantId'] = projectId;

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.formTemplatesPublicFieldsFormat
          .replaceFirst('<formTemplateId>', formTemplateId),
      app,
      query: qp,
    );
    final apiModel = api_mod.FormTemplateFieldCollection.fromJson(jsonDecode(responseBody));
    return FormTemplateFieldCollection.fromApiModel(apiModel);
  }

  /// Gets a form template field's list items.
  ///
  /// [formTemplateId]: The id of the form template.
  ///
  /// [formTemplateFieldId]: The id of the form template field.
  ///
  /// [projectId]: The id of the project to which this form template belongs.
  ///
  /// [parentValue]: The value of parent field.
  ///
  /// [valueFilter]: Limits results to fields whose value contains this text.
  Future<FieldListItemCollection> getFormTemplateFieldListItems(
    String formTemplateId,
    String formTemplateFieldId,
    String projectId, {
    String? parentValue,
    String? valueFilter,
    // At the time of writing this, cursor was not implemented in the API
    // String? cursor,
  }) async {
    final qp = ListItems.getListItemsQueryParams(null, parentValue, valueFilter);
    qp['tenantId'] = projectId;

    final responseBody = await http.executeGetRequestWithTextResponse(
      http.apiPaths.formTemplatesPublicFieldListItemsFormat
          .replaceFirst('<formTemplateId>', formTemplateId)
          .replaceFirst('<formTemplateFieldId>', formTemplateFieldId),
      app,
      query: qp,
    );
    final apiModel = api_mod.FieldListItemCollection.fromJson(jsonDecode(responseBody));
    return FieldListItemCollection.fromApiModel(apiModel);
  }

  /// Adds list items to a form template field's selection list.
  ///
  /// [formTemplateId]: The id of the form template.
  ///
  /// [formTemplateFieldId]: The id of the form template field.
  ///
  /// [projectId]: The id of the project to which this form template belongs.
  ///
  /// [items]: The list items to add or update.
  Future<void> addFormTemplateFieldListItems({
    required String formTemplateId,
    required String formTemplateFieldId,
    required String projectId,
    required FieldListItemCollection items,
  }) async {
    if (formTemplateId.isEmpty) {
      throw ArgumentError.value(formTemplateId, 'formTemplateId', 'Cannot be blank.');
    }
    if (formTemplateFieldId.isEmpty) {
      throw ArgumentError.value(formTemplateFieldId, 'formTemplateFieldId', 'Cannot be blank.');
    }
    if (projectId.isEmpty) {
      throw ArgumentError.value(projectId, 'projectId', 'Cannot be blank.');
    }

    final qp = http.StandardQueryParams.get();
    qp['tenantId'] = projectId;

    await ListItems.addListItems(
      app: app,
      apiRelativeUrlPath: http.apiPaths.formTemplatesPublicFieldListItemsFormat
          .replaceFirst('<formTemplateId>', formTemplateId)
          .replaceFirst('<formTemplateFieldId>', formTemplateFieldId),
      items: items,
      additionalQueryParams: qp,
    );
  }

  /// Sets or replaces a form template field's selection list items.
  ///
  /// [formTemplateId]: The id of the form template.
  ///
  /// [formTemplateFieldId]: The id of the form template field.
  ///
  /// [projectId]: The id of the project to which this form template belongs.
  ///
  /// [listItems]: The list items to add or update.
  Future<void> setFormTemplateFieldListItems({
    required String formTemplateId,
    required String formTemplateFieldId,
    required String projectId,
    required List<String> values,
  }) async {
    if (formTemplateId.isEmpty) {
      throw ArgumentError.value(formTemplateId, 'formTemplateId', 'Cannot be blank.');
    }
    if (formTemplateFieldId.isEmpty) {
      throw ArgumentError.value(formTemplateFieldId, 'formTemplateFieldId', 'Cannot be blank.');
    }
    if (projectId.isEmpty) {
      throw ArgumentError.value(projectId, 'projectId', 'Cannot be blank.');
    }

    final qp = http.StandardQueryParams.get();
    qp['tenantId'] = projectId;

    await ListItems.setListItems(
      app: app,
      apiRelativeUrlPath: http.apiPaths.formTemplatesPublicFieldListItemsFormat
          .replaceFirst('<formTemplateId>', formTemplateId)
          .replaceFirst('<formTemplateFieldId>', formTemplateFieldId),
      values: values,
      additionalQueryParams: qp,
    );
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
