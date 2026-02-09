import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_c17_online/core/internet_checker.dart';
import 'package:news_c17_online/core/observer.dart';
import 'package:news_c17_online/core/theming/cubit/cubit.dart';
import 'package:news_c17_online/core/theming/cubit/states.dart';
import 'package:news_c17_online/screens/home_screen.dart';

import 'di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  configureDependencies();
  getIt<InternetConnectivity>().initialize();
  runApp(
    BlocProvider(
      create: (context) => getIt<ThemingCubit>(),
      child: BlocBuilder<ThemingCubit, ThemingStates>(
        builder: (context, state) {
          return MyApp();
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {HomeScreen.routeName: (context) => HomeScreen()},
    );
  }
}
