import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_record/Widgets/input_field_widget.dart';
import 'package:student_record/database/models/studentModel.dart';
import 'package:student_record/database/functions/db_functions.dart';

// ignore: must_be_immutable
class InputBottonSheet extends StatefulWidget {
  StudentModel student;
  InputBottonSheet({super.key, required this.student});

  @override
  // ignore: no_logic_in_create_state
  State<InputBottonSheet> createState() =>  _InputBottonSheetState(student: student);
}

class _InputBottonSheetState extends State<InputBottonSheet> {
  bool isImg = false;
  File? _image;
  Future<void> pickImage() async {
    final imagePicked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      setState(() {
        _image = File(imagePicked.path);
        isImg = true;
      },);
    }
  }

  StudentModel student;

  _InputBottonSheetState({required this.student});
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _ageController = TextEditingController();

  final TextEditingController _phoneEditingController = TextEditingController();

  final TextEditingController _emailEditingController = TextEditingController();

//initState sets the initial values to the input_field_widget  
  @override
  void initState() {
    _nameController.text = student.name;
    _ageController.text = student.age;
    _phoneEditingController.text = student.phone;
    _emailEditingController.text = student.mail;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        const SizedBox(
          height: 6,
        ),
        InputFieldWidget(
          inputController: _nameController,
          label: 'Name',
          type: TextInputType.name,
        ),
        const SizedBox(
          height: 6,
        ),
        InputFieldWidget(
          inputController: _ageController,
          label: 'Age',
          type: TextInputType.number,
        ),
        const SizedBox(
          height: 6,
        ),
        InputFieldWidget(
          inputController: _phoneEditingController,
          label: 'Phone Number',
          type: TextInputType.phone,
        ),
        const SizedBox(
          height: 6,
        ),
        InputFieldWidget(
          inputController: _emailEditingController,
          label: 'E-mail',
          type: TextInputType.emailAddress,
        ),
        const SizedBox(
          height: 6,
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {
                pickImage();
              },
//This row is for img change and txt              
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(Icons.image),
                  ),
                   Text('Change Photo',style: GoogleFonts.aclonica(),),
                  Visibility(
                    visible: isImg,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.black54,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 18,
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(60),
                            child: (_image != null) ? Image.file(_image!,fit: BoxFit.cover,) : Image.asset('assets/images/user02.jpg'),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: double.infinity,
                
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.blueGrey.shade300
                  ),
                  onPressed: () {
                    StudentModel stu = StudentModel(
                        imgPath: _image?.path ?? student.imgPath,
                        id: student.id,
                        age: _ageController.text,
                        name: _nameController.text,
                        mail: _emailEditingController.text,
                        phone: _phoneEditingController.text);
                    updateStudent(stu);

                    Navigator.of(context).pop();
                  },
                  child: Text('Update Student',
                    style: GoogleFonts.aclonica(),
                  ),
                  
                ),
              ),
            ],
          ),
        )
      ]),
    );

  }
}
