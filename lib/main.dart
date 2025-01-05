import 'package:flutter/material.dart';
import 'package:trainings_app/providers/filter_provider.dart';
import 'package:trainings_app/providers/training_provider.dart';
import 'package:trainings_app/screens/training_home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TrainingProvider()),
        ChangeNotifierProvider(create: (_) => FilterProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const TrainingHomeScreen(),
        theme: ThemeData(
          primaryColor: Colors.red,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.red[900],
            elevation: 0,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          textTheme: const TextTheme(
            titleMedium: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            displayLarge: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            bodyLarge: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
            bodyMedium: TextStyle(
              color: Colors.black87,
              fontSize: 15,
            ),
            bodySmall: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    ),
  );
}
