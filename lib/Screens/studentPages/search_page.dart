import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_record/Screens/screenHome/screen_home.dart';
import 'package:student_record/database/models/studentModel.dart';
import '../studentDetails/detailed_view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<StudentModel> studentList =
      Hive.box<StudentModel>('student_db').values.toList();
  late List<StudentModel> studentSearch = List<StudentModel>.from(studentList);

  TextEditingController searchCotntroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(241, 243, 241, 241),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) => _searchStudent(value),
                controller: searchCotntroller,
                decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        clearSearch();
                        _onTextChanged();
                      },
                    ),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(30))),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (ctx, index) {
                      StudentModel stu = studentSearch[index];
                      File? image;
                      if (stu.imgPath != 'no-img') {
                        image = File(stu.imgPath!);
                      }
                      if (studentSearch.isEmpty) {
                        return const Text('No students found');
                      } else {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => DetaildView(
                                      name: stu.name,
                                      age: stu.age,
                                      phone: stu.phone,
                                      email: stu.mail,
                                      image: image)));
                            },
                            title: Text(stu.name),
                            leading: CircleAvatar(
                              backgroundColor: Colors.black12,
                              child: ClipOval(
                                child: SizedBox.fromSize(
                                  size: const Size.fromRadius(20),
                                  child: (image != null)
                                      ? Image.file(
                                          image,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset('assets/images/user02.jpg'),
                                ),
                              ),
                            ),
                            trailing: SizedBox(
                              width: 150,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      bottomSheet(context, stu);
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Color.fromARGB(255, 104, 116, 135),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      deleteAlert(
                                          context, studentSearch[index]);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Color.fromARGB(255, 206, 107, 100),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    separatorBuilder: (ctx, index) {
                      return const SizedBox(
                        height: 5,
                      );
                    },
                    itemCount: studentSearch.length),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void _searchStudent(String value) {
  //   setState(() {
  //     studentSearch = studentList
  //         .where((element) => element.name.contains(value.trim()))
  //         .toList();
  //   });
  // }

  void _searchStudent(String value) {
    setState(() {
      studentSearch = studentList
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void _onTextChanged() {
    setState(() {
      if (searchCotntroller.text.isEmpty) {
        studentSearch = studentList;
      } else {
        _searchStudent(searchCotntroller.text);
      }
    });
  }

  void clearSearch() {
    searchCotntroller.clear();
  }
}
