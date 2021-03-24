import 'src/address_book.dart' as address_book;
import 'src/dashboard_widget.dart' as dashboard_widget;
import 'src/user.dart' as user;
import 'src/nucleus_one.dart' as n1;
import 'src/common/string.dart' as common_string;

void main() {
  mainTests();
  commonTests();
}

void mainTests() {
  n1.main();
  address_book.main();
  dashboard_widget.main();
  user.main();
}

void commonTests() {
  common_string.main();
}
