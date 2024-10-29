import 'package:expense_tracker_app/widgets/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const themeModes = [Icons.light_mode, Icons.dark_mode, Icons.settings];

class AppTheme extends StatefulWidget {
  const AppTheme({super.key});
  @override
  State<AppTheme> createState() {
    return _AppTheme();
  }
}

class _AppTheme extends State<AppTheme> {
  var currentThemeModeIndex = 0; // starting with the lightMode first.

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          currentThemeModeIndex++;
          // take mod with length for cyclic behaviour.
          currentThemeModeIndex %= 2; // taking mod only with 2 for now to hide the system's mode.
        });

        // Provider.of<ThemeNotifier>(context, listen: false).toggleTheme(currentThemeModeIndex)
        // ;
        // ThemeNotifier().toggleTheme(currentThemeModeIndex);
        Provider.of<ThemeNotifier>(context, listen: false)
            .toggleTheme(currentThemeModeIndex);
      },
      icon: Icon(
        themeModes[currentThemeModeIndex],
      ),
    );
  }
}
