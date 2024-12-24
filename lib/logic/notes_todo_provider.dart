import 'package:flutter/material.dart';
import 'package:notes_todo_app_provider/logic/sqlhelper.dart';

class DatabaseProvider with ChangeNotifier {
  final SQLHelper _sqlHelper = SQLHelper();

  Future<List<Map>> loadNotes() async {
    return _sqlHelper.loadNotes();
  }

  Future<void> insertNote(Note note) async {
    await _sqlHelper.insertNote(note);
    notifyListeners();
  }

  Future<void> insertTodo(Todo todo) async {
    await _sqlHelper.insertTodo(todo);
    notifyListeners();
  }

  Future<void> deleteNote(int id) async {
    await _sqlHelper.deleteNote(id);
    notifyListeners();
  }

  Future<void> updateNote(Note newNote) async {
    await _sqlHelper.updateNote(newNote);
    notifyListeners();
  }

  Future<void> updateTodoChecked(int id, int currentValue) async {
    await _sqlHelper.updateTodoChecked(id, currentValue);
    notifyListeners();
  }

  Future<void> deleteAllNotes() async {
    await _sqlHelper.deleteAllNotes();
    notifyListeners();
  }

  Future<void> deleteAllTodos() async {
    await _sqlHelper.deleteAllTodos();
    notifyListeners();
  }
}
