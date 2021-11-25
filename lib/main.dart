import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:student_details_app/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:student_details_app/data_base_helper/data_base_helper.dart';
import 'package:student_details_app/provider/change_notifier_provider.dart';
import 'package:student_details_app/screens/add_student.dart';
import 'package:student_details_app/screens/home_screen.dart';
import 'package:student_details_app/screens/search_student.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => StudentState(),
          ),
        ],
        child:MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  MyApp(),
      )));
}

class MyApp extends StatefulWidget {
  static const mintGreen = 0xff3EB489;
  static const scarletRed = 0xffFF2400;
  static const royalBlue = 0xff246EE9;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DataBaseHelper db = DataBaseHelper();
  StudentState st = StudentState();
  List<StudentModel>? studentModel2;
  List<StudentModel> studentModel3 = <StudentModel>[];

//  *************Functions ***************//

//function for getting student data from database//

  void getStudentData() async {
    
    studentModel2 = await st.getStudent();

    setState(() {});
  }



// //function for setting the state after adding student data to database//
//   void letState(StudentModel newStudent, context) async {
//     final data = DataBaseHelper();
//     await data
//         .insertStudent(newStudent); //database helper function to insert data
//     studentModel2 = await db.getStudent();
//     setState(() {});
//     Navigator.pop(context);
//   }

  //function fot setting the state of mainscreen when data is deleted
  void deleteIt(id) async {
    final db = DataBaseHelper();
    db.deleteStudent(
        id); //database helper function invoked to delete the data from database
    studentModel2 = await db.getStudent(); // gets the updated data
    setState(() {}); //Sets the state of the screen after getting updated data
  }



  

  @override
  Widget build(BuildContext context) {
   

    return Builder(builder: (context) {
      return DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text('Student Log'),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(MyApp.royalBlue), Colors.black],
                  ),
                ),
              ),
              centerTitle: true,
              elevation: 20,
              bottom: TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.home),
                    text: "Home",
                  ),
                  Tab(
                    icon: Icon(Icons.search),
                    text: "Search",
                  )
                ],
                indicatorColor: Colors.white,
              ),
            ),
            body: Consumer<StudentState>(
              builder: (context,studentState, child) {
                print("rebuild");
                return TabBarView(children: [
                  FutureBuilder(
                    future: studentState.getStudent(),
                    builder: (context,snapShot) {
                      if(snapShot.hasData){
                        List<StudentModel> students = snapShot.data as List<StudentModel> ;
                         return ListView(
                        children: [
                          ...students.map((e) {
                            //building list of widgets according to the input dat and spreading it.
                            return HomeScreen(
                              // passes these many parameters because it is needed to pass these info to another screens from home screen
                             e
                            );
                          }).toList(),
                        ],
                      );
                      
                      }else return Container();
                     
                    }
                  ),
                  //passes letstate function to set state here when an event happens there
                  SearchStudent(
                      ), //passed functions to edit and delete as well as setting the state
                ]);
              }
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddStudent(),
                  ),
                );
              },
              child: Icon(
                Icons.add,
              ),
              backgroundColor: Color(MyApp.royalBlue),
            ),
          ),
        ),
      );
    });
  }
}
