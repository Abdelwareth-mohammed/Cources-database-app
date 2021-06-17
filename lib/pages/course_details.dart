import 'package:courses/models/course.dart';
import 'package:flutter/material.dart';

class CourseDetails extends StatelessWidget {
  Course course;
  CourseDetails(this.course);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.brown,
        ),
        backgroundColor: Colors.tealAccent,
        title: Text("Course Details", style: TextStyle(color: Colors.brown)),
      ),
      body: Container(
        color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Center(
                  child: Text(course.name,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30))),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(course.content,
                      style: TextStyle(color: Colors.black, fontSize: 20))),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(course.hours.toString(),
                      style: TextStyle(color: Colors.black, fontSize: 15))),
              SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
