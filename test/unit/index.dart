import 'src/api_model/tenant_permissions.dart' as api_mod__tenant_permissions;
import 'src/api_model/address_book.dart' as api_mod__address_book;
import 'src/api_model/classification.dart' as api_mod__classification;
import 'src/api_model/dashboard_widget.dart' as api_mod__dashboard_widget;
import 'src/api_model/document.dart' as api_mod__document;
import 'src/api_model/document_comments.dart' as api_mod__document_comments;
import 'src/api_model/document_content_package.dart' as api_mod__document_content_package;
import 'src/api_model/document_event.dart' as api_mod__document_event;
import 'src/api_model/document_results.dart' as api_mod__document_results;
import 'src/api_model/query_result.dart' as api_mod__query_result;
import 'src/api_model/user.dart' as api_mod__user;
import 'src/model/tenant_permissions.dart' as mod__tenant_permissions;
import 'src/model/address_book.dart' as mod__address_book;
import 'src/model/classification.dart' as mod__classification;
import 'src/model/dashboard_widget.dart' as mod__dashboard_widget;
import 'src/model/document.dart' as mod__document;
import 'src/model/document_comment.dart' as mod__document_comments;
import 'src/model/document_content_package.dart' as mod__document_content_package;
import 'src/model/document_event.dart' as mod__document_event;
import 'src/model/query_result.dart' as mod__query_result;
import 'src/model/user.dart' as mod__user;
import 'src/nucleus_one.dart' as n1;
import 'src/common/string.dart' as common_string;
import 'src/http.dart' as http;

void main() {
  n1.main();
  _apiModelTests();
  _commonTests();
  _modelTests();
  http.main();
}

void _apiModelTests() {
  api_mod__address_book.main();
  api_mod__classification.main();
  api_mod__dashboard_widget.main();
  api_mod__document.main();
  api_mod__document_comments.main();
  api_mod__document_content_package.main();
  api_mod__document_event.main();
  api_mod__document_results.main();
  api_mod__query_result.main();
  api_mod__tenant_permissions.main();
  api_mod__user.main();
}

void _modelTests() {
  mod__address_book.main();
  mod__classification.main();
  mod__dashboard_widget.main();
  mod__document.main();
  mod__document_comments.main();
  mod__document_content_package.main();
  mod__document_event.main();
  mod__query_result.main();
  mod__tenant_permissions.main();
  mod__user.main();
}

void _commonTests() {
  common_string.main();
}
