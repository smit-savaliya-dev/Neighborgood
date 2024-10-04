import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:neighborgood_assignment/controller/providers/dashboard_provider.dart';
import 'package:neighborgood_assignment/controller/providers/loading_provider.dart';
import 'package:neighborgood_assignment/controller/providers/login_provider.dart';
import 'package:neighborgood_assignment/controller/providers/post_provider.dart';
import 'package:neighborgood_assignment/controller/providers/register_provider.dart';
import 'package:neighborgood_assignment/firebase_options.dart';
import 'package:neighborgood_assignment/routes/app_pages.dart';
import 'package:neighborgood_assignment/utils/app_constant/app_constants.dart';
import 'package:neighborgood_assignment/utils/color/const_color.dart';
import 'package:neighborgood_assignment/utils/helper/shared_prefs_helper.dart';
import 'package:neighborgood_assignment/views/presentation/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'firebase_options.dart'; // Import your Firebase options

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsHelper.init();

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);

  FirebaseAppCheck firebaseAppCheck = FirebaseAppCheck.instance;
  firebaseAppCheck.activate();


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoadingProvider(context: Get.context)),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => PostProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return ScreenUtilInit(
      designSize: Size(width, height),
      child: GlobalLoaderOverlay(
        overlayColor: ConstColor.barrierColor.withOpacity(0.23),
        useDefaultLoading: false,
        overlayWidgetBuilder: (_) {
          return Center(
            child: Consumer<LoadingProvider>(
              builder: (context, loadingProvider, child) {
                return loadingProvider.isLoading
                    ? LoadingAnimationWidget.hexagonDots(
                  color:  ConstColor.primaryColor,
                  size: 50,
                )
                    : SizedBox.shrink();
              },
            ),
          );
        },
        child: GetMaterialApp(
          title: AppConstants.appName,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
            )
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.initialRoute,
          routes: AppPages.routes,
        ),
      ),
    );
  }
}
