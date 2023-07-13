import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tasknow_release/main.dart';
import 'package:tasknow_release/screens/home.dart';
import 'package:tasknow_release/widgets/homenotifier.dart';
import 'package:tasknow_release/widgets/settingsnotifier.dart';
import 'package:tasknow_release/widgets/task.dart';


class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);
  @override
  _CreateScreenFormState createState() => _CreateScreenFormState();
}
class _CreateScreenFormState extends State<CreateScreen> {
  int? day;
  int? month;
  int? year;
  int? hour;
  int? min;
  String id='0';
  DateTime now = DateTime.now();
 
  
  String info ='';
  final _infoTextController = TextEditingController();
  final _dayTextController = TextEditingController();
  final _monthTextController = TextEditingController();
  final _yearTextController = TextEditingController();
  final _hourTextController = TextEditingController();
  final _minutesTextController = TextEditingController();
  void _createTask() {
    
      info = _infoTextController.text;
    day = int.tryParse(_dayTextController.text);
    month = int.tryParse(_monthTextController.text);
    year = int.tryParse(_yearTextController.text);
    hour = int.tryParse(_hourTextController.text);
    min = int.tryParse(_minutesTextController.text);
    
      if (info.isNotEmpty &&
          day != null &&
          month != null &&
          year != null &&
          hour != null &&
          min != null && now !=null) {
        final String date = "$day.$month.$year";
        final String time = "$hour:$min";
        final String id = DateTime.now().millisecondsSinceEpoch.toString();
        final newTask = Task(info: info, date: date, time: time, id: id,created: now.toString());
        Provider.of<HomeNotifier>(context, listen: false).addTask(newTask);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                final tasks = Provider.of<HomeNotifier>(context, listen: false).tasks;
                final taskList = tasks.toList();
                return Home(tasks: taskList);
              },
            ),
);

         _infoTextController.clear();
    _dayTextController.clear();
    _monthTextController.clear();
    _yearTextController.clear();
    _hourTextController.clear();
    _minutesTextController.clear();
    day = null;
    month = null;
    year = null;
    hour = null;
    min = null;
    
       
      }
      
    }
  
  @override
  Widget build(BuildContext context) {
    final homeNotifier = Provider.of<HomeNotifier>(context);
    final settingsNotifier = Provider.of<SettingsNotifier>(context);
     

   return Material(
      child:Scaffold(
            backgroundColor: settingsNotifier.switchValuedarkmode
            ? homeNotifier.darkBackgroundColor
            : homeNotifier.backgroundColor,
             appBar: AppBar(
                  backgroundColor:  const Color.fromARGB(255, 69, 78, 83),
                  automaticallyImplyLeading: false,
                  elevation: 10, 
                  title: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "NEW TASK",
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
                SingleChildScrollView(
                child:Column(
                         children: [
                            Column(
                             children: [                                                            
                             SizedBox(
                              child: Transform.translate(
                               offset: const Offset(31, 80),
                              child: PhysicalModel(
                                borderRadius: BorderRadius.circular(20),
                               elevation: 5,
                                 color: const Color.fromARGB(255, 217, 217, 217),                               
                                child: Container(
                               height: 106,
                              width: 340,
                              child:Stack(
                            children:[                              
                              Transform.translate(
                              offset: const Offset(100,2),
                            child: Text(      
                          "Enter description",
                          style: GoogleFonts.getFont(
                          "Staatliches",
                          textStyle: const TextStyle(                           
                            color: Color.fromARGB(255, 39, 39, 39),
                            fontSize: 23,
                            fontWeight: FontWeight.w900,
                          ),
                              ),
                               ),
                            ),
                            Transform.translate(
                              offset: const Offset(20,45),
                              child:Transform.scale(
                                scale: 2.5,
                              child: const Icon(Icons.event_note),
                              ),
                            ),
                            ],                           
                          ),                          
                            )
                              ),
                              ),
                             ),                         
                       ],
                    ),
                    Padding(padding: const EdgeInsets.only(top:0),
                    child:SizedBox(
                              width: 250,
                              child:Transform.translate(
                              offset: const Offset(53,0),
                              child:Transform.scale(
                                scale: 1,
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                maxLength: 158,
                                cursorColor:  const Color.fromARGB(255, 0, 0, 0),
                                enabled: true,
                                style: const TextStyle(
                                 color: Color.fromARGB(255, 0, 0, 0),
                                 fontSize: 20, 
                                fontWeight: FontWeight.w400, 
                                ),          
                               controller: _infoTextController,
                                onChanged: (value) {
                                setState(() {
                                  info = value;
                                 });
                               },
                               decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 87, 154, 175), 
                               width: 2,        
                                  ),
                            ),
                                hintText: 'Information about task'),
                               ),
                              ),
                            ),
                            ),
                    ),
                    /////////////SECOND INPUT DATE
                    Column(
                             children: [
                             SizedBox(
                              child: Transform.translate(
                               offset: const Offset(31, 40),
                              child: PhysicalModel(
                                borderRadius: BorderRadius.circular(20),
                               elevation: 5,
                                 color: const Color.fromARGB(255, 217, 217, 217),
                                child: Container(
                               height: 116,
                              width: 315,
                              child:Stack(
                            children:[
                              Transform.translate(
                              offset: const Offset(125,2),
                            child: Text(      
                          "Enter date",
                          style: GoogleFonts.getFont(
                          "Staatliches",
                          textStyle: const TextStyle(
                            color: Color.fromARGB(255, 39, 39, 39),
                            fontSize: 23,
                            fontWeight: FontWeight.w900,  
                          ),
                              ),
                               ),
                            ),
                            Transform.translate(
                              offset: const Offset(20,58),
                              child:Transform.scale(
                                scale: 2.5,
                              child: const Icon(Icons.calendar_month),
                              ),
                            ),                           
                            ],                           
                          ),                                                   
                            )
                              ),
                              ),
                             ),                            
                             Transform.translate(
                              offset: const Offset(20,-30),
                             child:Stack(
                             children:[Container(
                              width: 50,
                              margin: const EdgeInsets.only(left: 75, bottom: 0),
                              
                              child:Transform.scale(
                              scale: 1.4,
                              
                              child: TextFormField(
                                
                                
                              textAlign: TextAlign.center,    
                                                       
                                cursorColor:  const Color.fromARGB(255, 0, 0, 0),                    
                                enabled: true,
                                maxLength: 2,   
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),   
                                fontSize: 20, 
                                fontWeight: FontWeight.w600, 
                                ),          
                               controller: _dayTextController,
                               decoration:  InputDecoration(
                                border: InputBorder.none,
                                fillColor: const Color.fromARGB(255, 175, 175, 175), 
                                filled: true,
                                enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(0, 175, 175, 175),   
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),   
                            ),
                                hintText: 'D',
                                hintStyle: const TextStyle(
                                  fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                ),
                                counterText: '',
                                ),
                                buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) {
                                  return null; 
                                 },
                                 validator: (value) {
                                  day = value as int?;                                                                                            
                                  },
                               ),
                              ),
                            
                            ),
                            Container(
                              width: 50,
                              margin: const EdgeInsets.only(left: 150,bottom: 0),
                              
                              child:Transform.scale(
                                scale: 1.4,
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                

                                cursorColor:  const Color.fromARGB(255, 0, 0, 0),
                                 
                                enabled: true,
                                maxLength: 2,
                                 inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                
                                style: const TextStyle(
                                 color: Color.fromARGB(255, 0, 0, 0),
                                 
                                 fontSize: 20, 
                                fontWeight: FontWeight.w600, 
                                ),          
                               controller: _monthTextController,
                               decoration:  InputDecoration(
                                border: InputBorder.none,
                                fillColor: const  Color.fromARGB(255, 175, 175, 175),  
                                filled: true,
                                
                                enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(0, 175, 175, 175),
                                    
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                            ),
                                hintText: 'M',
                                 hintStyle: const TextStyle(
                                  fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                 
                                ),counterText: '',
                                ),
                                buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) {
                                  return null; 
                                 },
                                 validator: (value) {
                                   month = value as int?; 
                               
                                  },
                              
                               ),
                              ),
                            //),
                            ),
                            Container(
                              width: 70,
                              margin: const EdgeInsets.only(left:230),                                                         
                              child:Transform.scale(
                                scale: 1.4,
                              child: TextFormField(
                                textAlign: TextAlign.center,                               
                                cursorColor:  const Color.fromARGB(255, 0, 0, 0),
                                enabled: true,
                                maxLength: 4,
                                 inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                style: const TextStyle(
                                 color: Color.fromARGB(255, 0, 0, 0),
                                 fontSize: 20, 
                                fontWeight: FontWeight.w600, 
                                ),          
                               controller: _yearTextController,
                               decoration:  InputDecoration(
                                border: InputBorder.none,
                                fillColor: const Color.fromARGB(255, 175, 175, 175),  
                                filled: true,
                                enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(0, 175, 175, 175),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                            ),
                                hintText: 'Y',
                                 hintStyle: const TextStyle(
                                  fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                 
                                ),counterText: '',
                                ),
                                buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) {
                                  return null; 
                                 },
                                 validator: (value) {
                                  year = value as int?; 
                                
                                  },
                               ),
                              ),
                            ),
                             ],
                             ),
                            ),
                       ],
                    ),
                    ////////THIRD INPUT WIDG
                    Column(
                             children: [              
                            SizedBox(
                              child: Transform.translate(
                               offset: const Offset(31, 20),
                              child: PhysicalModel(
                                borderRadius: BorderRadius.circular(20),
                               elevation: 5,
                                 color: const Color.fromARGB(255, 217, 217, 217),                               
                                child: Container(
                               height: 126,
                              width: 300,
                              child:Stack(
                            children:[                             
                              Transform.translate(
                              offset: const Offset(115,2),
                            child: Text(      
                          "Enter time",
                          style: GoogleFonts.getFont(
                          "Staatliches",
                          textStyle: const TextStyle(                           
                            color: Color.fromARGB(255, 39, 39, 39),
                            fontSize: 23,
                            fontWeight: FontWeight.w900,                            
                          ),
                              ),
                               ),
                            ),
                            Transform.translate(
                              offset: const Offset(25,63),
                              child:Transform.scale(
                                scale: 2.9,
                              child: const Icon(Icons.schedule),
                              ),
                            ),                            
                            ],
                          ),    
                            )
                              ),
                              ),
                             ),
                        Transform.translate(
                          offset: const Offset(90,-56),                         
                              child: Container(
                              width: 50,
                              margin: const EdgeInsets.only(right: 180 ),                            
                              child:Transform.scale(
                                scale: 1.8,
                              child: TextFormField(
                                textAlign: TextAlign.center,                               
                                cursorColor:  const Color.fromARGB(255, 0, 0, 0),                                
                                enabled: true,
                                maxLength: 2,
                                 inputFormatters: [FilteringTextInputFormatter.digitsOnly],                               
                                style: const TextStyle(
                                 color: Color.fromARGB(255, 0, 0, 0),                                 
                                 fontSize: 20, 
                                fontWeight: FontWeight.w600, 
                                ),          
                               controller: _hourTextController,
                               decoration:  InputDecoration(
                                border: InputBorder.none,
                                fillColor: const  Color.fromARGB(255, 175, 175, 175),  
                                filled: true,                               
                                enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(0, 175, 175, 175),
                                    
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                            ),
                                hintText: 'H',
                                 hintStyle: const TextStyle(
                                  fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,                                 
                                ),counterText: '',
                                ),
                                buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) {
                                  return null; 
                                 },
                                 validator: (value) {
                                   hour = value as int?; 
                                
                                  },                              
                               ),
                              ),
                            ),
                            ),
                            Transform.translate(
                              offset: const Offset(60,-95),
                              child:Transform.scale(
                                scale: 7,
                              child: const Text(":"),
                              ),
                            ),
                            Transform.translate(offset: const Offset(20, -122),
                            child:Container(
                              width: 50,
                              margin: const EdgeInsets.only(left: 190),                             
                              child:Transform.scale(
                                scale: 1.8,
                              child: TextFormField(
                                textAlign: TextAlign.center,                        
                                cursorColor:  const Color.fromARGB(255, 0, 0, 0),
                                enabled: true,
                                maxLength: 2,
                                 inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                style: const TextStyle(
                                 color: Color.fromARGB(255, 0, 0, 0),
                                 fontSize: 20, 
                                fontWeight: FontWeight.w600, 
                                ),          
                               controller: _minutesTextController,
                               decoration:  InputDecoration(
                                border: InputBorder.none,
                                fillColor: const  Color.fromARGB(255, 175, 175, 175),  
                                filled: true,
                                enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(0, 175, 175, 175),
                                    
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                            ),
                                hintText: 'M',
                                 hintStyle: const TextStyle(
                                  fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                ),counterText: '',
                                ),
                                buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) {
                                  return null; 
                                 },
                                 validator: (value) {
                                   min = value as int?; 
                                 
                                  },
                               ),
                              ),
                            ),
                            ),     
                       ],
                    ),   
                   ],
                ),
                ),
                bottomNavigationBar:  BottomAppBar(
                  height: 90,
                color:  const Color.fromARGB(255, 69, 78, 83),
                 child: Row(
                    children:[
                      SizedBox(
                    height: 200,                
                      child:Transform.scale(
                        scale: 1.4,
                        child:Transform.translate(
                          offset: const Offset(10, 5), 
                        child: TextButton( 
                          style: TextButton.styleFrom(
                            elevation: 35, 
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        },
                        child:const  Image(image: AssetImage('assets/x.png'),
                        )),
                        ),
                     ),
                    ),
                    Transform.translate(
                      offset: const Offset(100,0),
                      child: Transform.scale(
                        scale: 1.7,
                      child: FilledButton(        
                        style: ElevatedButton.styleFrom(
                            elevation: 25,
                          backgroundColor: const Color.fromARGB(255, 87, 154, 175),
                        ),
                        onPressed:  _createTask,
                        child: Text(
                      "CONFIRM",
                      style: GoogleFonts.getFont(
                        "Staatliches",
                        textStyle: const TextStyle(
                          color: Color.fromARGB(255, 69, 78, 83),
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                        ),  
                      ),
                    ),),
                    ),
                    ),
                    ],      
                 ),            
          ),
        ),
    );
  }
}