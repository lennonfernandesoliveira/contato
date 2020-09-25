import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummyUsers.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/DataBaseHelper.dart';

class ProviderUsers with ChangeNotifier {
  ProviderUsers() {
    this.carregar();
  }
  Map<String, User> _items = {};
  final dbHelper = DatabaseHelper.instance;

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void carregar() async {
    _items.clear();
    final todasLinhas = await dbHelper.queryAllRows();
    User usuario;
    for (var n in todasLinhas) {
      usuario = new User(
          id: n['id'].toString(),
          nome: n['nome'],
          email: n['email'],
          urlImagem: n['urlImagem'] != null ? n['urlImagem'] : null,
          telefone: n['telefone']);
      _items.putIfAbsent(usuario.id, () => usuario);
    }
    notifyListeners();
  }

  void put(User user) async {
    if (user != null) {
      Map<String, dynamic> row = {
        DatabaseHelper.columnNome: user.nome,
        DatabaseHelper.columnEmail: user.email,
        DatabaseHelper.columnUrlImagem: user.urlImagem,
        DatabaseHelper.columnTelefone: user.telefone
            .replaceAll(" ", "")
            .replaceAll("-", "")
            .replaceAll("(", "")
            .replaceAll(")", ""),
        DatabaseHelper.columnId: user.id != null ? user.id.toString() : null
      };
      if (user.id != null &&
          user.id.isNotEmpty &&
          _items.containsKey(user.id)) {
        final id = await dbHelper.update(row);
        _items.update(
            user.id,
            (value) => User(
                id: id.toString(),
                nome: user.nome,
                email: user.email,
                urlImagem: user.urlImagem,
                telefone: user.telefone
                    .replaceAll(" ", "")
                    .replaceAll("-", "")
                    .replaceAll("(", "")
                    .replaceAll(")", "")));
      } else {
        final id = await dbHelper.insert(row);
        _items.putIfAbsent(
            id.toString(),
            () => User(
                id: id.toString(),
                nome: user.nome,
                email: user.email,
                urlImagem: user.urlImagem,
                telefone: user.telefone
                    .replaceAll(" ", "")
                    .replaceAll("-", "")
                    .replaceAll("(", "")
                    .replaceAll(")", "")));
      }

      notifyListeners();
    }
  }

  void remove(User user) async {
    if (user != null && user.id != null && user.id.isNotEmpty) {
      final linhaDeletada = await dbHelper.delete(int.parse(user.id));
      _items.remove(user.id);
      notifyListeners();
    }
  }
}
