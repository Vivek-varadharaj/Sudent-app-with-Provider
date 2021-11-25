import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:student_details_app/main.dart';
import 'package:student_details_app/models/student_model.dart';
import 'package:student_details_app/screens/edit_student.dart';

import 'package:student_details_app/widgets/dropdown_button.dart';

class ViewStudent extends StatefulWidget {
  StudentModel student;
 
  ViewStudent({
    required this.student,
  
  });
  @override
  State<ViewStudent> createState() => _ViewStudentState();
}

class _ViewStudentState extends State<ViewStudent> {
  changeIt(selectedValue) {
    setState(() {
      widget.student.status = selectedValue;
    });
    print(widget.student.status);
  }



  StudentModel? newStudent;

  void addNewStudent(String newId, String newName, String newClass,
      String newStatus, String newMarks) {
    newStudent = StudentModel(
      id: widget.student.id,
      rollNumber: widget.student.rollNumber,
      name: widget.student.name,
      standard: widget.student.standard,
      status: widget.student.status,
      marks: widget.student.marks,
    );
   
  }

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Student"),
      ),
      body: Container(
        color: Colors.black,
        child: ListView(children: [
          Center(
            child: Container(
              // height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Card(
                elevation: 10,
                // color: Colors.lightBlue,
                shadowColor: Color(MyApp.royalBlue),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      InkWell(
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: studentImageGet(widget.student.image),
                        ),
                        onTap: () {
                          // takePhoto(ImageSource.camera);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        child: TextFormField(
                          controller: nameController,
                          enabled: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required field";
                            }
                            return null;
                          },
                          initialValue: widget.student.rollNumber,
                          // controller: nameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.card_membership),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(
                                  MyApp.royalBlue,
                                ),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            label: Text('Student ID'),
                          ),
                          onChanged: (value) {
                            widget.student.rollNumber = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        child: TextFormField(
                          enabled: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required field";
                            }
                            return null;
                          },
                          initialValue: widget.student.name,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.perm_identity),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(
                                  MyApp.royalBlue,
                                ),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            label: Text('Name of Student'),
                          ),
                          onChanged: (value) {
                            widget.student.name = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        child: TextFormField(
                          enabled: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required field";
                            }
                            return null;
                          },
                          initialValue: widget.student.standard,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.school),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(
                                  MyApp.royalBlue,
                                ),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            label: Text('Class of Student'),
                          ),
                          onChanged: (value) {
                            widget.student.standard = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        child: TextFormField(
                          enabled: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required field";
                            }
                            return null;
                          },
                          initialValue: widget.student.marks,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.card_membership),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(
                                  MyApp.royalBlue,
                                ),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            label: Text('Mark of Student'),
                          ),
                          onChanged: (value) {
                            widget.student.marks = value;
                          },
                        ),
                      ),
                      DropDown(widget.student.status, changeIt),
                      ElevatedButton(
                        onPressed: () {
                          
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditStudent(//Navigating to edit student upon request
                                        
                                        widget.student,
                                        
                                       
                                      )));
                        },
                        child: Text("Edit"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

 Widget studentImageGet(base64String) {//function for converting the base64 string back into uint8List and image.memory displays it.
    if (base64String != null && base64String!=""){
      return Image.memory(base64Decode(base64String),
      fit: BoxFit.cover,);
    }
    return Container(
      height: 100,
      width: 100,
      color: Colors.blue,
      child:Image(image: AssetImage("assets/user.png"),
      fit: BoxFit.fitHeight,)
    );
  }
}
