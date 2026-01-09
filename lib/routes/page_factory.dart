// page_factory.dart
import 'package:bhavapp/routes/page_identifier.dart';
import 'package:get/get.dart';

// @Author: Tarun Pal & Jai
// @Date: 2023-10-01

class PageFactory {
  static final getPages =
      PageIdentifier.values.map((id) {
        return GetPage(
          name: id.name,
          transition: Transition.rightToLeft,
          page: () => PageIdentifier.getPage(id),
          binding: PageIdentifier.getBinding(id),
        );
      }).toList();
}
