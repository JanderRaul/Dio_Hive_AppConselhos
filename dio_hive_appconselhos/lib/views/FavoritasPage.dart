import 'package:dio_hive_appconselhos/repository/favoritas_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritasPage extends StatelessWidget {
  const FavoritasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(16),
        child:
            Consumer<FavoritasRepository>(builder: (context, favoritas, child) {
          return favoritas.lista.isEmpty
              ? const ListTile(
                  leading: Icon(Icons.star),
                  title: Text('Não possui nenhum conselho favorito'),
                )
              : ListView.builder(
                  itemCount: favoritas.lista.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      leading: Text('${favoritas.lista[index].slip!.id}'),
                      title: Text(favoritas.lista[index].slip!.advice.toString()),
                    );
                  });
        }),
      ),
    );
  }
}
