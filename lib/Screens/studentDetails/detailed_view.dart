import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class DetaildView extends StatelessWidget {
  final String name;
  final String age;
  final String phone;
  final String email;
  File? image;

  DetaildView(
      {super.key,
      required this.name,
      required this.age,
      required this.phone,
      required this.email,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          decoration:const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/students_09.jpg'),opacity: 0.1),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              CircleAvatar(
                radius: 60,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:  Colors.redAccent,
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(60),
                      child: (image != null)
                          ? Image.file(
                              image!,
                              fit: BoxFit.cover,
                            )
                          : Image.asset('assets/images/user02.jpg'),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              Text(
                name,
                style: GoogleFonts.aclonica(
                  fontSize: 20,
                  color: Colors.redAccent[200],
                ),
              ),
              ShowAsRow(title: 'Age', value: age),
              ShowAsRow(title: 'Phone', value: phone),
              ShowAsRow(title: 'e-mail', value: email)
            ],
          ),
        ),
      ),
    );
  }
}

class ShowAsRow extends StatelessWidget {
  final String title;
  final String value;
  const ShowAsRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.aclonica(
              fontSize: 15,
              color: Colors.blueAccent,
            ),
          ),
           Text(
            ' : ',
            style: GoogleFonts.aclonica(),
          ),
          Text(
            value,
            style: GoogleFonts.aclonica(
              fontSize: 12,
              color: Colors.black54
            ),
          ),
        ],
      ),
    );
  }
}
