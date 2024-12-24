import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLHelper {
  ///////// GET DATABASE //////////
  Database? database;
  getDatabase() async {
    if (database != null) return database;
    database = await initDatabase();
    return database;
  }

  //////////// INITIALIZE DATABASE ////////////
  //////////// CREATE & UPGRADE ///////////////

  initDatabase() async {
    String path = join(await getDatabasesPath(), 'gdsc_benha4.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        Batch batch = db.batch();
        batch.execute('''
          CREATE TABLE notes (
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  title TEXT,
                  content TEXT
          )
          ''');

        batch.execute('''
          CREATE TABLE todos (
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  title TEXT,
                  value INTEGER
          )
          ''');
        batch.commit();
      },
    );
  }

  // CRUD

  /////////////// INSERT DATA INTO DATABASE ///////////
  insertNote(Note note) async {
    Database db = await getDatabase();
    Batch batch = db.batch();
    batch.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    batch.commit();
  }

  insertTodo(Todo todo) async {
    Database db = await getDatabase();
    Batch batch = db.batch();
    batch.insert(
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    batch.commit();
  }

  /////////////// RETRIEVE DATA FROM DATABASE /////////
  Future<List<Map>> loadNotes() async {
    Database db = await getDatabase();
    List<Map> maps = await db.query('notes');
    return maps;
  }

  Future<List<Map>> loadTodos() async {
    Database db = await getDatabase();
    List<Map> maps = await db.query('todos');
    return maps;
  }

  /////////////// UPDATE DATA IN DATABASE /////////////

  updateNote(Note newNote) async {
    Database db = await getDatabase();
    await db.update(
      'notes',
      newNote.toMap(),
      where: 'id=?',
      whereArgs: [newNote.id],
    );
  }

  updateTodoChecked(int id, int currentValue) async {
    Database db = await getDatabase();
    Map<String, dynamic> values = {
      'value': currentValue == 0 ? 1 : 0,
    };
    await db.update(
      'todos',
      values,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //////////////// DELETE DATA FROM DATABASE //////////

  deleteNote(int id) async {
    Database db = await getDatabase();
    await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  deleteAllNotes() async {
    Database db = await getDatabase();
    await db.delete('notes');
  }

  deleteAllTodos() async {
    Database db = await getDatabase();
    await db.delete('todos');
  }
}

class Note {
  final int? id;
  final String title;
  final String content;

  Note({
    this.id,
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }
}

class Todo {
  final int? id;
  final String title;
  int value;

  Todo({
    this.id,
    required this.title,
    this.value = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'value': value,
    };
  }
}
