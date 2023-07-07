import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_record/Screens/studentPages/search_page.dart';
import 'package:student_record/database/models/studentModel.dart';
import 'package:student_record/database/functions/db_functions.dart';

import '../../Widgets/input_bottom_sheet.dart';
import '../studentDetails/detailed_view.dart';
import 'input_page.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    getAllData();
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/students_09.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/user02.jpg'),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const SearchPage();
                  },
                ));
              },
              icon: const Icon(
                Icons.search,
              ),
            ),
          ],
          title: Text(
            'Student Record',
            style: GoogleFonts.aclonica(),
          ),
        ),
        backgroundColor: const Color.fromARGB(241, 243, 241, 241),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: studentNotifier,
                        builder: (context, student, child) {
                          if (student.isEmpty) {
                            return Center(
                              child: Text(
                                'No student details yet. Click + to add.',
                                style: GoogleFonts.aclonica(),
                              ),
                            );
                          } else {
                            return ListView.separated(
                                itemBuilder: (ctx, index) {
                                  StudentModel stu = student[index];
                                  File? image;
                                  if (stu.imgPath != 'no-img') {
                                    image = File(stu.imgPath!);
                                  }
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (ctx) => DetaildView(
                                                name: stu.name,
                                                age: stu.age,
                                                phone: stu.phone,
                                                email: stu.mail,
                                                image: image),
                                          ),
                                        );
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
                                                : Image.asset(
                                                    'assets/images/user02.jpg'),
                                          ),
                                        ),
                                      ),
                                      trailing: SizedBox(
                                        width: 150,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                bottomSheet(context, stu);
                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Color.fromARGB(
                                                    255, 87, 94, 107),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                deleteAlert(
                                                    context, student[index]);
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Color.fromARGB(
                                                    255, 225, 99, 90),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (ctx, index) {
                                  return const SizedBox(
                                    height: 5,
                                  );
                                },
                                itemCount: student.length);
                          }
                        }),
                  ),
                ],
              )),
        ),
        floatingActionButton: FloatingActionButton(
          shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => InputPage(),
            ));
          },
          child: const Icon(Icons.add_box_rounded),
        ),
      ),
    );
  }
}

Future<dynamic> bottomSheet(BuildContext context, StudentModel student) async {
  return await showModalBottomSheet(
      context: context,
      builder: ((BuildContext ctx) {
        return SizedBox(
          height: 660,
          child: InputBottonSheet(
            student: student,
          ),
        );
      }));
}

Future<void> deleteAlert(BuildContext context, StudentModel student) async {
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(
            'Confirm Delete?',
            style: GoogleFonts.aclonica(),
          ),
          backgroundColor: Color.fromARGB(255, 197, 201, 204),
          content: Text('Are you sure you want to delete this item?',
              style: GoogleFonts.aclonica()),
          actions: [
            TextButton(
                onPressed: () {
                  deleteStudent(student);
                  Navigator.of(ctx).pop();
                },
                child: Text('Yes', style: GoogleFonts.aclonica())),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('No', style: GoogleFonts.aclonica()),
            ),
          ],
        );
      });
}
