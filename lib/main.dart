import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:logistics_app/config/colors.dart';
import 'package:logistics_app/controllers/core_controllers/initialize_app_controller.dart';
//import 'package:get/get.dart';
import 'package:logistics_app/services/firebase_service.dart';
import 'package:logistics_app/theme/app_theme.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mapbox_search/mapbox_search.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  final String mapBoxKey = dotenv.env['MAPBOX_ACCESS_TOKEN']!;
  MapboxOptions.setAccessToken(mapBoxKey);
  MapBoxSearch.init(mapBoxKey);
  final FirebaseService firebaseService = Get.put(FirebaseService());
  firebaseService.initializeApp().then((value) {
    Get.put(InitializeAppController());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
     const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return GetMaterialApp(
      title: 'Logistics App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appThemeData,
      home: const Scaffold(
        backgroundColor: surface,
        body: Center(
          child: CircularProgressIndicator(backgroundColor: Colors.red),
        ),
      ),
    );
  }
}
