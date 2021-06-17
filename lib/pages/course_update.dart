import 'package:courses/database/dbhelper.dart';
import 'package:courses/models/course.dart';
import 'package:flutter/material.dart';
import './home.dart';
import 'package:toast/toast.dart';

class CourseUpdate extends StatefulWidget {
  Course course;
  CourseUpdate(this.course);
  @override
  _CourseUpdateState createState() => _CourseUpdateState();
}

class _CourseUpdateState extends State<CourseUpdate> {
  TextEditingController teName = TextEditingController();
  TextEditingController teContent = TextEditingController();
  TextEditingController teHours = TextEditingController();
  DbHelper helper;
  Course course;
  @override
  void initState() {
    super.initState();
    helper = DbHelper();
    teName.text = widget.course.name;
    teContent.text = widget.course.content;
    teHours.text = widget.course.hours.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.brown,
        ),
        backgroundColor: Colors.tealAccent,
        title: Text(
          "Course Update",
          style: TextStyle(color: Colors.brown),
        ),
      ),
      body: ListView(
        children: [
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey,
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.teal)),
            ),
            style: TextStyle(color: Colors.black, fontSize: 15),
            keyboardType: TextInputType.text,
            controller: teName,
          ),
          SizedBox(),
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey,
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.teal)),
            ),
            style: TextStyle(color: Colors.black, fontSize: 15),
            maxLines: 3,
            keyboardType: TextInputType.text,
            controller: teContent,
          ),
          SizedBox(),
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey,
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.teal)),
            ),
            style: TextStyle(color: Colors.black, fontSize: 15),
            keyboardType: TextInputType.number,
            controller: teHours,
          ),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green[400]),
              ),
              child: Text(" Save "),
              onPressed: () {
                if (teName.text.toString() == '' ||
                    teContent.text.toString() == '' ||
                    teHours.text.toString() == '') {
                  Toast.show("there's nullable field", context,
                      duration: 1, gravity: Toast.CENTER);
                } else {
                  var updatedcourse = Course({
                    'id': widget.course.id,
                    'name': teName.text,
                    'content': teContent.text,
                    'hours': int.parse(teHours.text),
                  });

                  helper.update(updatedcourse);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Home()));
                }
              }),
        ],
      ),
    );
  }
}
