// import 'dart:js';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_details_app/data_base_helper/data_base_helper.dart';
import 'package:student_details_app/main.dart';
import 'package:student_details_app/models/student_model.dart';
import 'package:student_details_app/provider/change_notifier_provider.dart';

import 'package:student_details_app/screens/edit_student.dart';
import 'package:student_details_app/screens/view_student.dart';

class HomeScreen extends StatelessWidget {
  DataBaseHelper db = DataBaseHelper();
  Function? searchResultEdit;
  StudentModel student;
  Function? deleteIt;
  



  HomeScreen(
   this.student
  );

  Widget studentImageGet(base64String) {
    //function for displaying the image from database in our widger tree.
    if (base64String != null && base64String!="") {
      return Image.memory(
        base64Decode(base64String),
        fit: BoxFit.cover,
      );
    }
    return Container(
      height: 100,
      width: 100,
      color: Colors.blue,
      child:Image(image: AssetImage("assets/user.png"),
      fit: BoxFit.fitHeight,)
    );
  }

  @override
  Widget build(BuildContext context) {
    delete() {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Your Wish?"),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                      Provider.of<StudentState>(context,listen: false).deleteStudent(student.id)  ;
                        Navigator.pop(context);
                      },
                      child: Text("Delete"),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditStudent(
                                        //navigates to edit student carrying the datas that student have
                                       
                                        student,
                                      
                                      
                                      )));
                        },
                        child: Text("Edit"))
                  ],
                ),
              ));
      //
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        shadowColor: Color(MyApp.royalBlue),
        child: ListTile(
          leading: Container(
            width: 100,
            height: 100,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: studentImageGet(student.image),
          ),
          title: Text(student.name),
          trailing: Text(
            student.status,
            style: TextStyle(
              color: student.status == 'Failed' ? Colors.red : Colors.green,
            ),
          ),
          onLongPress: delete,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ViewStudent(
                          
                          student: student
                         
                        )));
          },
        ),
      ),
    );
  }
}
