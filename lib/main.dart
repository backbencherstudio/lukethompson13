import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/theme_manager.dart';
import 'package:lukethompson/core/route/route_manager.dart';
import 'package:lukethompson/core/route/routes_names.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(),
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: RoutesName.splashRoute,
      ),
    );
  }
}
