import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:check/presentations/controllers/todocontroller.dart';
import 'package:check/widgets/logobackground.dart';
import 'package:check/widgets/notification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:check/presentations/screens/home_screen.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await AndroidAlarmManager.initialize();
  NotificationHelper.init();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return ChangeNotifierProvider<TodoController>(
      create: (context) => TodoController(prefs),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Check',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Poppins',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const BackgroundScreen(child: Home())
      ),
    );
  }
}
