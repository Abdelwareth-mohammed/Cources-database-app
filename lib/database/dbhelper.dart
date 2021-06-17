import 'package:courses/models/course.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/course.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper.internal();
  factory DbHelper() => _instance;
  DbHelper.internal();
  static Database _db;
  Future<Database> createdatabase() async {
    if (_db != null) {
      return _db;
    }

    String path = join(await getDatabasesPath(), 'school.db');
    _db = await openDatabase(path, version: 1, onCreate: (Database db, int v) {
      db.execute('create table courses(id integer primary key autoincrement' +
          ',name varchar(50),content varchar(255),hours integer)');
    });
    return _db;
  }

  Future<int> createCourse(Course course) async {
    Database db = await createdatabase();
    return db.insert('courses', course.toMap());
  }

  Future<List> allCourses() async {
    Database db = await createdatabase();
    return db.query('courses');
  }

  Future<int> delete(int id) async {
    Database db = await createdatabase();
    return db.delete('courses', where: 'id=?', whereArgs: [id]);
  }

  Future<int> update(Course course) async {
    Database db = await createdatabase();
    return db.update('courses', course.toMap(),
        where: 'id=?', whereArgs: [course.id]);
  }
}
