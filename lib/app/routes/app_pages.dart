import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:taskmanager_app/app/bindings/addtask_binding.dart';
import 'package:taskmanager_app/app/ui/pages/addtask_page/addtask_page.dart';

import '../bindings/home_binding.dart';
import '../ui/pages/home_page/home_page.dart';
import '../ui/pages/unknown_route_page/unknown_route_page.dart';
import 'app_routes.dart';

final _defaultTransition = Transition.native;

class AppPages {
  static final unknownRoutePage = GetPage(
    name: AppRoutes.UNKNOWN,
    page: () => UnknownRoutePage(),
    transition: _defaultTransition,
  );

  static final List<GetPage> pages = [
    unknownRoutePage,
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.ADD_TASK,
      page: () => AddTaskPage(),
      binding: AddTaskBinding(),
      transition: _defaultTransition,
    ),
  ];
}
