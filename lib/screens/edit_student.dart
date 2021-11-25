// import 'dart:io';

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:student_details_app/data_base_helper/data_base_helper.dart';
import 'package:student_details_app/main.dart';
import 'package:student_details_app/models/student_model.dart';
import 'package:student_details_app/provider/change_notifier_provider.dart';

import 'package:student_details_app/widgets/dropdown_button.dart';

class EditStudent extends StatefulWidget {

  StudentModel student;
 

  EditStudent(
      
      this.student);
     
  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  StudentState st =StudentState();
  Widget studentImageGet(base64String) {
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

  changeIt(selectedValue) {
    setState(() {
      newStudent!.status = selectedValue;
    });
    print(widget.student.status);
  }

  // final ImagePicker _picker = new ImagePicker();

  StudentModel? newStudent;

//function

 

  TextEditingController nameController = TextEditingController();
  TextEditingController rollController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController markController = TextEditingController();
  
 

  @override
  Widget build(BuildContext context) {
    rollController.text=widget.student.rollNumber!;
    nameController.text = widget.student.name;
    classController.text=widget.student.standard!;
    markController.text=widget.student.marks!;
   
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Student"),
      ),
      body: Container(
        color: Colors.black,
        child: ListView(children: [
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Card(
                elevation: 10,
                shadowColor: Color(MyApp.royalBlue),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      InkWell(
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: path == null
                              ? studentImageGet(widget.student.image)
                              : imageLoad(),
                        ),
                        onTap: () {
                          takePhoto(ImageSource.gallery);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        child: TextFormField(
                          controller: rollController,

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required field";
                            }
                            return null;
                          },
                          
                          // controller: nameController,
                          keyboardType: TextInputType.number,
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
                         
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        child: TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required field";
                            }
                            return null;
                          },
                          
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
                          
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        child: TextFormField(
                          controller: classController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required field";
                            }
                            return null;
                          },
                         
                          keyboardType: TextInputType.number,
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
                         
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        child: TextFormField(
                          controller: markController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required field";
                            }
                            return null;
                          },
                          
                          keyboardType: TextInputType.number,
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
                            newStudent!.marks = value;
                          },
                        ),
                      ),
                      DropDown(widget.student.status, changeIt),
                      ElevatedButton(
                        onPressed: () async {
                          newStudent!.rollNumber=nameController.text;
                          
                          Provider.of<StudentState>(context,listen: false).updateStudent(newStudent!);
                          Navigator.pop(context);
                        },
                        child: Text("Save Edited"),
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

  var path;
  final ImagePicker _picker = new ImagePicker();
  XFile? images;
  var imageBytes;

  takePhoto(source) async {
    images = (await _picker.pickImage(
      source: source,
    ));
    if (images != null) {
      Uint8List imageBytes = await images!.readAsBytes();
      widget.student.image = base64Encode(imageBytes);
    }

    setState(() {
      if (images != null) {
        path = images!.path;
      }
    });
  }

  Widget imageLoad() {
    if (path != null) {
      return Image.file(File(path), fit: BoxFit.cover);
    } else
      return CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text(
          "Add Photo",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
  }
}
