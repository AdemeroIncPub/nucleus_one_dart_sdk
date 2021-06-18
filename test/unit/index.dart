import 'src/api_model/address_book.dart' as api_mod__address_book;
import 'src/api_model/classification.dart' as api_mod__classification;
import 'src/api_model/dashboard_widget.dart' as api_mod__dashboard_widget;
import 'src/api_model/document_for_client.dart' as api_mod__document_for_client;
import 'src/api_model/document.dart' as api_mod__document;
import 'src/api_model/document_comments.dart' as api_mod__document_comments;
import 'src/api_model/document_content_package.dart' as api_mod__document_content_package;
import 'src/api_model/document_event.dart' as api_mod__document_event;
import 'src/api_model/email_login_options.dart' as api_mod__email_login_options;
import 'src/api_model/field.dart' as api_mod__field;
import 'src/api_model/field_list_item.dart' as api_mod__field_list_item;
import 'src/api_model/folder_hierarchies.dart' as api_mod__folder_hierarchies;
import 'src/api_model/form_template.dart' as api_mod__form_template;
import 'src/api_model/document_results.dart' as api_mod__document_results;
import 'src/api_model/query_result.dart' as api_mod__query_result;
import 'src/api_model/project.dart' as api_mod__project;
import 'src/api_model/project_packages.dart' as api_mod__project_packages;
import 'src/api_model/project_permissions.dart' as api_mod__project_permissions;
import 'src/api_model/user.dart' as api_mod__user;
import 'src/api_model/user_profile.dart' as api_mod__user_profile;
import 'src/api_model/user_preferences.dart' as api_mod__user_preferences;
import 'src/api_model/selected_twain_device.dart' as api_mod__selected_twain_device;
import 'src/api_model/user_preference.dart' as api_mod__user_preference;
import 'src/api_model/document_field.dart' as api_mod__document_field;
import 'src/api_model/approval.dart' as api_mod__approval;
import 'src/api_model/work_task.dart' as api_mod__work_task;
import 'src/api_model/document_subscription.dart' as api_mod__document_subscription;
import 'src/api_model/document_package_field.dart' as api_mod__document_package_field;
import 'src/api_model/document_upload.dart' as api_mod__document_upload;
import 'src/api_model/document_package.dart' as api_mod__document_package;
import 'src/hierarchy/nucleus_one_app_approvals.dart' as hierarchy__nucleus_one_app_approvals;
import 'src/hierarchy/nucleus_one_app_documents.dart' as hierarchy__nucleus_one_app_documents;
import 'src/hierarchy/nucleus_one_app_fields.dart' as hierarchy__nucleus_one_app_fields;
import 'src/hierarchy/nucleus_one_app_work_tasks.dart' as hierarchy__nucleus_one_app_work_tasks;
import 'src/hierarchy/nucleus_one_app_folder_hierarchies.dart'
    as hierarchy__nucleus_one_app_folder_hierarchies;
