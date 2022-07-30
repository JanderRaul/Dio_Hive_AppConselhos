import 'package:dio_hive_appconselhos/controllers/conselhos_controller.dart';
import 'package:dio_hive_appconselhos/repository/favoritas_repository.dart';
import 'package:dio_hive_appconselhos/views/FavoritasPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final controller = ConselhosController();
  bool isFavorite = false;
  late FavoritasRepository favoritas;

  @override
  void initState() {
    super.initState();
    controller.start();
  }

  _success() {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Center(
                child: SelectableText(
                  controller.conselhos.slip!.advice!,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      favoritas.save(controller.conselhos);
                      isFavorite = !isFavorite;
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                        color:
                            !isFavorite ? Colors.redAccent : Colors.greenAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Center(
                          child: !isFavorite
                              ? const Text(
                                  'Favorite',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _error() {
    return const Text('Algo deu errado');
  }

  _loading() {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  _start() {
    return const Text('Estado inicial');
  }

  stateManagement(HomeState state) {
    switch (state) {
      case HomeState.start:
        return _start();
      case HomeState.loading:
        return _loading();
      case HomeState.error:
        return _error();
      case HomeState.sucess:
        return _success();
      default:
        return _start();
    }
  }

  @override
  Widget build(BuildContext context) {
    favoritas = Provider.of<FavoritasRepository>(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                'assets/image.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.menu_rounded,
                        color: Colors.black,
                        size: 32,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          controller.start();
                          isFavorite = !isFavorite;
                        },
                        child: const Icon(
                          Icons.refresh,
                          color: Colors.black,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FavoritasPage()));
                        },
                        child: const Icon(
                          Icons.person_outline_rounded,
                          color: Colors.black,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text('Advices', style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.w600),),
                  const Spacer(),
                  AnimatedBuilder(
                    animation: controller.state,
                    builder: (context, child) {
                      return stateManagement(controller.state.value);
                    },
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
