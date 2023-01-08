import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletin/routes/binding/bin_main.dart';
import 'package:walletin/view/main.dart';

class PageTo {
  static const splash = "/";
  static const main = "/main";
  static const add = "/add";
  static const edit = "/edit";

  static List<GetPage> routes = [
    _page(
      name: main,
      page: const PageMain(),
      binding: BinMain(),
    ),
  ];

  static GetPage _page({
    required String name,
    required Widget page,
    Bindings? binding,
  }) {
    return GetPage(
      name: name,
      page: () => page,
      binding: binding,
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(
        milliseconds: 400,
      ),
    );
  }
}
