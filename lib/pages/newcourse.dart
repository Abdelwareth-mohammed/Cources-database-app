import 'package:courses/database/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../models/course.dart';
import '../pages/home.dart';
import 'package:toast/toast.dart';

class NewCourse extends StatefulWidget {
  @override
  _NewCourseState createState() => _NewCourseState();
}

class _NewCourseState extends State<NewCourse> {
  Home home = new Home();
  String name, content;
  int hours;
  DbHelper helper;
  @override
  void initState() {
    super.initState();
    helper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.tealAccent,
        appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.brown,
            ),
            backgroundColor: Colors.green[300],
            title: Text(
              "New Course",
              style: TextStyle(color: Colors.brown),
            )),
        body: Padding(
            padding: const EdgeInsets.all(12),
            child: Form(
                child: SingleChildScrollView(
                    child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    fillColor: Colors.grey,
                    filled: true,
                    hintText: 'Enter Course Name',
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black)),
                  ),
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  style: TextStyle(
                      color: Colors.black,
                      backgroundColor: Colors.grey,
                      fontSize: 15),
                  maxLines: 3,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey,
                    hintText: 'Enter Course Content',
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal)),
                  ),
                  onChanged: (value) {
                    setState(() {
                      content = value;
                    });
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      fillColor: Colors.grey,
                      filled: true,
                      hintText: 'Enter Course Hours',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal))),
                  onChanged: (value) {
                    setState(() {
                      hours = int.parse(value);
                    });
                  },
                ),
                SizedBox(height: 15),
                Container(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green[300]),
                      ),
                      onPressed: () async {
                        {
                          if ((name == null ||
                              content == null ||
                              hours == null)) {
                            Toast.show("there's null value", context,
                                duration: 1, gravity: Toast.CENTER);
                          } else {
                            Course course = Course({
                              'name': name,
                              'content': content,
                              'hours': hours
                            });
                            int id = await helper.createCourse(course);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Home()));
                          }
                          ;
                        }
                      },
                      child: Text("Save",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ))),
                )
              ],
            )))));
  }
}
