import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:period_tracker_app/bloc/period_bloc.dart';
import 'package:period_tracker_app/data/datasource/local_data_source.dart';
import 'package:period_tracker_app/services/storage_service.dart';
import 'package:period_tracker_app/splash/splash_screen.dart';
import 'package:period_tracker_app/theme/app_theme.dart';

void main()async {
  // await Hive.initFlutter();
  // await Hive.openBox('cycleBox');
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDataSource.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PeriodBloc(
        StorageService()
      ),
      child: MaterialApp(
          title: 'Luna-Period Tracker',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: const SplashScreen()),
    );
  }
}
