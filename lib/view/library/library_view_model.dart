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
    CategoryPickerItem(value: "Biyografi", label: "Biyografi"),
    CategoryPickerItem(value: "Tarih", label: "Tarih"),
  ];
}
