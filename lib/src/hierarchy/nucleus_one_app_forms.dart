import 'dart:convert';

import '../api_model/field_list_item.dart' as api_mod;
import '../api_model/form_template.dart' as api_mod;
import '../api_model/form_template_field.dart' as api_mod;
import '../api_model/query_result.dart' as api_mod;
import '../common/get_it.dart';
import '../common/model.dart';
import '../common/string.dart';
import '../common/util.dart';
import '../http.dart' as http;
import '../model/field_list_item.dart';
import '../model/form_submission_package.dart';
import '../model/form_template.dart';
import '../model/form_template_field.dart';
import '../model/query_result.dart';
import '../nucleus_one.dart';
import 'nucleus_one_app_project.dart';

/// Performs organization operations.
class NucleusOneAppForms with NucleusOneAppProjectDependent {
  /// Creates an instance of the [NucleusOneAppForms] class.
  ///
  /// [project]: The project to perform task operations on.
  NucleusOneAppForms({
    NucleusOneAppProject? project,
  }) {
    this.project = project ?? getIt.get<NucleusOneAppProject>();
  }

  /// Gets form templates, by page.
  ///
  /// [cursor]: The ID of the cursor, from a previous query.  Used for paging results.
  Future<QueryResult<FormTemplateCollection, api_mod.FormTemplateCollection>> getFormTemplates({
    String? cursor,
  }) async {
    final qp = http.StandardQueryParams.get(
      callbacks: [
        (sqp) => sqp.cursor(cursor),
      ],
    );

    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.organizationsProjectsFormTemplatesFormat
          .replaceOrgIdAndProjectIdPlaceholdersUsingProject(project),
      app: project.app,
      queryParams: qp,
    );
    final apiModel =
        api_mod.QueryResult<api_mod.FormTemplateCollection>.fromJson(jsonDecode(responseBody));

