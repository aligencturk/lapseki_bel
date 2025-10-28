import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/constants/app_colors.dart';
import 'core/localization/app_localizations.dart';
import 'viewmodels/locale_viewmodel.dart';
import 'viewmodels/home_viewmodel.dart';
import 'viewmodels/discover_viewmodel.dart';
import 'viewmodels/events_viewmodel.dart';
import 'viewmodels/ferry_viewmodel.dart';
import 'viewmodels/emunicipality_viewmodel.dart';
import 'ui/views/home/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => DiscoverViewModel()),
        ChangeNotifierProvider(create: (_) => EventsViewModel()),
        ChangeNotifierProvider(create: (_) => FerryViewModel()),
        ChangeNotifierProvider(create: (_) => EMunicipalityViewModel()),
      ],
      child: Consumer<LocaleViewModel>(
        builder: (context, localeViewModel, child) {
          return MaterialApp(
            title: 'Lapseki Belediye',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: AppColors.primaryBlue,
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primaryBlue,
                primary: AppColors.primaryBlue,
                secondary: AppColors.accentRed,
              ),
              useMaterial3: true,
              scaffoldBackgroundColor: AppColors.backgroundColor,
              cardTheme: CardThemeData(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              appBarTheme: const AppBarTheme(elevation: 0, centerTitle: true),
            ),
            locale: localeViewModel.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('tr'), Locale('en')],
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(const App());
}
