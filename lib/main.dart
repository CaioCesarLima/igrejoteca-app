import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:igrejoteca_app/core/injector/injector.dart';
import 'package:igrejoteca_app/core/theme/theme_data.dart';
import 'package:igrejoteca_app/core/utils/firebase_notification/firebase_messaging_service.dart';
import 'package:igrejoteca_app/core/utils/notifications.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'core/router/router.dart' as router;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyCHq8X5o1rnSw3tcyXvHmgb1-NLxDU_Ayo',
          appId: '1:982898490313:android:3837d293e20dfd36e34618',
          messagingSenderId: '982898490313',
          projectId: 'push-notifications-igrejoteca'));
  final getIt = GetIt.instance;
  getIt.registerSingleton<router.Router>(router.Router(getIt));

  LocalNotificationHelper().init();
  FirebaseMessagingService().initialize();
  setupLocator();
  runApp(const RxRoot(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final routerApp = GetIt.instance.get<router.Router>();

    return MaterialApp(
      title: 'Igrejoteca App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.lightTheme(),
      initialRoute: routerApp.initialRoute,
      onGenerateRoute: routerApp.onGenerateRoute,
    );
  }
}