    return await defineN1AppAndProjectInScope(project, () {
      return QueryResult(
        results: FormTemplateCollection(
            items:
                apiModel.results!.formTemplates!.map((x) => FormTemplate.fromApiModel(x)).toList()),
        cursor: apiModel.cursor!,
        pageSize: apiModel.pageSize!,
      );
    });
  }

  /// Gets a form template, by ID.
  ///
  /// [formTemplateById]: The form template's ID.
  ///
  /// [uniqueId]: A unique ID that identifies that you are permitted to access this resource.
  Future<FormTemplate> getFormTemplateById({
    required String formTemplateById,
    required String uniqueId,
  }) async {
    final qp = http.StandardQueryParams.get();
    qp['uniqueId'] = uniqueId;

    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.formTemplatesPublicFormat
          .replaceFormTemplateIdPlaceholder(formTemplateById),
      app: project.app,
      queryParams: qp,
    );
    final apiModel = api_mod.FormTemplate.fromJson(jsonDecode(responseBody));
    return await defineN1AppInScope(project.app, () {
      return FormTemplate.fromApiModel(apiModel);
    });
  }

  /// Gets a form template's fields by ID.
  ///
  /// [formTemplateId]: The form template's ID.
  Future<FormTemplateFieldCollection> getFormTemplateFields(String formTemplateId) async {
    final qp = http.StandardQueryParams.get();
    qp['tenantId'] = project.id;

    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.formTemplatesPublicFieldsFormat
          .replaceFormTemplateIdPlaceholder(formTemplateId),
      app: project.app,
      queryParams: qp,
    );
    final apiModel =
        api_mod.FormTemplateFieldCollection.fromJson(jsonDecodeListOfMap(responseBody));
    return await defineN1AppInScope(project.app, () {
      return FormTemplateFieldCollection.fromApiModel(apiModel);
    });
  }

  /// Gets a form template field's list items.
  ///
  /// [formTemplateId]: The form template's ID.
  ///
  /// [formTemplateFieldId]: The form template's ID field.
  ///
  /// [parentValue]: The value of the parent field.
  ///
  /// [valueFilter]: Limits results to fields whose value contains this text.
  Future<FieldListItemCollection> getFormTemplateFieldListItems({
    required String formTemplateId,
    required String formTemplateFieldId,
    String? parentValue,
    String? valueFilter,
    // At the time of writing this, cursor was not implemented in the API
    // String? cursor,
  }) async {
    final qp = ListItems.getListItemsQueryParams(
      cursor: null,
      parentValue: parentValue,
      valueFilter: valueFilter,
    );
    qp['tenantId'] = project.id;

    final responseBody = await http.executeGetRequestWithTextResponse(
      apiRelativeUrlPath: http.ApiPaths.formTemplatesPublicFieldListItemsFormat
          .replaceFormTemplateIdPlaceholder(formTemplateId)
          .replaceFormTemplateFieldIdPlaceholder(formTemplateFieldId),
      app: project.app,
      queryParams: qp,
    );
    final apiModel = api_mod.FieldListItemCollection.fromJson(jsonDecodeListOfMap(responseBody));
    return await defineN1AppInScope(project.app, () {
      return FieldListItemCollection.fromApiModel(apiModel);
    });
  }

  /// Adds list items to a form template field's selection list.
  ///
  /// [formTemplateId]: The form template's ID.
  ///
  /// [formTemplateFieldId]: The form template's ID field.
  ///
  /// [items]: The list items to add.
  Future<void> addFormTemplateFieldListItems({
    required String formTemplateId,
    required String formTemplateFieldId,
    required FieldListItemCollection items,
  }) async {
    if (formTemplateId.isEmpty) {
      throw ArgumentError.value(formTemplateId, 'formTemplateId', 'Cannot be blank.');
    }
    if (formTemplateFieldId.isEmpty) {
      throw ArgumentError.value(formTemplateFieldId, 'formTemplateFieldId', 'Cannot be blank.');
    }

    final qp = http.StandardQueryParams.get();
    qp['tenantId'] = project.id;

    await ListItems.addListItems(
      app: project.app,
      apiRelativeUrlPath: http.ApiPaths.formTemplatesPublicFieldListItemsFormat
          .replaceFormTemplateIdPlaceholder(formTemplateId)
          .replaceFormTemplateFieldIdPlaceholder(formTemplateFieldId),
      items: items,
      additionalQueryParams: qp,
    );
  }

  /// Sets or replaces a form template field's selection list items.
  ///
  /// [formTemplateId]: The form template's ID.
  ///
  /// [formTemplateFieldId]: The form template's ID field.
  ///
  /// [values]: The list items to update.
  Future<void> setFormTemplateFieldListItems({
    required String formTemplateId,
    required String formTemplateFieldId,
    required List<String> values,
  }) async {
    if (formTemplateId.isEmpty) {
      throw ArgumentError.value(formTemplateId, 'formTemplateId', 'Cannot be blank.');
    }
    if (formTemplateFieldId.isEmpty) {
      throw ArgumentError.value(formTemplateFieldId, 'formTemplateFieldId', 'Cannot be blank.');
    }

    final qp = http.StandardQueryParams.get();
    qp['tenantId'] = project.id;

    await ListItems.setListItems(
      app: project.app,
      apiRelativeUrlPath: http.ApiPaths.formTemplatesPublicFieldListItemsFormat
          .replaceFormTemplateIdPlaceholder(formTemplateId)
          .replaceFormTemplateFieldIdPlaceholder(formTemplateFieldId),
      values: values,
      additionalQueryParams: qp,
    );
  }

  /// Submits a form package.
  ///
  /// [formTemplateId]: The form template's ID.
  ///
  /// [package]: The package to submit.
  Future<void> submitFormPackage({
    required String formTemplateId,
    required FormSubmissionPackage package,
  }) async {
    if (formTemplateId.isEmpty) {
      throw ArgumentError.value(formTemplateId, 'formTemplateId', 'Cannot be blank.');
    }

    final packages = FormSubmissionPackageCollection(items: [package]);

    await http.executePostRequest(
      apiRelativeUrlPath: http.ApiPaths.formTemplatesPublicSubmissions
          .replaceFormTemplateIdPlaceholder(formTemplateId),
      app: project.app,
      body: jsonEncode(packages.toApiModel()),
    );
  }
}
