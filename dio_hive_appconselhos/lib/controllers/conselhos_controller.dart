import 'package:dio_hive_appconselhos/repository/conselhos_repository.dart';
import 'package:flutter/material.dart';

import '../models/conselhos_model.dart';

class ConselhosController {
  Conselhos conselhos = Conselhos();
  final repositoryConselhos = ConselhoRepository();
  final state = ValueNotifier<HomeState>(HomeState.start);

  Future start() async {
    state.value = HomeState.loading;
    try {
      conselhos = await repositoryConselhos.getConselho();
      state.value = HomeState.sucess;
    } catch (e) {
      state.value = HomeState.error;
    }
  }
}

enum HomeState { start, loading, sucess, error }
