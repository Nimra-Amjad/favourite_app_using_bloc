import 'package:favourite_app_using_bloc/bloc/favourite_bloc.dart';
import 'package:favourite_app_using_bloc/repository/favourite_repo.dart';
import 'package:favourite_app_using_bloc/ui/favouriteApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FavouriteBloc(FavouriteRepository()))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        home: const FavouriteApp(),
      ),
    );
  }
}
