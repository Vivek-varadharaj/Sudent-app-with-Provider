import 'package:flutter/material.dart';
import 'package:student_details_app/data_base_helper/data_base_helper.dart';
import 'package:student_details_app/models/student_model.dart';

class StudentState with ChangeNotifier{
  DataBaseHelper db = DataBaseHelper.createInstance();
 Future <List<StudentModel>> getStudent() async{
   List<StudentModel> students =await db.getStudent();
  
   return students;
  }

  Future <bool> addStudent(StudentModel student) async{
    await db.insertStudent(student);
    notifyListeners();
    print("notified");
    return true;
  }

  void deleteStudent(id) {
     db.deleteStudent(id);
     notifyListeners();

  }

  void updateStudent (StudentModel student){
    db.editStudent(student, student.id!);
    notifyListeners();
  }
}