import 'src/hierarchy/nucleus_one_app_project.dart' as hierarchy__nucleus_one_app_project;
import 'src/hierarchy/nucleus_one_app_users.dart' as hierarchy__nucleus_one_app_users;
import 'src/model/_common.dart' as mod___common;
import 'src/model/address_book.dart' as mod__address_book;
import 'src/model/classification.dart' as mod__classification;
import 'src/model/dashboard_widget.dart' as mod__dashboard_widget;
import 'src/model/document_for_client.dart' as mod__document_for_client;
import 'src/model/document.dart' as mod__document;
import 'src/model/document_comment.dart' as mod__document_comments;
import 'src/model/document_content_package.dart' as mod__document_content_package;
import 'src/model/document_event.dart' as mod__document_event;
import 'src/model/email_login_options.dart' as mod__email_login_options;
import 'src/model/field.dart' as mod__field;
import 'src/model/field_list_item.dart' as mod__field_list_item;
import 'src/model/folder_hierarchies.dart' as mod__folder_hierarchies;
import 'src/model/form_template.dart' as mod__form_template;
import 'src/model/query_result.dart' as mod__query_result;
import 'src/model/project.dart' as mod__project;
import 'src/model/project_packages.dart' as mod__project_packages;
import 'src/model/project_permissions.dart' as mod__project_permissions;
import 'src/model/user.dart' as mod__user;
import 'src/model/user_profile.dart' as mod__user_profile;
import 'src/model/user_preferences.dart' as mod__user_preferences;
import 'src/model/selected_twain_device.dart' as mod__selected_twain_device;
import 'src/model/user_preference.dart' as mod__user_preference;
import 'src/model/document_field.dart' as mod__document_field;
import 'src/model/approval.dart' as mod__approval;
import 'src/model/work_task.dart' as mod__work_task;
import 'src/model/document_subscription.dart' as mod__document_subscription;
import 'src/model/document_package_field.dart' as mod__document_package_field;
import 'src/model/document_package.dart' as mod__document_package;
import 'src/model/document_upload.dart' as mod__document_upload;
import 'src/nucleus_one.dart' as n1;
import 'src/common/string.dart' as common_string;
import 'src/http.dart' as http;

void main() {
  n1.main();
  _apiModelTests();
  _commonTests();
  _modelTests();
  _hierarchyTests();
  http.main();
}

void _apiModelTests() {
  api_mod__address_book.main();
  api_mod__classification.main();
  api_mod__dashboard_widget.main();
  api_mod__document_for_client.main();
  api_mod__document.main();
  api_mod__document_comments.main();
  api_mod__document_content_package.main();
  api_mod__document_event.main();
  api_mod__document_results.main();
  api_mod__email_login_options.main();
  api_mod__field.main();
  api_mod__field_list_item.main();
  api_mod__folder_hierarchies.main();
  api_mod__form_template.main();
  api_mod__query_result.main();
  api_mod__project.main();
  api_mod__project_packages.main();
  api_mod__project_permissions.main();
  api_mod__user.main();
  api_mod__user_profile.main();
  api_mod__user_preferences.main();
  api_mod__selected_twain_device.main();
  api_mod__user_preference.main();
  api_mod__document_field.main();
  api_mod__approval.main();
  api_mod__document_subscription.main();
  api_mod__document_package_field.main();
  api_mod__document_package.main();
  api_mod__document_upload.main();
  api_mod__work_task.main();
}

void _modelTests() {
  mod___common.main();
  mod__address_book.main();
  mod__classification.main();
  mod__dashboard_widget.main();
  mod__document.main();
  mod__document_for_client.main();
  mod__document_comments.main();
  mod__document_content_package.main();
  mod__document_event.main();
  mod__email_login_options.main();
  mod__field.main();
  mod__field_list_item.main();
  mod__folder_hierarchies.main();
  mod__form_template.main();
  mod__query_result.main();
  mod__project.main();
  mod__project_packages.main();
  mod__project_permissions.main();
  mod__user.main();
  mod__user_profile.main();
  mod__user_preferences.main();
  mod__selected_twain_device.main();
  mod__user_preference.main();
  mod__document_field.main();
  mod__approval.main();
  mod__document_subscription.main();
  mod__document_package_field.main();
  mod__document_package.main();
  mod__document_upload.main();
  mod__work_task.main();
}

void _hierarchyTests() {
  hierarchy__nucleus_one_app_approvals.main();
  hierarchy__nucleus_one_app_documents.main();
  hierarchy__nucleus_one_app_fields.main();
  hierarchy__nucleus_one_app_folder_hierarchies.main();
  hierarchy__nucleus_one_app_project.main();
  hierarchy__nucleus_one_app_users.main();
  hierarchy__nucleus_one_app_work_tasks.main();
}

void _commonTests() {
  common_string.main();
}
