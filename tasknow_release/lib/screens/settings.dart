import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasknow_release/main.dart';
import 'package:tasknow_release/widgets/homenotifier.dart';
import 'package:tasknow_release/widgets/settingsnotifier.dart';
import 'package:tasknow_release/widgets/task.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tasknow_release/integer/application.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tasknow_release/widgets/database.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Settings> {
  bool _switchValuedarkmode = false;
  bool _switchValuemesage = false;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void cancelNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  void initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/icon');
    final InitializationSettings initializationSettings =
        const InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  @override
  void initState() {
    super.initState();
    initializeNotifications();
  }

  _launchURLtg() async {
    const url = 'https://t.me/id437810256907';
    if (await UrlLauncher.canLaunch(url)) {
      await UrlLauncher.launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Can\'t open url. $url';
    }
  }

  _launchURLgt() async {
    const url = 'https://github.com/exragexe';
    if (await UrlLauncher.canLaunch(url)) {
      await UrlLauncher.launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Can\'t open url. $url';
    }
  }

  _launchURLins() async {
    const url = 'https://www.instagram.com/1010111011000010101101o101010/';
    if (await UrlLauncher.canLaunch(url)) {
      await UrlLauncher.launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Can\'t open url. $url';
    }
  }

  Future<void> showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Task Deadline',
      'Your task is approaching its deadline.',
      platformChannelSpecifics,
    );
  }

  void scheduleNotifications() async {
    if (_switchValuemesage) {
      final tasks = await DatabaseHelper.instance.getTasks();
      final now = DateTime.now();
      final oneHourFromNow = now.add(const Duration(hours: 1));

      for (final task in tasks) {
        final taskDate = DateFormat('dd.MM.yyyy').parse(task.date);
      
        final taskTime = DateFormat('HH:mm').parse(task.time);
        final taskDeadline = DateTime(taskDate.year, taskDate.month, taskDate.day, taskTime.hour, taskTime.minute);

        if (taskDeadline.isAfter(now) && taskDeadline.isBefore(oneHourFromNow)) {
          await scheduleNotification(taskDeadline, task.info);
        }
      }
    }
  }

  Future<void> scheduleNotification(DateTime dateTime, String taskInfo) async {
    final androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      importance: Importance.max,
      priority: Priority.high,
    );
    final platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Task Deadline',
      'Your task "$taskInfo" is approaching its deadline.',
      tz.TZDateTime.from(dateTime, tz.local),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeNotifier = Provider.of<HomeNotifier>(context);
    final settingsNotifier = Provider.of<SettingsNotifier>(context);
    return Material(
      child: Scaffold(
        backgroundColor: settingsNotifier.switchValuedarkmode
            ? homeNotifier.darkBackgroundColor
            : const Color.fromARGB(255, 201, 201, 201),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 69, 78, 83),
          elevation: 10,
          automaticallyImplyLeading: false,
          title: Align(
            alignment: Alignment.center,
            child: Text(
              "SETTINGS",
              style: GoogleFonts.getFont(
                "Staatliches",
                textStyle: const TextStyle(
                  color: Color.fromARGB(255, 87, 154, 175),
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                ),
                shadows: [
                  Shadow(
                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                    offset: const Offset(2, 5),
                    blurRadius: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 60,
                  child: Transform.translate(
                    offset: const Offset(0, 130),
                    child: Text(
                      "Notification",
                      style: GoogleFonts.getFont(
                        "Staatliches",
                        textStyle: const TextStyle(
                          color: Color.fromARGB(255, 39, 39, 39),
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                        ),
                        shadows: [
                          Shadow(
                            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                            offset: const Offset(2, 5),
                            blurRadius: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 140),
                    child: Transform.scale(
                      scale: 3,
                      child: Switch(
                        value: settingsNotifier.switchValuemesage,
                        activeColor: const Color.fromARGB(255, 87, 154, 175),
                        inactiveThumbColor: const Color.fromARGB(255, 244, 239, 244),
                        onChanged: (value) async {
                                
                          setState(() {
                            Provider.of<SettingsNotifier>(context, listen: false).switchValuemesage = value;
                            _switchValuemesage = value;
                          });
                          if (value) {
                            scheduleNotifications();
                          } else {
                            cancelNotifications();
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: Transform.translate(
                    offset: const Offset(0, 40),
                    child: Text(
                      "DARK MODE",
                      style: GoogleFonts.getFont(
                        "Staatliches",
                        textStyle: const TextStyle(
                          color: Color.fromARGB(255, 39, 39, 39),
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                        ),
                        shadows: [
                          Shadow(
                            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                            offset: const Offset(2, 5),
                            blurRadius: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Transform.translate(
                      offset: const Offset(0, 0),
                      child: Transform.scale(
                        scale: 3,
                        child: Switch(
                          value: settingsNotifier.switchValuedarkmode,
                          activeColor: const Color.fromARGB(255, 87, 154, 175),
                          inactiveThumbColor: const Color.fromARGB(255, 244, 239, 244),
                        
                          onChanged: (value) {
                          setState(() {
                              Provider.of<SettingsNotifier>(context, listen: false).switchValuedarkmode = value;
                           });
                           if (value == true) {
                                Provider.of<HomeNotifier>(context, listen: false).changeBackgroundColor(const Color.fromARGB(255, 80, 80, 80));
                             }
                          },

                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(top: 80, left: 70),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: _launchURLins,
                      child: Image.asset(
                        'assets/ins.png',
                      ),
                    ),
                    TextButton(
                      onPressed: _launchURLtg,
                      child: Image.asset('assets/tg.png'),
                    ),
                    TextButton(
                      onPressed: _launchURLgt,
                      child: Image.asset('assets/gt.png'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          height: 90,
          color: const Color.fromARGB(255, 69, 78, 83),
          child: Row(
            children: [
              SizedBox(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(left: 0, bottom: 0),
                  child: Transform.scale(
                    scale: 1.2,
                    child: Transform.translate(
                      offset: const Offset(10, 0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          elevation: 25,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        },
                        child: const Image(image: AssetImage('assets/strelka.png')),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}
