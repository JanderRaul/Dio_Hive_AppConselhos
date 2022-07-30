import 'dart:collection';

import 'package:dio_hive_appconselhos/adapters/conselho_hive_adapter.dart';
import 'package:dio_hive_appconselhos/models/conselhos_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class FavoritasRepository extends ChangeNotifier {
  List<Conselhos> _lista = [];
  late LazyBox box;

  FavoritasRepository() {
    _startRepository();
  }

  _startRepository() async {
    await _openBox();
    await _readFavoritas();
  }

  _openBox() async {
    Hive.registerAdapter(ConselhoHiveAdapter());
    box = await Hive.openLazyBox<Conselhos>('conselhos_favoritos');
  }

  _readFavoritas() {
    box.keys.forEach((element) async {
      Conselhos c = await box.get(element);
      _lista.add(c);
      notifyListeners();
    });
  }

  UnmodifiableListView<Conselhos> get lista => UnmodifiableListView(_lista);

  save(Conselhos conselho) {
    if (!_lista.any((atual) => atual.slip!.id == conselho.slip!.id)) {
      _lista.add(conselho);
      box.put(conselho.slip!.id, conselho);
    }
    notifyListeners();
  }

  remove(Conselhos conselho) {
    _lista.remove(conselho);
    box.delete(conselho.slip!.id);
    notifyListeners();
  }
}
