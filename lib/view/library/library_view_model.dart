// ignore: import_of_legacy_library_into_null_safe
import 'package:category_picker/category_picker_item.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LibraryView extends GetxController {
  List<CategoryPickerItem> booksCategoryList = [
    CategoryPickerItem(
      value: "Rastgele",
      label: "Rastgele",
    ),
    CategoryPickerItem(value: "Olay", label: "Olay"),
    CategoryPickerItem(value: "Otobiyografi", label: "Otobiyografi"),
    CategoryPickerItem(value: "Tarihi", label: "Tarihi"),
  ];
  final List<String> booksGridList = [
    "assets/books/au.jpg",
    "assets/books/tcr.png",
    "assets/books/as.png",
    "assets/books/au.jpg",
    "assets/books/tcr.png",
    "assets/books/au.jpg",
    "assets/books/au.jpg",
    "assets/books/tcr.png",
    "assets/books/as.png",
    "assets/books/au.jpg",
    "assets/books/tcr.png",
    "assets/books/au.jpg"
  ];
}
