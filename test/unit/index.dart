import 'src/api_model/address_book.dart' as api_mod__address_book;
import 'src/api_model/dashboard_widget.dart' as api_mod__dashboard_widget;
import 'src/api_model/document.dart' as api_mod__document;
import 'src/api_model/recent_documents.dart' as api_mod__recent_documents;
import 'src/api_model/user.dart' as api_mod__user;
import 'src/model/address_book.dart' as mod__address_book;
import 'src/model/dashboard_widget.dart' as mod__dashboard_widget;
import 'src/model/document.dart' as mod__document;
import 'src/model/recent_documents.dart' as mod__recent_documents;
import 'src/model/user.dart' as mod__user;
import 'src/nucleus_one.dart' as n1;
import 'src/common/string.dart' as common_string;

void main() {
  mainTests();
  commonTests();
}

void mainTests() {
  n1.main();
  _apiModelTests();
  _modelTests();
}

void _apiModelTests() {
  api_mod__address_book.main();
  api_mod__dashboard_widget.main();
  api_mod__document.main();
  api_mod__recent_documents.main();
  api_mod__user.main();
}

void _modelTests() {
  mod__address_book.main();
  mod__dashboard_widget.main();
  mod__document.main();
  mod__recent_documents.main();
  mod__user.main();
}

void commonTests() {
  common_string.main();
}
