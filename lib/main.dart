import 'package:expense_tracker_app/widgets/expenses.dart';
import 'package:expense_tracker_app/widgets/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(builder: (
        context,
        themeModel,
        child,
      ) {
        return MaterialApp(
          darkTheme: ThemeData.dark().copyWith(
            colorScheme: kDarkColorScheme,
          ),
          theme: ThemeData(
            colorScheme: kColorScheme,
            appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kColorScheme.onPrimaryContainer,
              foregroundColor: kColorScheme.primaryContainer,
            ),
            cardTheme: ThemeData().cardTheme.copyWith(
                  color: kColorScheme.secondaryContainer,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: kColorScheme.primaryContainer,
              ),
            ),
            textTheme: ThemeData().textTheme.copyWith(
                  titleLarge: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kColorScheme.onSecondaryContainer,
                  ),
                ),
          ),
          // check the system's theme (by default)
          themeMode: themeModel
              .themeMode, // set the themeMode using the getter of Themenotifier.
          home: const Expenses(),
        );
      }),
    ),
  );
}

// what do we want...
// the user can toggle between light and dark modes.
// there should be an additional functionality for the user to keep the theme based on the system.
// for this we will go with a button in the appBar
// the button will have three icon states (sun, moon, settings icon)
