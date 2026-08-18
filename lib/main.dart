import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/route/go_router_config.dart';
import 'package:lukethompson/core/resource/theme_manager.dart';
import 'package:lukethompson/core/services/revenuecat_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  try {
    await RevenueCatService().configure();
  } catch (error) {
    debugPrint('RevenueCat configure failed: $error');
  }
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(),
        themeMode: ThemeMode.dark,
        darkTheme: getApplicationTheme(),
        routerConfig: router,
      ),
    );
  }
}
