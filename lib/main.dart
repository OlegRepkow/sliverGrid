import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_list/item_bloc/item_bloc.dart';
import 'package:grid_list/item_screen_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ItemsScreenPageWrapper(),
    );
  }
}

class ItemsScreenPageWrapper extends StatelessWidget {
  const ItemsScreenPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ItemBloc>(
      create: (context) => ItemBloc(),
      child: const ItemsScreenPage(),
    );
  }
}
