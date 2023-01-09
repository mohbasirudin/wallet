import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:walletin/base/const.dart';
import 'package:walletin/routes/binding/bin_main.dart';
import 'package:walletin/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: PageTo.routes,
      initialBinding: BinMain(),
      initialRoute: PageTo.main,
      theme: ThemeData(
        canvasColor: Colors.white,
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              ConstDouble.radius,
            ),
          ),
          elevation: 8,
        ),
      ),
    );
  }
}
