import 'package:flutter/material.dart';
import 'package:path/path.dart';
import './newcourse.dart';
import '../database/dbhelper.dart';
import '../models/course.dart';
import '../pages/course_details.dart';
import '../pages/course_update.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _HomeState();
  DbHelper helper;

  var builder;

  void initState() {
    super.initState();
    setState(() {
      _HomeState hn = widget.createState();
    });
    helper = DbHelper();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.amberAccent,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.brown,
          ),
          backgroundColor: Colors.tealAccent,
          title: Text("Courses", style: TextStyle(color: Colors.brown)),
          actions: [
            IconButton(
                //color: Colors.green[800],
                icon: Icon(
                  Icons.add,
                ),
                onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NewCourse(),
                      ),
                    ))
          ],
        ),
        body: FutureBuilder(builder: (context, snapshot) {
          return FutureBuilder(
            future: helper.allCourses(),
            builder: (Context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return (CircularProgressIndicator());
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (Context, i) {
                      Course course = Course.fromMap(snapshot.data[i]);
                      return Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                          color: Colors.grey[400],
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              '${course.name}  ${course.hours} ',
                              style: TextStyle(color: Colors.brown),
                            ),
                            subtitle: Text('${course.content}',
                                maxLines: 3,
                                style: TextStyle(color: Colors.brown)),
                            trailing: Column(
                              children: <Widget>[
                                Expanded(
                                  child: IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Colors.red,
                                    onPressed: () {
                                      setState(() {
                                        helper.delete(course.id);
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                    child: IconButton(
                                  icon: Icon(Icons.edit, size: 25),
                                  color: Colors.green,
                                  onPressed: () {
                                    setState(() {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            CourseUpdate(course),
                                      ));
                                    });
                                  },
                                )),
                              ],
                            ),
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CourseDetails(course),
                            )),
                          ),
                        ),
                      );
                    });
              }
            },
          );
        }));
  }
}
