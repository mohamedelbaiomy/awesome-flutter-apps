import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/theme_provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
          return Column(
            spacing: 60,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  Text(
                    themeProvider.isDark ? "Dark" : "Light",
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  Switch(
                    value: themeProvider.isDark,
                    padding: EdgeInsets.all(5),
                    splashRadius: 0,
                    onChanged: (value) => themeProvider.changeTheme(),
                    activeColor: Colors.amber,
                    inactiveTrackColor: Colors.white70,
                    thumbColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                      if (states.contains(WidgetState.disabled)) {
                        return Theme.of(context).secondaryHeaderColor;
                      }
                      return Theme.of(context).primaryColor;
                    }),
                  ),
                ],
              ),
              Icon(
                themeProvider.isDark ? Icons.dark_mode : Icons.light_mode,
                size: 60,
              ),
            ],
          );
        }),
      ),
    );
  }
}
