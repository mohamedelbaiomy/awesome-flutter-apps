import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlHelper {
  Database? database;

  getDatabase() async {
    if (database != null) {
      return database;
    } else {
      database = await initDatabase();
      return database;
    }
  }

  initDatabase() async {
    String path = join(await getDatabasesPath(), 'baiomy.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, index) {
        Batch batch = db.batch();
        batch.execute('''
           CREATE TABLE notes (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT,
              content TEXT
           )
        ''');
        batch.commit();
      },
    );
  }

  Future addNote(Note newNote) async {
    Database db = await getDatabase();
    await db.insert(
      'notes',
      newNote.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map>> loadData() async {
    Database db = await getDatabase();
    return await db.query('notes');
  }

  Future updateNote(Note newNote) async {
    Database db = await getDatabase();
    await db.update(
      'notes',
      newNote.toMap(),
      where: 'id=?',
      whereArgs: [newNote.id],
    );
  }

  Future deleteNote(int id) async {
    Database db = await getDatabase();
    await db.delete(
      'notes',
      where: 'id=?',
      whereArgs: [id],
    );
  }

  Future deleteAllNotes() async {
    Database db = await getDatabase();
    await db.delete('notes');
  }
}

class Note {
  int? id;
  String title;
  String content;

  Note({this.id, required this.title, required this.content});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }
}
