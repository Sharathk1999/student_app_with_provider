import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_record/database/functions/db_functions.dart';
import 'package:student_record/database/models/studentModel.dart';

import '../../Widgets/input_field_widget.dart';

// ignore: must_be_immutable
class InputPage extends StatefulWidget {
  String? name;
  String? age;
  String? phone;
  String? email;
  String? imgPath;
  InputPage.update({
    super.key,
    this.name,
    this.age,
    this.email,
    this.imgPath,
    this.phone,
  }) {
    _InputPageState.update( //set initial values 
      name: name,
      age: age,
      phone: phone,
      mail: email,
      imgPath: imgPath,
    );
  }
  InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  _InputPageState();
  String? name;
  String? age;
  String? phone;
  String? mail;
  String? imgPath;
  _InputPageState.update(
      {this.name, this.age, this.phone, this.mail, this.imgPath}) {
    setOnUpdate();
  }
  final formkey = GlobalKey<FormState>();

  File? _image;
  Future<void> pickImage() async {
    final imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      setState(() {
        _image = File(imagePicked.path);
        //print(imagePicked.path);
      });
    }
  }
//clearPage() resets the values of the input fields after succesfull regis.
  void clearPage() {
    _nameController.text = '';
    _ageController.text = '';
    _emailEditingController.text = '';
    _phoneEditingController.text = '';
  }

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneEditingController = TextEditingController();
  final _emailEditingController = TextEditingController();

// setOnUpdate() is to set text fields display the initial values of the student's record.
  void setOnUpdate() {
    _nameController.text = name!;
    _ageController.text = age!;
    _phoneEditingController.text = phone!;
    _emailEditingController.text = mail!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Student',
          style: GoogleFonts.aclonica(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formkey,
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () => pickImage(),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CircleAvatar(
                          radius: 62,
                          backgroundColor: Colors.black54,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 60,
                            child: ClipOval(
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(40),
                                child: (_image != null)
                                    ? Image.file(
                                        _image!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset('assets/images/user02.jpg'),
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          bottom: 5.5,
                          child: Icon(
                            Icons.add_a_photo_rounded,
                            size: 25,
                            color: Color.fromARGB(255, 84, 92, 106),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InputFieldWidget(
                      inputController: _nameController,
                      label: 'Enter Your Name',
                      type: TextInputType.name),
                  InputFieldWidget(
                      inputController: _ageController,
                      label: 'Enter Your Age',
                      type: TextInputType.number),
                  InputFieldWidget(
                      inputController: _phoneEditingController,
                      label: 'Enter Your Phone',
                      type: TextInputType.phone),
                  InputFieldWidget(
                      inputController: _emailEditingController,
                      label: 'Enter Your e-mail',
                      type: TextInputType.emailAddress),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20), // Adjust the value as needed
                            ),
                          ),
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              formkey.currentState!.save();
                              StudentModel student = StudentModel(
                                  age: _ageController.text,
                                  name: _nameController.text,
                                  phone: _phoneEditingController.text,
                                  mail: _emailEditingController.text,
                                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                                  imgPath: _image?.path ?? 'no-img');
                              addStudent(student);

                              Navigator.of(context).pop();
                              getAllData();
                              // clearPage();
                            }
                          },
                          child: Text(
                            'Register',
                            style: GoogleFonts.aclonica(),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
