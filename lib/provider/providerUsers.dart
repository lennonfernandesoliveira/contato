import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummyUsers.dart';
import 'package:flutter_crud/models/user.dart';

class ProviderUsers with ChangeNotifier {
  final Map<String, User> _items = {...DUMMYUSERS};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(User user) {
    if (user != null) {
      if (user.id != null &&
          user.id.isNotEmpty &&
          _items.containsKey(user.id)) {
        _items.update(
            user.id,
            (value) => User(
                id: user.id,
                nome: user.nome,
                email: user.email,
                urlImagem: user.urlImagem,
                telefone: user.telefone
                    .replaceAll(" ", "")
                    .replaceAll("-", "")
                    .replaceAll("(", "")
                    .replaceAll(")", "")));
      } else {
        final id = Random().nextDouble().toString();

        _items.putIfAbsent(
            id,
            () => User(
                id: id,
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

  void remove(User user) {
    if (user != null && user.id != null && user.id.isNotEmpty) {
      _items.remove(user.id);
      notifyListeners();
    }
  }
}
