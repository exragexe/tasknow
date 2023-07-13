import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasknow_release/integer/application.dart';
import 'package:tasknow_release/main.dart';
import 'package:tasknow_release/widgets/homenotifier.dart';
import 'package:tasknow_release/widgets/settingsnotifier.dart';
import 'package:tasknow_release/widgets/task.dart';
import 'package:intl/intl.dart';
import 'package:tasknow_release/widgets/database.dart';

class Home extends StatefulWidget {
 final List<Task> tasks;
 int taskId = 0; 
  Home({Key? key, required this.tasks}) : super(key: key);
  
  Task? get task => tasks.isNotEmpty ? tasks.first : null;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _switchValue = false;
  @override
  
  void initState() {
    
    super.initState();
    Task? task = widget.task;
    Provider.of<HomeNotifier>(context, listen: false).loadTasks();
    
     
  }
   Future<void> _loadTasksFromDatabase() async {
    try {
      List<Task> tasks = await DatabaseHelper.instance.getTasks();
      Provider.of<HomeNotifier>(context, listen: false).tasks;
    } catch (e) {
      print('Error loading tasks from database: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    final settingsNotifier = Provider.of<SettingsNotifier>(context);
    final homeNotifier = Provider.of<HomeNotifier>(context);

    

    return Material(
      child: Scaffold(
        backgroundColor: settingsNotifier.switchValuedarkmode
            ? homeNotifier.darkBackgroundColor
            : homeNotifier.backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 69, 78, 83),
          elevation: 10,
          title: Align(
            child: Text(
              "TASKS",
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
        body: 
        Consumer<HomeNotifier>(
  builder: (context, homeNotifier, _) {
    final tasks = homeNotifier.tasks;

    if (homeNotifier.priorityEnabled) {
      tasks.sort((a, b) => a.date.compareTo(b.date));
    } else {
      tasks.sort((a, b) => a.created.compareTo(b.created));
    }
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks.elementAt(index);
        return Dismissible(
          key: Key(task.id.toString()),
          direction: DismissDirection.endToStart, 
          background: Container(
            color: Colors.red, 
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 16.0),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) {
            
           homeNotifier.removeTask(task);
          },
          child: SingleChildScrollView(
            
            child: Column(
            
              children: [
                SizedBox(
                  child: Transform.translate(
                    offset: const Offset(11, 90),
                    child: PhysicalModel(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 5,
                      color: const Color.fromARGB(255, 200, 200, 200),
                      child: Container(
                        height: 90,
                        width: 360,
                        child: Stack(
                          children: [
                            SizedBox( 
                            child:Transform.scale(
                              scale: 1.1,
                              child: Transform.translate(
                                offset: const Offset(185, 22),
                           child: const Image(image: AssetImage("assets/line.png")),
                       ),
                        ),
                        ),
                            Transform.translate(
                              offset: const Offset(50, 55),
                              child: Text(
                                task != null ? task.date : '',
                                style: GoogleFonts.getFont(
                                  "Staatliches",
                                  textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 30,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.5,
                                    height: 0.8,
                                  ),
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: const Offset(260, 55),
                              child: Text(
                                task != null ? task.time : '',
                                style: GoogleFonts.getFont(
                                  "Staatliches",
                                  textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 30,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.5,
                                    height: 0.8,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                
                
                SizedBox(
                  child:Padding(padding: const EdgeInsets.only(),
                  child: Transform.translate(
                    offset: const Offset(11, -75),
                    child: PhysicalModel(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 5,
                      color: const Color.fromARGB(255, 217, 217, 217),
                      child: Container(
                        height: 110,
                        width: 360,
                        child: Stack(
                          children: [
                            Transform.translate(
                              offset: const Offset(7, 0),
                              child: Center(
                                child: Text(
                                  task != null ? task.info : '',
                                  style: GoogleFonts.getFont(
                                    "Staatliches",
                                    textStyle: const TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.5,
                                      height: 0.8,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ),
                
                
              ],
            ),
          ),
          //),
        );
      },
    );
  },
),
      
        bottomNavigationBar: BottomAppBar(
          height: 90,
          color: const Color.fromARGB(255, 69, 78, 83),
          child: Row(
            children: [
              SizedBox(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Transform.scale(
                    scale: 2.3,
                    child: Switch(
                      value: homeNotifier.priorityEnabled,
                      activeColor: const Color.fromARGB(255, 87, 154, 175),
                        inactiveThumbColor: const Color.fromARGB(255, 244, 239, 244),
                        
                      onChanged: (value) {
                        setState(() {
                          homeNotifier.setPriorityEnabled(value);
                        });
                       
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 134,
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.only(left: 80, bottom: 20),
                  child: Transform.scale(
                    scale: 2,
                    child: Transform.translate(
                      offset: const Offset(-5, -5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 25,
                          backgroundColor: const Color.fromARGB(255, 87, 154, 175),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/createscreens');
                        },
                        child: const Image(image: AssetImage('assets/+.png')),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 134,
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.only(left: 80, bottom: 20),
                  child: Transform.scale(
                    scale: 2,
                    child: Transform.translate(
                      offset: const Offset(-7, 5),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          elevation: 35,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/settings');
                        },
                        child: const Image(image: AssetImage('assets/set.png')),
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

