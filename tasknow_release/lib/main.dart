import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasknow_release/integer/application.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasknow_release/widgets/homenotifier.dart';
import 'package:tasknow_release/widgets/settingsnotifier.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    SharedPreferences.getInstance(),
  ]);
  runApp(
    MultiProvider(  
      providers: [
        ChangeNotifierProvider<HomeNotifier>(create: (_) => HomeNotifier()),
        ChangeNotifierProvider<SettingsNotifier>(
          create: (context) => SettingsNotifier(context),
        ),
      ],
      child: const Application(),
    ),
  );
}